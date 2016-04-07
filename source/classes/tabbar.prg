/*
 * $Id
 */

/*
 * FivePhone source code:
 * Class TTabBar
 *
 * Copyright 2010 Antonio Linares <alinares@fivetechsoft.com>
 * www - http://www.fivetechsoft.com
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2, or (at your option)
 * any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this software; see the file COPYING.  If not, write to
 * the Free Software Foundation, Inc., 59 Temple Place, Suite 330,
 * Boston, MA 02111-1307 USA (or visit the web site http://www.gnu.org/).
 *
 * As a special exception, this project gives permission for
 * additional uses of the text contained in the release of Harbour.
 *
 * The exception is that, if you link these libraries with other
 * files to produce an executable, this does not by itself cause the
 * resulting executable to be covered by the GNU General Public License.
 * Your use of that executable is in no way restricted on account of
 * linking this library code into it.
 *
 * This exception does not however invalidate any other reasons why
 * the executable file might be covered by the GNU General Public License.
 *
 * This exception applies only to the code released by this
 * Project under the name FivePhone.  If you copy code from other
 * projects or Free Software Foundation releases into this project,
 * as the General Public License permits, the exception does
 * not apply to the code that you add in this way.  To avoid misleading
 * anyone as to the status of such modified files, you must delete
 * this exception notice from them.
 *
 * If you write modifications of your own for FivePhone, it is your choice
 * whether to permit this exception to apply to your modifications.
 * If you do not wish that, delete this exception notice.
 *
 */

#include "fivephone.ch"
#include "fmsgs.h"

CLASS TTabBar FROM TView

   DATA bChange
   DATA aView
   DATA nSelected

   METHOD New( oWnd )

   METHOD Resources( oWnd, idResource,aViews )   

   METHOD AddItem( nType, oView ) INLINE  ( CreateItemTabBar( ::hWnd, nType ), aadd(::aView,oView) )
     
   METHOD AddCustomItem( cTitle, cImage, oView ) INLINE  ( CreateCustomItemTabBar( ::hWnd, cTitle,cImage ), aadd(::aView,oView) )   
   
   METHOD nAt() INLINE TabBarAt( ::hWnd )
   
   METHOD HandleEvent( nMsg, hSender, uParam1, uParam2 )
   
   METHOD nTabs()INLINE TABITEMS(::hWnd)
       
ENDCLASS


METHOD New( oWnd,aItems,aViews,bChange,nSelected ) CLASS TTabBar
   local i,oView
   DEFAULT bChange:={ ||  aeval( Self:aView, {|o, i| iif( !empty(o) , o:lVisible := iif( i == Self:nat() , .t. ,.f. ) , )   }  ) } 
   DEFAULT nSelected := 1
 
   ::hWnd = CreateTabBar( oWnd:hWnd )
   ::aView:= {}
   ::nSelected = nSelected
    
for i=1 to len(aItems)
       
       if Empty(aViews) .or. (i> len(aViews))
	     DEFINE VIEW oView FROM 0,0 SIZE  ScreenWidth(), (ScreenHeight() - 49) OF oWnd	
	   else
		 oView:=aViews[i] 
	   endif 
	   oView:lVisible = .F.	
	   
	  if valtype(aItems[i])  == "C"
	     ::AddCustomItem(aItems[i],,oView)	
	  elseif valtype(aItems[i])  == "A"
	     ::AddCustomItem(aItems[i,1],aItems[i,2],oView)	
	  else
		 ::AddItem(aItems[i],oView)	  
	  endif
	 
  Next
   ::aView[nSelected]:lvisible:= .t.
  
   
   ::bChange = bChange
   
    AAdd( GetAllWin(), Self )
   
return Self


METHOD Resources( oWnd, idResource,aViews, bChange, nSelected ) CLASS TTabBar
   local i 
   local nAt
   
  DEFAULT nSelected := 1
   DEFAULT bChange:={ ||  aeval( Self:aView, {|o, i| iif( !empty(o) , o:lVisible := iif( i == Self:nat() , .t. ,.f. ) , )   }  ) }   
  
     
   ::hWnd =  CreateTabBarResources(oWnd:hWnd,idResource) 
   ::aView = {}
   ::nSelected = nSelected 
  
   
   for i=1 to ::nTabs()
        
	   if Empty(aViews) .or. (i> len(aViews))  
	        DEFINE VIEW oView FROM 0,0 SIZE  ScreenWidth(), (ScreenHeight() - 49) OF oWnd	
		else
		 oView:=aViews[i] 
		endif	
	    oView:lVisible = .F.	 
	    aadd(::aView ,oView)  
   Next  
    ::aView[nSelected]:lvisible:= .t.
	
	
	::bChange = bChange
   
   AAdd( GetAllWin(), Self )
 
return Self  



METHOD HandleEvent( nMsg, hSender, uParam1, uParam2 ) CLASS TTabBar
   
   local nAt

   do case
      case nMsg == WM_ITEMSEL
         nAt = ::nAt()
		 if ::nSelected != nAt
            ::aView[ ::nSelected ]:lVisible = .F.
            ::aView[ nAt ]:lVisible = .T.
            ::nSelected = nAt
            if ! Empty( ::bChange )
               Eval( ::bChange, Self, ::nAt(), ::nSelected )
            endif
         endif
   endcase
   
return nil               
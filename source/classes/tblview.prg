
/*
 * $Id
 */

/*
 * FivePhone source code:
 * Class TTableView
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

#define None 0
#define SingleLine 1
#define SingleLineEtched 2
 
CLASS TTableView FROM TView

   DATA   bData
   DATA   bCell
   DATA   aHeads
   DATA   cAlias
   DATA   nRowsSection
   DATA   bCellBack, bCellImage
   DATA   bSelect
   DATA   BackColor
   DATA   oSearch
   DATA   leditmode
 
   METHOD New( oWnd, nTop, nLeft, nWidth ,nHeight, bData,aHeads, lGroup, nCellHeight ,bCell, nCellStyle,nStyleAcessory )
   METHOD Resources( oWnd, idResource ,bData)   
   
   METHOD HandleEvent( nMsg, hSender, uParam1, uParam2 )

   METHOD SetBackClear INLINE SETBRWBACKCLEAR(::hWnd)
   
   METHOD SetSeparatorColor INLINE SetBrwSeparatorColor(::hwnd,nred,ngreen,nblue,nalfa)  
   
   METHOD SetSeparatorStyle INLINE SetBrwSeparatorStyle(::hwnd,nStyle)  
   
   METHOD CustomCells(ocel, ele, nStyle, nStyleAcessory, cDetailText )
   
   METHOD AddSearch()
   METHOD DelSearch() INLINE (::oSearch := nil ,DelSearchBrw (::hWnd) )   	 
   
   METHOD SetSearchMode(bchange,oNav )
   
    METHOD SetEditMode(lmode) INLINE (::lEditmode:= lmode , SetEditModeBrw(::hWnd,lmode) , ::reload() )
 	   
   METHOD Reload(bData)
	       
ENDCLASS


METHOD New( oWnd, nTop, nLeft, nWidth, nHeight, bData,aHeads, lGroup, nCellHeight ,bcell ,nCellStyle , nStyleAcessory ) CLASS TTableView
   
   DEFAULT nTop    :=  20+ If( ! Empty( oWnd:oNavBar ), oWnd:oNavBar:nHeight, 0 )   ,;
           nLeft   := 0 ,;
           nHeight := oWnd:nHeight - nTop ,; // - If( ! Empty( oWnd:oToolBar ), oWnd:oToolBar:nHeight, 0 ) ,;
		   nWidth  := ScreenWidth(),;   
		   lGroup  := .f.
	
	if valtype( bData ) == "A"
        ::cAlias:="array"
    else
	   if ! Empty( Alias() )
           ::cAlias := Alias()		   
    	endif   
	
   endif  
    
   
   if bData == nil 
      if Empty( ::cAlias )
         bData = { || "data " + AllTrim( Str( uParam1 + 1 ) ) }
       else
	     bData = { || (::calias)->(FieldGet( 1 )) }  
    	endif
   endif
   
   ::lEditmode:= .f.
   
   ::bData = bData
   
  
   
   ::aHeads := aHeads
   
   // ---------------  bcell asignament ---------------
   
    if !Empty(bcell)
		::bCell := bcell 
	else
	  if !Empty(nCellStyle) .or. !Empty(nStyleAcessory) 
	       ::bCell:={|ocel,o,ele| o:CustomCells(nCellStyle ,nStyleAcessory ) } 	
	  endif		
	endif
	    
   //------------------------------------------------
 
  
   if lGroup
         ::hWnd := CreateBrwGRP( oWnd:hWnd, nTop, nLeft, nwidth, nHeight,nCellHeight )
    else
       if nCellHeight == nil
         ::hWnd := CreateBrw( oWnd:hWnd, nTop, nLeft, nWidth, nHeight )
       else
         ::hWnd := CreateBrw( oWnd:hWnd, nTop, nleft, nWidth, nHeight, nCellHeight )
       endif      
   endif
  

  
   AAdd( GetAllWin(), Self )
   
return Self



METHOD Resources( oWnd, idResource, bData ) CLASS TTableView
 
    if valtype( bData ) == "A"
        ::cAlias:="array"
    else
	   if ! Empty( Alias() )
           ::cAlias := Alias()
	endif   
   endif    
     

   if bData == nil 
      if Empty( ::cAlias )
         bData = { || "data " + AllTrim( Str( uParam1 + 1 ) ) }
       else   
         bData = { || FieldGet( 1 ) }  
    	endif
   endif
    
    ::bData = bData
   ::lEditmode:= .f.
   
   ::hWnd = GetControlResource( oWnd:hWnd,idResource )
     CreateBrwResources(::hWnd)

    AAdd( GetAllWin(), Self )
 
return Self  

/****************************************************************************/

METHOD CustomCells( nStyle, nStyleAcessory, cDetailText ) CLASS TTableView
local oCelda
 DEFAULT nStyle:= 0 ,;
         nStyleAcessory := 0 ,;
         cDetailText := nil 
		 
       oCelda:= TTableViewCell():new(nStyle, nStyleAcessory, cDetailText )

Return oCelda:hWnd

/****************************************************************************/

METHOD AddSearch() CLASS TTableView

 ::oSearch:= TSearch():Freenew(0,0,320,44 )
 AaddSearchBrw(::hWnd,::oSearch:hWnd)
   		
Return nil

/****************************************************************************/

METHOD Reload(bData) CLASS TTableView
	if !empty(bData)
		 ::bData:= bData
	endif
	ReloadBrw(::hWnd)
Return nil

/****************************************************************************/

METHOD SetSearchMode( bchange,oNav ) CLASS TTableView

local nStyle
   if ::oSearch == nil
			::addSearch()		  	  
	    ::oSearch:bchange:= bchange  	
		  nStyle:= 0
					
	else
	    ::delSearch()
	   	nStyle:= 12
				
	endif
	oNav:Setbutton( "right" ,"system" ,nStyle  )
	 

Return nil


/****************************************************************************/


METHOD HandleEvent( nMsg, hSender, uParam1, uParam2 ) CLASS TTableView
local oCell

   do case
      case nMsg == WM_BRWROWS
	        
            if ::cAlias == "array"
			    if  ::lEditmode
				    aadd(::bData, "add new row" )
				endif	
                Return Len( ::bData )
				
            else 
			    if ! Empty( ::calias )
				    return (::calias)->(OrdKeycount() )
			    else 
	       		    return 10 
				endif	
            endif
			
      case nMsg == WM_CELLSTYLE
	  
           if ::cAlias == "array"
		      if ::lEditmode
		       if uParam1 + 1 == len(::bData)
			      return 2
				else
				  Return 1
				endif  
			  else	    		   
	           return 0
			  endif 
           else   
				if ! Empty( ::calias )
				  if ::lEditmode
				    if uParam1 + 1 == (::calias)->(OrdKeycount() )
			      return 2
				else
				  Return 1
				endif  
			  else	    		   
	           return 0
			  endif 													
					
				endif 
			  
				return Eval( ::bData, Self )
          
		   endif		       
                   
      case nMsg == WM_BRWVALUE
           if ::cAlias == "array"
              return ::bData[ uParam1 + 1]
           else   
				if ! Empty( ::calias )
					(::calias)->(ordkeygoto( uParam1 +1))  
				endif 
			  
				return Eval( ::bData, Self )
          
		   endif
       case nMsg == WM_BRWCELL
	      oCell := uParam1 
		  if !Empty(::bCell)
	         ocell:= Eval(::bCell,ocell,Self,uParam2)
		  endif 	 
          Return oCell	
      case nMsg == WM_BRWHEAD
           if Empty( ::aHeads )
              Return nil
           else
              Return ::aHeads[ uParam1 + 1 ]
           endif
            
      case nMsg == WM_BRWCELLBACK
           if ! Empty( ::bCellBack )
              return Eval( ::bCellBack, Self )
           endif         
            
      case nMsg == WM_BRWCELLIMAGE
           if ! Empty( ::bCellImage )
              return Eval( ::bCellImage, Self )
           endif          
		   
	  case nMsg == WM_BRWSELECT
	       if ! Empty( ::bSelect )
		        return Eval( ::bSelect, uParam1 + 1, uParam2 + 1, Self )
		   endif
   endcase
   
return nil                
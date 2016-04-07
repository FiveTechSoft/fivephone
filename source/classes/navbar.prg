/*
 * $Id
 */

/*
 * FivePhone source code:
 * Class TNavBar
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




CLASS TNavBar FROM TView

   DATA  bLeftClick, bRightClick
   DATA  aItems

   METHOD New( oWnd, cTitle, cLeft, cRight, nHeight, bLeftClick, bRightClick, lsearch )
   
   METHOD LeftClick() INLINE If( ! Empty( ::bLeftClick ), Eval( ::bLeftClick, Self ),)

   METHOD RightClick() INLINE If( ! Empty( ::bRightClick ), Eval( ::bRightClick, Self ),)
   
   METHOD SetColor(nRed,nGreen,nBlue,nAlfa) INLINE SetTintNavBar(::hWnd,nRed,nGreen,nBlue,nAlfa)
   
   METHOD SetTrasLucent() INLINE SetTrasluNavBar(::hWnd)
   
   METHOD SetStyle(nStyle) INLINE  SetStyleNavBar(::hWnd,nStyle)
   
  METHOD HandleEvent( nMsg, hSender, uParam1, uParam2 )

  METHOD SetButton( cAlign ,cType ,xdato,nStyle  )
  
  METHOD SetBackStyle(cTitle) INLINE SETBACKNAVBARITEM(::hWnd, cTitle)
  
  //  METHOD SetButtonleftSystem (nSysItem)  INLINE SetNavBarLeftSystemButtonItem(GetNavBarItem(::hWnd) ,nSysItem )
  //  METHOD SetButtonRightSystem(nSysItem) INLINE SetNavBarRightSystemButtonItem(GetNavBarItem(::hWnd),nSysItem )
  //  METHOD SetButtonleftImage(cImage,nStyle)  INLINE SetNavBarLeftImageButtonItem(GetNavBarItem(::hWnd) ,cImage, nStyle)
  //  METHOD SetButtonRightImage(cimage,nStyle) INLINE SetNavBarRightImageButtonItem(GetNavBarItem(::hWnd),cImage,nStyle)
  
  METHOD SetTitle(cTitle) INLINE SetTitleNavBarItem(GetNavBarItem(::hWnd) ,cTitle)
  METHOD SetPrompt(cprompt) INLINE SetPromptNavBarItem(GetNavBarItem(::hWnd) ,cprompt)
  
   
ENDCLASS

/****************************************************************************/

METHOD New( oWnd, cTitle, cLeft, cRight, nHeight, bLeftClick, bRightClick ,lbackStyle, lsearch,oBrwsearch ) CLASS TNavBar
   DEFAULT nHeight := 65 ,lbackStyle :=.f. ,lSearch:= .f.
   
   ::aItems:={}
   ::bLeftClick :=  bLeftClick
   ::bRightClick := bRightClick
   
   ::hWnd = CreateNavBar( oWnd:hWnd, nHeight, cTitle, cLeft, cRight )
   if lbackStyle
      ::SetBackStyle(cLeft)
   endif
   
   if lsearch
   		::Setbutton( "right" ,"system" ,12  )	  		   		
   endif
   
   
  AAdd( GetAllWin(), Self ) 
   
//   oWnd:oNavBar = Self

      
return Self

/****************************************************************************/


/****************************************************************************/

METHOD Setbutton( cAlign ,cType ,xdato,nStyle  ) CLASS TNavBar
local cImage,nSysItem

DEFAULT nStyle := 1
   
  if cType == "image"
    cImage := xDato   
    if cAlign == "left"
 	      SetNavBarLeftImageButtonItem(GetNavBarItem(::hWnd) ,cImage,nStyle)
 		elseif calign == "right"
        SetNavBarRightImageButtonItem(GetNavBarItem(::hWnd),cImage,nStyle) 
 		endif
 elseif cType == "system"
    nSysItem := xDato   
    if cAlign == "left"
        SetNavBarLeftSystemButtonItem(GetNavBarItem(::hWnd),nSysItem  )
    elseif calign == "right"
        SetNavBarRightSystemButtonItem(GetNavBarItem(::hWnd),nSysItem )
    endif
endif
 
Return nil





METHOD HandleEvent( nMsg, hSender, uParam1, uParam2 ) CLASS TNavBar
    
    do case
      case nMsg == WM_BARLEFTCLICK
  
              ::LeftClick()
          
      case nMsg == WM_BARRIGHTCLICK
             ::RightClick()
               
   endcase
   
return nil     



 






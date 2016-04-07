/*
 * $Id
 */

/*
 * FivePhone source code:
 * Class TGet
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

CLASS TGet FROM TView
   
   DATA bChange, bWhen, bValid
   DATA bSetGet
   DATA uValue

     
   METHOD New( oWnd,  bSetGet, nTop, nLeft, nWidth, nHeight, bChange, cCueText, lPassword, cPict,bwhen,bValid ) 
   METHOD Resources( oWnd, bSetGet, idResource, bChange, cCueText, lPassword, cPict,bWhen,bValid )

   METHOD SetColor( nRed, nGreen, nBlue ) INLINE SetTextColor( ::hWnd, nRed, nGreen, nBlue )

   METHOD SetFont( cFaceName, nHeight ) INLINE SetTextFont( ::hWnd, cFaceName, nHeight )
   
   METHOD SetPlaceHolder( cTitle ) INLINE SetPlaceHolderText( ::hWnd, cTitle )
   
   METHOD SetSecure() INLINE SetSecureText( ::hWnd )
   
   METHOD HandleEvent( nMsg, uParam1, uParam2 )
   
ENDCLASS

METHOD New( oWnd, bSetGet, nTop, nLeft, nWidth, nHeight, bChange, cCueText, lPassword, cPict , bWhen, bValid ) CLASS TGet

   local cText := Space( 30 )

   DEFAULT nTop := 79, nLeft := 199, nWidth := 150, nHeight := 9 ,;
           bSetGet := bSETGET( cText ), lPassword:= .f. 
   
   ::uValue = Eval( bSetGet )
   
   ::bSetGet := bSetGet
   ::bChange:= bChange 
   ::bWhen  := bWhen
   ::bValid := bValid
    
   ::hWnd = CreateText( oWnd:hwnd, ::uValue, nTop, nLeft ,nWidth, nHeight, Self )
   
   if !Empty(cCueText)
      ::SetPlaceHolder(cCueText)
   endif
   
   if lPassword
      ::SetSecure()
   endif
   
    
return Self


METHOD Resources( oWnd, bSetGet, idResource, bChange, cCueText, lPassword, cPict, bWhen, bValid ) CLASS TGet
  local cText := Space( 30 )

   DEFAULT bSetGet := bSETGET( cText ), lPassword:= .f. 
   
   ::uValue = Eval( bSetGet )
   
   ::bSetGet := bSetGet
   ::bChange:= bChange
   ::bWhen  :=bWhen
   ::bValid := bValid
    
   ::hWnd = CreateTextResources( oWnd:hwnd, idResource, ::uValue, Self )
   
   if !Empty(cCueText)
      ::SetPlaceHolder(cCueText)
   endif
   
   if lPassword
      ::SetSecure()
   endif

Return Self


METHOD HandleEvent( nMsg, uParam1, uParam2 ) CLASS TGet
 
   
   do case
      case nMsg == WM_EDITCHANGE
		
		   ::uValue = Eval( ::bSetGet, GetTextField( ::hWnd ) )
         
         if ! Empty( ::bChange )
            Eval( ::bChange, Self )
         endif
		  
	 case nMsg == WM_EDITBEGIN
		
		   ::uValue = Eval( ::bSetGet, GetTextField( ::hWnd ) )
         
         if ! Empty( ::bWhen )
            Eval( ::bWhen, Self )
         endif	  
			
	 case nMsg == WM_EDITEND
		
		   ::uValue = Eval( ::bSetGet, GetTextField( ::hWnd ) )
         
         if ! Empty( ::bValid )
            Eval( ::bValid, Self )
         endif		 
			   
   endcase


return nil 

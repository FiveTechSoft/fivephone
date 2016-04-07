/*
 * $Id
 */

/*
 * FivePhone source code:
 * Class TView
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
 
#include "fmsgs.h"
#include "fivephone.ch"

CLASS TView

   DATA   hWnd

   DATA  oNavBar
   DATA  bPaint,bDblTouch,bTouchesBegan,bDblTap,bTouchMoved
   DATA bTouchout
   
   METHOD New( oWnd, nTop, nLeft, nWidth, nHeight, nRed, nGreen, nBlue, nAlpha ) 
   
   METHOD Resources( oWnd, cResource )

   METHOD nHeight() INLINE ViewHeight( ::hWnd )
   
   METHOD _nHeight( nNewHeight ) INLINE ViewSetHeight( ::hWnd, nNewHeight )
   
   METHOD nWidth() INLINE ViewWidth( ::hWnd )
   
   METHOD _nWidth( nNewWidth ) INLINE ViewSetHeight( ::hWnd, nNewHeight )
   
   METHOD nTop() INLINE ViewTop( ::hWnd )
   
   METHOD _nTop( nNewTop ) INLINE ViewSetTop( ::hWnd, nNewTop )
   
   METHOD nLeft() INLINE ViewLeft( ::hWnd )
   
   METHOD _nLeft( nNewLeft ) INLINE ViewSetLeft( ::hWnd, nNewLeft )
   
   METHOD SetPos( nTop, nLeft ) INLINE ViewSetPos( ::hWnd, nTop, nLeft )
   
   METHOD lVisible() INLINE ! ViewHidden( ::hWnd )
   
   METHOD _lVisible( lOnOff ) INLINE ViewHidden( ::hWnd, ! lOnOff )
   
   METHOD nBkgColor() INLINE ViewBkgColor( ::hWnd )
   
   METHOD SetBkgColor( nRed, nGreen, nBlue, nAlpha ) INLINE ViewBkgColor( ::hWnd, nRed, nGreen, nBlue, nAlpha )

   METHOD SetBkgImg( cImage ) INLINE VIEWBKGIMG(::hwnd,cImage) 
   
   METHOD SetBkgGroup() INLINE ViewBkgGrouped(::hwnd)
   
   METHOD UnLink() 
   
   METHOD End()
   
   METHOD Repaint() INLINE  ViewRePaint(::hwnd)	
      
   METHOD EndAnimate(nAnimate)  
   
   METHOD HandleEvent( nMsg, hSender, uParam1, uParam2 ) 
   
   METHOD Hide() INLINE ViewHidden( ::hWnd, .t. )
   METHOD Show() INLINE ViewHidden( ::hWnd, .f. )	
	    
  // METHOD AddParent( oWnd ) INLINE AddParentView(::hwnd,oWnd:hWnd )  
	     
ENDCLASS

METHOD New( oWnd, nTop, nLeft, nWidth, nHeight, nRed, nGreen, nBlue, nAlpha ) CLASS TView

   DEFAULT nTop := 0, nLeft := 0, nWidth := ScreenWidth(), nHeight := ScreenHeight(), nAlpha:=100
   
 
   ::hWnd = CreateView( oWnd:hWnd, nLeft, nTop, nWidth, nHeight )
   
 //  ::AddParent( oWnd:hWnd )
   
   
   if Empty(nRed) .and. Empty(nGreen) .and. Empty(nBlue)
         ::SetBkgGroup()         
      else   
         DEFAULT nRed:= 255, nGreen:=255, nBlue:=255
	     ::SetBkgColor( nRed, nGreen,nBlue,nAlpha )
   endif
   
   AAdd( GetAllWin(), Self )
   
return Self  

METHOD Resources( oWnd, cResource ) CLASS TView

   ::hWnd = GETVIEWRESOURCE( oWnd:hWnd,cResource )
   
   
   AAdd( GetAllWin(), Self )
   
     
return Self  


METHOD HandleEvent( nMsg, hSender, uParam1, uParam2 ) CLASS TView
local nLen
 do case
    case nMsg == WM_VIEWPAINT 
		if ! Empty( ::bPaint )
            Eval( ::bPaint, Self )   
	    endif
    case nMsg == WM_TOUCHMOVED
	    if ! Empty( ::bTouchMoved )
            Eval( ::bTouchMoved, Self,{uParam1,uParam2} )   
	    endif
	case nMsg == WM_TOUCHOUT
	     nlen:= uParam1
	   if ! Empty( ::bTouchOut )
            Eval( ::bTouchOut, Self,nlen )   
	    endif
	case nMsg == WM_DOUBLETOUCH
		   if ! Empty( ::bdblTouch )
			  Eval( ::bDblTouch, Self )			
		   endif
		  
	case nMsg == WM_SINGLETAP
	       if ! Empty( ::bTouchesBegan )
		       Eval( ::bTouchesBegan, Self,{uParam1,uParam2} )
		   endif
		  		  
	case nMsg == WM_DOUBLETAP
		   if ! Empty( ::bDblTap )
			  Eval( ::bDblTap, Self )
		   endif    
	     
	     
 endcase


Return nil


METHOD UnLink() CLASS TView
local lresult:= .f.
   local nAt
   if ( nAt := AScan( GetAllwin(), { | o | o:hWnd == ::hWnd } ) ) != 0
         
		ADel(  GetAllwin(), nAt )
		ASize(  GetAllwin(), Len(  GetAllwin() ) - 1 )
		lresult:= .t.	
   	
   endif

return lresult


METHOD End() CLASS TView
 ViewEnd(::hWnd )
 ::UnLink()
return nil


METHOD EndAnimate(nAnimate) CLASS TView
DEFAULT nAnimate:= 2
  ViewAnimationEnd(::hwnd, nAnimate)
  ::UnLink()
    
return nil
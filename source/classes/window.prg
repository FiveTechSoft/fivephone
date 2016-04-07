/*
 * $Id
 */

/*
 * FivePhone source code:
 * Class TWindow
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
#include "error.ch"
#include "fmsgs.h"

static aWindows := {}

CLASS TWindow FROM TView

   DATA   oNavBar
   DATA   oToolBar
   DATA   bTouchesBegan
   DATA   bDblTap
   DATA   bDblTouch
   
   METHOD New()
   
   METHOD GetMain()
   
   METHOD Activate() INLINE WndActivate( ::hWnd )
   
   METHOD End() INLINE WndClose( ::hWnd ), EndPool()
   
   METHOD HandleEvent( nMsg, hSender, uParam1, uParam2 )
   METHOD SetColor( nRed, nGreen, nBlue, nAlfa ) INLINE WndBkColor( ::hWnd , nRed, nGreen, nBlue, nAlfa ) 
       
ENDCLASS

METHOD New( nRed, nGreen, nBlue, nAlfa ) CLASS TWindow

   DEFAULT nRed := 0,nGreen := 0 , nBlue:= 255 , nAlfa:= 100

  ::hWnd = CreateWindow()
  ::SetColor( nRed, nGreen, nBlue, nAlfa )
   
   AAdd( aWindows, Self )
   
return Self

METHOD GetMain() CLASS TWindow

   ::hWnd = GetWndMain()
   
   AAdd( aWindows, Self )
   
return Self   

METHOD HandleEvent( nMsg, hSender, uParam1, uParam2 ) CLASS TWindow

   do case
      case nMsg == WM_BARLEFTCLICK
           if ! Empty( ::oNavBar )
              ::oNavBar:LeftClick()
           endif
           
      case nMsg == WM_BARRIGHTCLICK
           if ! Empty( ::oNavBar )
              ::oNavBar:RightClick()
           endif 
           
      case nMsg == WM_TOOLBARCLICK
           if ! Empty( ::oToolBar )
              ::oToolBar:Click( hSender )
           endif  
		   
	  case nMsg == WM_DOUBLETOUCH
		   if ! Empty( ::bdblTouch )
			  Eval( ::bDblTouch, Self )			
		   endif
		  
	  case nMsg == WM_SINGLETAP
		   if ! Empty( ::bTouchesBegan )
			  Eval( ::bTouchesBegan, Self )
		   endif
		  		  
	  case nMsg == WM_DOUBLETAP
		   if ! Empty( ::bDblTap )
			  Eval( ::bDblTap, Self )
		   endif 
		 	 
	  case nMsg == WM_TOUCHESBEGAN
		   if ! Empty( ::bTouchesBegan )
			  Eval( ::bTouchesBegan, Self )
		   endif                          
   endcase
   
return nil              

function _FPH( hWnd, nMsg, hSender, uParam1, uParam2 )

	local nAt := AScan( aWindows, { | o | o:hWnd == hWnd } )
	
	if nAt != 0
		return aWindows[ nAt ]:HandleEvent( nMsg, hSender, uParam1, uParam2 ) 
	endif

return nil

function FWEvents( oSender, nMsg, uParam1, uParam2 )
return oSender:HandleEvent( nMsg, uParam1, uParam2 )

function GetAllWin()
return aWindows

procedure BuildPoolApp( lCreatePoolApp )

   static lInit := .F.

   DEFAULT lCreatePoolApp := .T.
   
	if ! lInit
		lInit = .T.
		if lCreatePoolApp
		   CreatePool()
		endif   
		ErrorBlock( { | o | ShowError( o ) } )
		if lCreatePoolApp
		   CreateApp()
		endif   
	endif
	
return			
	  
init procedure OnStart

   BuildPoolApp( GetWndMain() == 0 )
   
return

static function ShowError( oError )
 
   local cError := oError:Description
   local n
 
   if oError:GenCode == EG_ZERODIV
      return 0
   end
 
   if ! Empty( oError:Operation )
      cError += HB_OSNewLine() + oError:Operation
   endif
 
   if ValType( oError:Args ) == "A"
      cError += HB_OSNewLine() + "   Args:" + HB_OSNewLine()
      for n = 1 to Len( oError:Args )
         cError += "     [" + Str( n, 4 ) + "] = " + ValType( oError:Args[ n ] ) + ;
                   "   " + cValToChar( oError:Args[ n ] ) + HB_OSNewLine()
      next
   endif
 
   cError += HB_OSNewLine() + "stack calls:" + HB_OSNewLine()
 
   n = 2
   while ! Empty( ProcName( n ) )
      cError += AllTrim( ProcName( n ) ) + ;
                "(" + AllTrim( Str( ProcLine( n ) ) ) + ")" + HB_OSNewLine()
      n++
   end   
 
   // MemoWrit( hb_CurDir() + "\error.txt", cError )
   MsgInfo( cError, "FivePhone error" )
 
   // PostQuitMessage( 0 )
   // QUIT
 
return .t.      

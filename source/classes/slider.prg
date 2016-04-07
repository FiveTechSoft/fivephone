/*
 * $Id
 */

/*
 * FivePhone source code:
 * Class TSlider
 *
 * Copyright 2010 Daniel Garcia-Gil <danielgarciagil@gmail.com>
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

CLASS TSlider FROM TView
   
   DATA bChanged
   DATA bSetGet
   DATA nValue
     
   METHOD New( oWnd, nTop, nLeft, nWidth, nHeight, bSetGet, nMin, nMax, bChanged ) 
   
   METHOD Resources( oWnd, idResource, bSetGet, nMin, nMax, bChanged )
   
   // the method end only release low level object handle
   // the object still alive until set nil the object container
   
   METHOD End() INLINE  ::hWnd :=  NIL
      
   METHOD HandleEvent( nMsg, uParam1, uParam2 ) 
     

ENDCLASS

//--------------------------------------------------------------------//

METHOD New( oWnd, nTop, nLeft, nWidth, nHeight, bSetGet, nMin, nMax, bChanged ) CLASS TSlider

   local nValue := 1

   DEFAULT nTop := 5, nLeft := 5, nWidth := 150, nHeight := 9 
   DEFAULT nMin := 1, nMax := 100, bSetGet := bSETGET( nValue )
   
   ::nValue = Eval( bSetGet )
   ::bSetGet = bSetGet
   ::bChanged:= bChanged
   
   ::hWnd = CreateSlider( oWnd:hwnd, nTop, nLeft ,nWidth, nHeight, nValue, nMin, nMax, Self )
   
//   AAdd( GetAllWin(), Self )
    
return Self

//--------------------------------------------------------------------//

METHOD Resources( oWnd, idResource, bSetGet, nMin, nMax, bChanged )  CLASS TSlider

 local nValue := 1

   DEFAULT nTop := 5, nLeft := 5, nWidth := 150, nHeight := 9 
   DEFAULT nMin := 1, nMax := 100, bSetGet := bSETGET( nValue )
   
   ::nValue = Eval( bSetGet )
   ::bSetGet = bSetGet
   ::bChanged:= bChanged

  ::hWnd = CreateSliderResources(oWnd:hWnd,idResource, nValue, nMin, nMax, Self )
    
return Self

//--------------------------------------------------------------------//

METHOD HandleEvent( nMsg, uParam1, uParam2 ) CLASS TSlider

   DEFAULT nMsg := 0
   
   do case
      case nMsg == WM_VALUECHANGE
		
		   ::nValue = Eval( ::bSetGet, GetSliderValue( ::hWnd ) )
         
         if ! Empty( ::bChanged )
            Eval( ::bChanged, Self )
         endif
		   
   endcase

return nil 
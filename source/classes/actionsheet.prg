/*
 * $Id
 */

/*
 * FivePhone source code:
 * Class TActionSheet
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

CLASS TActionSheet FROM TView

   DATA aPrompts
   DATA aActions
   
   METHOD New( oWnd, nTop, nLeft, nWidth, nHeight ) 

   METHOD End() INLINE  ::hWnd :=  NIL
      
   METHOD HandleEvent( nMsg, uParam1, uParam2 ) 

ENDCLASS

//--------------------------------------------------------------------//

METHOD New( oWnd, cTitle, aPrompts, aActions, cCancel, bAccCancel, cDestructive, bAccDestructive ) CLASS TActionSheet

   DEFAULT aPrompts := { "Yes", "No" }
   DEFAULT aActions := Array( Len( aButtons ) )
   DEFAULT cTitle := ""
   
   ::aPrompts = aPrompts
   ::aActions = aActions

   ::hWnd = CreateActionSheet( oWnd:hwnd, Self, cTitle, aPrompts, cCancel, cDestructive )

   if ! Empty( cCancel )
      ASize( ::aActions, Len( ::aActions ) + 1 )
      AIns( ::aActions, 1 )
      ASize( ::aPrompts, Len( ::aPrompts ) + 1 )
      AIns( ::aPrompts, 1 )  
      ::aPrompts[ 1 ] = If( ! Empty( cCancel ), cCancel, "" )
      ::aActions[ 1 ] = bAccCancel
   endif

   if ! Empty( cDestructive ) 
      ASize( ::aActions, Len( ::aActions ) + 1 )
      AIns( ::aActions, 1 )
      ASize( ::aPrompts, Len( ::aPrompts ) + 1 )
      AIns( ::aPrompts, 1 )   
      ::aPrompts[ 1 ] = If( ! Empty( cDestructive ), cDestructive, "" )   
      ::aActions[ 1 ] = bAccDestructive
   endif

    
return Self

//--------------------------------------------------------------------//

METHOD HandleEvent( nMsg, uParam1, uParam2 ) CLASS TActionSheet

   local nOption := uParam1 + 1

   do case
      case nMsg == WM_ITEMSEL
         if ! Empty( ::aActions[ nOption ] )
            Eval( ::aActions[ nOption ], self, nOption )
         endif
   endcase

return nil 

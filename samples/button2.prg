/*
 * $Id
 */

/*
 * FivePhone source code:
 * Button example
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

function Main()

   local oWnd := TWindow():New()
   local oBtn1, oBtn2
   local oActionSheet
    
   
   oBtn1 = TButton():New( oWnd, "Press One",  50, 110, 100, 40, {|| ActShet1( oWnd ) } )
   oBtn2 = TButton():New( oWnd, "Press Two", 150, 110, 100, 40, {|| ActShet2( oWnd ) } )

   oWnd:Activate()
   
return nil   

function ActShet1( oWnd )
   local bAction :=  {| oSelf, nItem | MsgInfo( oSelf:aPrompts[ nItem ] ) }
   local oActionSheet := TActionSheet():New( oWnd, "Select Answer", ,;
                                             { bAction, bAction }, "Cancel", bAction , "Destructive", bAction )
   
return nil

function ActShet2( oWnd )
   local aPrompts := {"Option 1", "Option 2", "Option 3", "Option 4" }
   local bAction :=  {| oSelf, nItem | MsgInfo( oSelf:aPrompts[ nItem ] ) }
   local aActions :=  { bAction, bAction, bAction, bAction }

   local oActionSheet := TActionSheet():New( oWnd, "Select Option", aPrompts, aActions )
   
return nil



 
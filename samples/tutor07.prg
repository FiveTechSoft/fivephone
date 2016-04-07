/*
 * $Id
 */

/*
 * FivePhone source code:
 * tutor07 example
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

function Main()

   local oWnd := TWindow():New()
   local oView1, oView2, oTabbar
   local onavitem , onav1,onav2
 
 //  TNavBar():New( oWnd, "FivePhone", "Exit", "About" )
   
 //  oWnd:oNavBar:bLeftClick = { || oWnd:End() }
//   oWnd:oNavBar:bRightClick = { || MsgInfo( "iOS SDK for Harbour" ) }

//   onavitem:=GETNAVBARITEM(oWnd:oNavBar:hWnd)
    
  // SETNAVBARLEFTSYSTEMBUTTONITEM(onavitem,7) 

   oView1 = TView():New( oWnd,0, 0, ScreenWidth(), ScreenHeight() - 49 )
   oView1:SetBkgColor( 0, 255, 0, 255 )

    onav1:=TNavBar():New( oView1, "FivePhone", "Exit", "About" )
    onav1:bLeftClick = { || MsgInfo( "boton1 vista1" )}
    onav1:bRightClick = { || MsgInfo( "vista1" ) }

   TLabel():New( oView1, "First" )

   oView2 = TView():New( oWnd, 0, 0, ScreenWidth(), ScreenHeight() - 49 )
   oView2:SetBkgColor( 255, 0, 0, 255 )
   oView2:lVisible = .F.

    onav2:=TNavBar():New( oView2, "FivePhone2", "Exito", "Abouto" )
    onav2:bLeftClick = { || oWnd:End() }
    onav2:bRightClick = { || MsgInfo( "Vista2" ) }

   TLabel():New( oView2, "Second" )

   oTabBar = TTabBar():New( oWnd )
   oTabBar:AddItem( 0, oView1 )
   oTabBar:AddItem( 1, oView2 )
   // oTabBar:AddItem( 2 )
  //oTabBar:bChange = { ||  aeval( oTabBar:aView, {|o, i| o:lVisible := iif( i == oTabBar:nat() , .t. ,.f. )    }  ) } 

    oWnd:Activate()
   
return nil






 
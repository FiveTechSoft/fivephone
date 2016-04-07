/*
 * $Id
 */

/*
 * FivePhone source code:
 * Class TTableViewCell
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

#define Plain    0
#define Grouped  1

#define  None 0
#define  DisclosureIndicator 1
#define  DetailDisclosureButton 2
#define  Checkmark 3


CLASS TTableViewCell FROM TView

    METHOD New( nStyle, nStyleAcessory, cDetailText , oCell )
    METHOD ReNew( hWnd )
    METHOD SetAcessory(nStyle) 
    METHOD SetDetailText(cText) INLINE  SetCellDetail(::hWnd,cText)  
    METHOD SetImage(cImage) INLINE SetCellImage(::hWnd,cImage)
    METHOD SetBackView(cBackView) INLINE SetCellBackView(::hWnd,cBackView)
    METHOD SetTextColor(nred,ngreen,nblue,nalfa) INLINE SetCellTextColor(::hWnd,nred,ngreen,nblue,nalfa) 
    
ENDCLASS

METHOD New( nStyle, nStyleAcessory, cDetailText ) CLASS TTableViewCell
   DEFAULT nStyle := Plain 
   ::hWnd:=CreateCell(nStyle ) 
   
   ::SetAcessory( nStyleAcessory )
   
   if !Empty(cDetailText)
  		 ::SetDetailText(cDetailText)
  endif	
  	 
return Self

METHOD ReNew( hWnd ) CLASS TTableViewCell
   ::hWnd:= hWnd
Return Self
        
METHOD SetAcessory(nStyle) CLASS TTableViewCell
   DEFAULT nStyle:= None
   SetCellAcesory(::hWnd,nStyle)    
Return      
        
        
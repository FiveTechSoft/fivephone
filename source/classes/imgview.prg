/*
 * $Id
 */

/*
 * FivePhone source code:
 * Class TImageView
 *
 * Copyright 2010 Antonio Linares Cañas <alinares@fivetechsoft.com>
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

CLASS TImageView FROM TView
     
   METHOD New( oWnd, cImage, nTop, nLeft, nWidth, nHeight,lUrl )    
   METHOD Resources( oWnd, idResource )
   METHOD AddImagesAnimate(aImages) INLINE AddImageViewAnimate(::hWnd,aImages)
   METHOD StartAnimate() INLINE StartImageViewAnimate(::hWnd)
   METHOD DurationAnimate(nSeg) INLINE DurationImageViewAnimate(::hWnd,nSeg*100)
   METHOD RepeatAnimate(nloop) INLINE RepeatImageViewAnimate(::hWnd,nloop)
   METHOD StopAnimate() INLINE StopImageViewAnimate(::hWnd)
   METHOD isAnimate() INLINE IsImageViewAnimate(::hWnd)
   METHOD Zoom(xscale,yscale) INLINE ImageViewScale(::hWnd,xscale,yscale)   
   METHOD CenterHPoint(hPoint) INLINE ImageViewCenterNSString(::hWnd,hPoint) 
   METHOD Center(x,y) INLINE ImageViewCenter(::hWnd,x,y )     
     
   ENDCLASS

//--------------------------------------------------------------------//

METHOD New( oWnd, cImage, nTop, nLeft, nWidth, nHeight, lUrl) CLASS TImageView

   DEFAULT nTop := 50, nLeft := 50, nWidth := 200, nHeight := 200 ,lUrl:= .f.
   
   if lUrl
    ::hWnd = CreateUrlImageView( oWnd:hWnd, cImage, nTop, nLeft, nWidth, nHeight )
   else
    ::hWnd = CreateImageView( oWnd:hWnd, cImage, nTop, nLeft, nWidth, nHeight )
   endif 
   
   AAdd( GetAllWin(), Self )
    
return Self

//--------------------------------------------------------------------//


METHOD Resources( oWnd, idResource,cImage ) CLASS TImageView
  
   ::hWnd = GetControlResource( oWnd:hWnd,idResource )  
   CreateIMageViewResources(::hWnd,cImage)
    AAdd( GetAllWin(), Self )
 
return Self  


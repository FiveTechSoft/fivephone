/*
 * $Id
 */

/*
 * FivePhone source code:
 * ToolBars support
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

#import <UIKit/UIKit.h>
#define HB_DONT_DEFINE_BOOL
#include <hbapi.h>
#include <windows.h> 
 
HB_FUNC( CREATETOOLBAR )
{
   Window * window = ( Window * ) hb_parnl( 1 );
   UIToolbar * tbr = [ [ UIToolbar alloc] init ];    
 
   tbr.barStyle = hb_parnl( 2 ); 
   [ tbr sizeToFit ];
   [ tbr setFrame : CGRectMake( 0, [ [ UIScreen mainScreen ] bounds ].size.height - 50, 
                                   [ [ UIScreen mainScreen ] bounds ].size.width, 50 ) ];   
   
   [ window addSubview : tbr ];
 
   hb_retnl( ( LONG ) tbr );
}

HB_FUNC( TBRADDBUTTON )
{
   UIToolbar * tbr = ( UIToolbar * ) hb_parnl( 1 );
   NSString * text = [ [ [ NSString alloc ] initWithCString: ISCHAR( 2 ) ? hb_parc( 2 ) : "" ] autorelease ];   
   UIBarButtonItem * button = [ [ UIBarButtonItem alloc ] initWithTitle : text style : UIBarButtonItemStyleBordered 
                              target : tbr.window action : @selector( ToolBarClick: ) ];
   if( [ tbr items ] == nil )
      [ tbr setItems : [ NSArray arrayWithObjects : button, nil ] animated : FALSE ];
   else   
   {
      NSMutableArray * items = [ [ NSMutableArray alloc ] init ];
      [ items setArray : [ tbr items ] ];
      [ items addObject : button ];
      [ tbr setItems : items animated : FALSE ];
   }   
      
   hb_retnl( ( LONG ) button );
}

 HB_FUNC( SETBARSTYLE )
{
   UIToolbar * tbr = ( UIToolbar * ) hb_parnl( 1 );
   tbr.barStyle =  hb_parnl( 2 ); 
}

 HB_FUNC( SETBARTRASLUCENT )
{
   UIToolbar * tbr = ( UIToolbar * ) hb_parnl( 1 );
   tbr.translucent = hb_parl( 2 ) ;    
}  
 
 HB_FUNC( SETBARCOLOR )
{
   UIToolbar * tbr = ( UIToolbar * ) hb_parnl( 1 );
   tbr.tintColor = [UIColor colorWithRed:(hb_parnl( 2 )/255.0) green: (hb_parnl( 3 )/255.0) blue:(hb_parnl( 4 )/255.0) alpha:(hb_parnl( 5 )/100.0)];
}

HB_FUNC( GETBARBUTTON )
{
   UIToolbar * tbr = ( UIToolbar * ) hb_parnl( 1 );
   UIBarButtonItem * button =  [ [ tbr items ] objectAtIndex: hb_parnl( 2 ) ];
         
   hb_retnl( ( LONG ) button );
}

HB_FUNC( SETBARBUTTONSTYLE )
{
   UIBarButtonItem * button =  ( UIBarButtonItem * ) hb_parnl( 1 );
   button.style = hb_parnl( 2 );
 }
 
 
 
 HB_FUNC( TBRADDBARBUTTONSYSTEM )
{
 UIToolbar * tbr = ( UIToolbar * ) hb_parnl( 1 );
  UIBarButtonItem * button = [ [ UIBarButtonItem alloc ] initWithBarButtonSystemItem: hb_parnl(2) 
													  target:tbr.window action:@selector( ToolBarClick: )];
	
	if( [ tbr items ] == nil )
		[ tbr setItems : [ NSArray arrayWithObjects : button, nil ] animated : FALSE ];
	else   
	{
		NSMutableArray * items = [ [ NSMutableArray alloc ] init ];
		[ items setArray : [ tbr items ] ];
		[ items addObject : button ];
		[ tbr setItems : items animated : FALSE ];
	}   
	
       
   hb_retnl( ( LONG ) button );
 }
 
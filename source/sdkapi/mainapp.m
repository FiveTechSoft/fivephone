/*
 * $Id$
 */

/*
 * FivePhone source code:
 * UIApplication support
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
#import <UIKit/UIApplication.h>
#define HB_DONT_DEFINE_BOOL
#include <hbapi.h>
#include <hbvm.h>
#include <windows.h>
 
void MsgInfo( NSString * );
int MsgYesNo( NSString * );
 
@interface MainApp : UIApplication 
{
}
// - ( void ) alertSheet : ( UIAlertSheet * ) sheet buttonClicked : ( int ) button;
- ( void ) touchesBegan : ( NSSet * ) touches withEvent : ( UIEvent * ) event;
- ( void ) navigationBar : ( UINavigationBar * ) navbar buttonClicked : ( int ) button;
@end
 
MainApp * app = nil;
Window * wndMain = nil;
 
void SetWndMain( Window * window )
{
   if( wndMain == nil )
      wndMain = window;
}   
 
UIApplication * GetApp( void )
{
   return app;
}   
 
@implementation MainApp
 
- ( void ) applicationDidFinishLaunching : ( UIApplication * ) application
{
   PHB_SYMB symMain = hb_dynsymSymbol( hb_dynsymFindName( "MAIN" ) );
 
   app = self;
 
   hb_vmPushSymbol( symMain );
   hb_vmPushNil();
   hb_vmDo( 0 );
 
   if( wndMain == nil )
      exit( 0 );
}

/* 
- ( void ) alertSheet : ( UIAlertSheet * ) sheet buttonClicked : ( int ) button
{
   [ sheet dismiss ];
}
*/

- ( void ) touchesBegan : ( NSSet * ) touches withEvent : ( UIEvent * ) event 
{
   //set code here
}
 
- ( void ) navigationBar : ( UINavigationBar * ) navbar buttonClicked : ( int ) button 
{
   // NSString * text = [ NSString stringWithFormat : @"%i", button ]; 
 
	 switch ( button ) 
	 {
	    case 1:  // left
		       exit( 0 ); 
		       break;
 
		  case 0: // right	
		       MsgYesNo( @"Do you want to exit ?" ); 
		       break;
   }
}
 
@end

Window * GetWndMain( void )
{
   return wndMain;
}
   
HB_FUNC( GETWNDMAIN )
{
   hb_retnl( ( LONG ) GetWndMain() );
}

@interface FPDelegate : NSObject <UIApplicationDelegate>
{
}
@end


@implementation FPDelegate
@end


HB_FUNC( APPSETDELEGATE )
{
	FPDelegate * fpd = [ [ FPDelegate alloc ] init ];
	
	[ UIApplication sharedApplication].delegate = fpd;
}	
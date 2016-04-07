/*
 * $Id$
 */

/*
 * FivePhone source code:
 * windows support
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
#include <hbvm.h>
#include <fmsgs.h>
#include <windows.h>

#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a/100.0]

void SetWndMain( UIWindow * wndMain );

static PHB_SYMB symFPH = NULL;
 
   
@implementation Window

/*
- ( void ) sendEvent : ( UIEvent * ) event
{
   MsgInfo( @"event" );
}   
*/

- ( void ) touchesBegan : ( NSSet * ) touches withEvent : ( UIEvent * ) event
{
	NSSet *allTouches = [event allTouches];
	
   	switch ([allTouches count]) {
		case 1: { //Single touch
          UITouch *touch = [[allTouches allObjects] objectAtIndex:0];
			switch ([touch tapCount])
			{
				case 1: //Single Tap.
				{
					
					if( symFPH == NULL )
						symFPH = hb_dynsymSymbol( hb_dynsymFindName( "_FPH" ) );
					
					hb_vmPushSymbol( symFPH );
					hb_vmPushNil();
					hb_vmPushLong( ( LONG ) self );
					hb_vmPushLong( WM_SINGLETAP );
					hb_vmDo( 2 );  
										
					
				} break;
				case 2: //Double tap.
				{
					if( symFPH == NULL )
						symFPH = hb_dynsymSymbol( hb_dynsymFindName( "_FPH" ) );
					
					hb_vmPushSymbol( symFPH );
					hb_vmPushNil();
					hb_vmPushLong( ( LONG ) self );
					hb_vmPushLong( WM_DOUBLETAP );
					hb_vmDo( 2 );  
														
				}	break;
			}
		} break;
		case 2: { //Double Touch
			
			if( symFPH == NULL )
				symFPH = hb_dynsymSymbol( hb_dynsymFindName( "_FPH" ) );
			
			hb_vmPushSymbol( symFPH );
			hb_vmPushNil();
			hb_vmPushLong( ( LONG ) self );
			hb_vmPushLong( WM_DOUBLETOUCH );
			hb_vmDo( 2 );  
						
				} break;
		default:
break;
}			
			
 /*  
   if( symFPH == NULL )
      symFPH = hb_dynsymSymbol( hb_dynsymFindName( "_FPH" ) );
      
   hb_vmPushSymbol( symFPH );
   hb_vmPushNil();
   hb_vmPushLong( ( LONG ) self );
   hb_vmPushLong( nEvento );
   hb_vmDo( 2 );  
    */
	
}


- ( void ) BarLeftClick : ( id ) sender
{
   if( symFPH == NULL )
      symFPH = hb_dynsymSymbol( hb_dynsymFindName( "_FPH" ) );
   
   hb_vmPushSymbol( symFPH );
   hb_vmPushNil();
   hb_vmPushLong( ( LONG ) self );
   hb_vmPushLong( WM_BARLEFTCLICK );
   hb_vmPushLong( ( LONG ) sender );
   hb_vmDo( 3 );    
}   

- ( void ) BarRightClick : ( id ) sender
{   
   if( symFPH == NULL )
      symFPH = hb_dynsymSymbol( hb_dynsymFindName( "_FPH" ) );
      
   hb_vmPushSymbol( symFPH );
   hb_vmPushNil();
   hb_vmPushLong( ( LONG ) self );
   hb_vmPushLong( WM_BARRIGHTCLICK );
   hb_vmPushLong( ( LONG ) sender );
   hb_vmDo( 3 );         
}   

- ( void ) ToolBarClick : ( id ) sender
{
   // MsgInfo( @"ToolBar button click" );
   
   if( symFPH == NULL )
      symFPH = hb_dynsymSymbol( hb_dynsymFindName( "_FPH" ) );
      
   hb_vmPushSymbol( symFPH );
   hb_vmPushNil();
   hb_vmPushLong( ( LONG ) self );
   hb_vmPushLong( WM_TOOLBARCLICK );
   hb_vmPushLong( ( LONG ) sender );
   hb_vmDo( 3 );    
}   

- ( void ) onTimerEvent : ( NSTimer * ) timer
{
   // MsgInfo( @"timer event" );
   
   if( symFPH == NULL )
      symFPH = hb_dynsymSymbol( hb_dynsymFindName( "_FPH" ) );
      
   hb_vmPushSymbol( symFPH );
   hb_vmPushNil();
   hb_vmPushLong( ( LONG ) timer );
   hb_vmPushLong( WM_ONTIMEREVENT );
   hb_vmDo( 2 );   
}   

- ( void ) removeLogo
{
   Window * window = GetWndMain();
   
	[ UIView beginAnimations:nil context:nil ];
	[ UIView setAnimationDuration:2.0 ];
	[ UIView setAnimationBeginsFromCurrentState:NO ];
	[ UIView setAnimationTransition:UIViewAnimationTransitionCurlUp
						   forView: [ window->logo superview ] cache : YES ];   
   
   [ window->logo removeFromSuperview ];
   [ window->logo release ];
   
   [ UIView commitAnimations ];
}

@end 
 
HB_FUNC( CREATEWINDOW )
{
   Window * window = [ [ Window alloc ] initWithFrame : [ [ UIScreen mainScreen ] bounds ] ];
 
   window.backgroundColor = [ UIColor blueColor ];
 
   hb_retnl( ( LONG ) window );
}

HB_FUNC( WNDBKCOLOR )
{
   UIWindow * window = ( UIWindow * ) hb_parnl( 1 );
   window.backgroundColor = [UIColor colorWithRed:(hb_parnl( 2 )/255.0) green: (hb_parnl( 3 )/255.0) blue:(hb_parnl( 4 )/255.0) alpha:(hb_parnl( 5 )/100.0)];
}   
 
HB_FUNC( WNDACTIVATE )
{
   UIWindow * window = ( UIWindow * ) hb_parnl( 1 );   
 
   SetWndMain( window );
 
   [ window makeKeyAndVisible ];
}              
 
HB_FUNC( WNDCLOSE )
{
   UIWindow * window = ( UIWindow * ) hb_parnl( 1 );
 
   [ window release ];
}    

HB_FUNC( UIWINDOWALLOCINIT )
{
   hb_retnl( ( LONG ) [ [ UIWindow alloc ] init ] );
}             
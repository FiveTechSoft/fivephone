/*
 * $Id
 */

/*
 * FivePhone source code:
 * Navigation bars support
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
#include <hbvm.h>
#include <fmsgs.h>
 
static PHB_SYMB symFPH = NULL;

@interface NavigationBar :  UINavigationBar 
{
}
- ( void ) BarLeftClick : ( id ) sender ;
- ( void ) BarRightClick : ( id ) sender ;

@end

@implementation NavigationBar

- ( void ) BarLeftClick : ( id ) sender
{
   
   if( symFPH == NULL )
      symFPH = hb_dynsymSymbol( hb_dynsymFindName( "_FPH" ) );
   
   hb_vmPushSymbol( symFPH );
   hb_vmPushNil();
   hb_vmPushLong( ( LONG ) self);
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
 
@end
 
 
HB_FUNC( CREATENAVBAR )
{
   Window * window = ( Window * ) hb_parnl( 1 );
   NavigationBar * nav = [ [ NavigationBar alloc] initWithFrame : 
                             CGRectMake( 0, 0, [ window bounds ].size.width, 
                             hb_parnl( 2 ) ) ];
   UINavigationItem * item;                          
 
   NSString * title = [ [ [ NSString alloc ] initWithCString: ISCHAR( 3 ) ? hb_parc( 3 ) : "" ] autorelease ];
   NSString * left  = [ [ [ NSString alloc ] initWithCString: ISCHAR( 4 ) ? hb_parc( 4 ) : "" ] autorelease ];
   NSString * right = [ [ [ NSString alloc ] initWithCString: ISCHAR( 5 ) ? hb_parc( 5 ) : "" ] autorelease ];
   
   item = [ [ UINavigationItem alloc ] initWithTitle : title ]; 
   [ item setLeftBarButtonItem : [ [ UIBarButtonItem alloc ] initWithTitle : left style : UIBarButtonItemStyleBordered target : nav action : @selector( BarLeftClick: ) ] animated : FALSE ];
   [ item setRightBarButtonItem : [ [ UIBarButtonItem alloc ] initWithTitle : right style : UIBarButtonItemStyleBordered target : nav action : @selector( BarRightClick: ) ] animated : FALSE ];
   [ nav pushNavigationItem : item animated : YES ]; 

   [ window addSubview : nav ];
	
   // [ nav setDelegate : GetApp() ];
 
   hb_retnl( ( LONG ) nav );
}


HB_FUNC( SETSTYLENAVBAR )
{
	NavigationBar * nav = ( NavigationBar * ) hb_parnl( 1 ) ; 
	nav.barStyle = hb_parnl( 2 ) ;
}

HB_FUNC( SETTRASLUNAVBAR )
{
	NavigationBar * nav = ( NavigationBar * ) hb_parnl( 1 ) ; 
	nav.translucent = YES ;
}

HB_FUNC( SETTINTNAVBAR )
{
	NavigationBar * nav = ( NavigationBar * ) hb_parnl( 1 ) ; 
	nav.tintColor = [ UIColor colorWithRed : hb_parnd( 2 ) / 255 green : hb_parnd( 3 ) / 255 
									  blue : hb_parnd( 4 ) / 255 alpha : hb_parnd( 5 ) / 100 ];
}

HB_FUNC( GETNAVBARITEM )
{
   NavigationBar * nav = ( NavigationBar * ) hb_parnl( 1 );
   
   UINavigationItem * item = nav.topItem ;               
 
   hb_retnl( ( LONG ) item );
}


HB_FUNC( SETBACKNAVBARITEM )
{
	NavigationBar * nav = ( NavigationBar * ) hb_parnl( 1 ) ; 	
	UINavigationItem * item = nav.topItem ;
	NSString * back = [ [ [ NSString alloc ] initWithCString: ISCHAR( 2 ) ? hb_parc( 2 ) : "" ] autorelease ];
	
	
	UIButton* backButton = [UIButton buttonWithType:101];
	UIView *backButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, backButton.frame.size.width, backButton.frame.size.height)];
	
	[backButton addTarget: nav action:@selector( BarLeftClick:) forControlEvents:UIControlEventTouchUpInside];
	[backButton setTitle: back forState:UIControlStateNormal];
	[backButtonView addSubview:backButton];
	
	// set buttonview as custom view for bar button item
	UIBarButtonItem* backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButtonView];
		
	
	item.leftBarButtonItem = backButtonItem;

}



HB_FUNC( SETNILRIGHTNAVBARITEM )
{
  UINavigationItem * item = ( UINavigationItem * ) hb_parnl( 1 );
  [ item setRightBarButtonItem : nil animated : FALSE ];

}

HB_FUNC( SETTITLENAVBARITEM )
{
  UINavigationItem * item = ( UINavigationItem * ) hb_parnl( 1 );
  NSString * title = [ [ [ NSString alloc ] initWithCString: ISCHAR( 2 ) ? hb_parc( 2 ) : "" ] autorelease ];
  item.title =  title ;
}


HB_FUNC( SETPROMPTNAVBARITEM )
{
  UINavigationItem * item = ( UINavigationItem * ) hb_parnl( 1 );
  NSString * prompt = [ [ [ NSString alloc ] initWithCString: ISCHAR( 2 ) ? hb_parc( 2 ) : "" ] autorelease ];
  item.prompt =  prompt ;
}

HB_FUNC( GETNAVBARLEFTBUTTONITEM )
{
   UINavigationItem * item = ( UINavigationItem * ) hb_parnl( 1 );    
   UIBarButtonItem *leftBarButtonItem = item.leftBarButtonItem ;   
   hb_retnl( ( LONG ) leftBarButtonItem );
}


HB_FUNC( GETNAVBARRIGHTBUTTONITEM )
{
   UINavigationItem * item = ( UINavigationItem * ) hb_parnl( 1 );    
   UIBarButtonItem *rightBarButtonItem = item.rightBarButtonItem ;   
   hb_retnl( ( LONG ) rightBarButtonItem );
}

HB_FUNC( SETNAVBARLEFTSYSTEMBUTTONITEM )
{
   UINavigationItem * item = ( UINavigationItem * ) hb_parnl( 1 );  

   UIBarButtonItem *ButtonItem = item.leftBarButtonItem ;  
   UIBarButtonItem *newButtonItem =  [ [ UIBarButtonItem alloc ] initWithBarButtonSystemItem: hb_parnl( 2 )
                                 target: [ButtonItem target ] action:@selector( BarLeftClick: ) ] ;
   
  [ item setLeftBarButtonItem : newButtonItem animated : FALSE ];  
  
}

HB_FUNC( SETNAVBARRIGHTSYSTEMBUTTONITEM )
{
   UINavigationItem * item = ( UINavigationItem * ) hb_parnl( 1 );  

   UIBarButtonItem *ButtonItem = item.rightBarButtonItem ;  
   UIBarButtonItem *newButtonItem =  [ [ UIBarButtonItem alloc ] initWithBarButtonSystemItem: hb_parnl( 2 )
                                 target: [ButtonItem target ] action:@selector( BarRightClick: ) ] ;
   
  [ item setRightBarButtonItem : newButtonItem animated : FALSE ];  
  
}

HB_FUNC( SETNAVBARLEFTIMAGEBUTTONITEM )
{
   UINavigationItem * item = ( UINavigationItem * ) hb_parnl( 1 );  
   NSString * cImage = [ [ [ NSString alloc ] initWithCString: ISCHAR( 2 ) ? hb_parc( 2 ) : "" ] autorelease ];
   UIImage * image   = [ [ UIImage imageNamed : cImage ] autorelease ];
   
   UIBarButtonItem *ButtonItem = item.leftBarButtonItem ; 
     
   UIBarButtonItem *newButtonItem =  [ [ UIBarButtonItem alloc ] initWithImage: image 
                             style:hb_parnl(3) target:[ButtonItem target ]  action:@selector( BarLeftClick: ) ] ;
       
  [ item setLeftBarButtonItem : newButtonItem animated : FALSE ];  
  
}

HB_FUNC( SETNAVBARRIGHTIMAGEBUTTONITEM )
{
   UINavigationItem * item = ( UINavigationItem * ) hb_parnl( 1 );  
   NSString * cImage = [ [ [ NSString alloc ] initWithCString: ISCHAR( 2 ) ? hb_parc( 2 ) : "" ] autorelease ];
   UIImage * image   = [ [ UIImage imageNamed : cImage ] autorelease ];
   
   UIBarButtonItem *ButtonItem = item.rightBarButtonItem ; 
     
   UIBarButtonItem *newButtonItem =  [ [ UIBarButtonItem alloc ] initWithImage: image 
                             style: hb_parnl(3) target:[ButtonItem target ]  action:@selector( BarLeftClick: ) ] ;
       
  [ item setRightBarButtonItem : newButtonItem animated : FALSE ];  
  
}



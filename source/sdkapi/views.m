/*
 * $Id
 */

/*
 * FivePhone source code:
 * UIView support
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
#include <fwprototypes.h>

static PHB_SYMB symFPH = NULL;


float distanceBetweenTwoPoints( CGPoint fromPoint , CGPoint toPoint )
{
	float x = toPoint.x - fromPoint.x;
	float y = toPoint.y - fromPoint.y;
	return sqrt(x*y + y*y);
}


@interface View : UIView
{
CGFloat initialDistance;
}
- ( void ) touchesBegan : ( NSSet * ) touches withEvent : ( UIEvent * ) event;

- ( void ) touchesMoved : ( NSSet * ) touches withEvent : ( UIEvent * ) event;
 
 /*
- ( void ) touchesEnded : ( NSSet * ) touches withEvent : ( UIEvent * ) event;
*/
- ( void ) drawRect:(CGRect)rect;


@end

@implementation View


- ( void ) touchesMoved : ( NSSet * ) touches withEvent : ( UIEvent * ) event
{
	
  NSSet *allTouches = [event allTouches];
  UITouch *touch = [touches anyObject];
  CGPoint location = [touch locationInView:self];
 
	switch ([allTouches count])
	{
		case 1: {
			
			if( symFPH == NULL )
				symFPH = hb_dynsymSymbol( hb_dynsymFindName( "_FPH" ) );
 
			hb_vmPushSymbol( symFPH );
			hb_vmPushNil();
			hb_vmPushLong( ( LONG ) self );
			hb_vmPushLong( WM_TOUCHMOVED );
			hb_vmPushLong( 0 );
			hb_vmPushDouble(location.x , 2 );	
			hb_vmPushDouble(location.y , 2 );		
			hb_vmDo( 5 );
		
		} break;
		 
		case 2: {
			
			UITouch *touch1 = [[allTouches allObjects] objectAtIndex:0];
			UITouch *touch2 = [[allTouches allObjects] objectAtIndex:1];
			
			CGFloat finalDistance =  distanceBetweenTwoPoints([touch1 locationInView:self], [touch2 locationInView:self]) ;			
						
			hb_vmPushSymbol( symFPH );
			hb_vmPushNil();
			hb_vmPushLong( ( LONG ) self );
			hb_vmPushLong( WM_TOUCHOUT );
			hb_vmPushLong( 0 );
			hb_vmPushDouble( ( finalDistance - initialDistance ), 2 );		
			hb_vmDo( 4 );	
			
			
} break;
}
			
			
 
 }
 
/*
- ( void ) touchesEnded : ( NSSet * ) touches withEvent : ( UIEvent * ) event
{
}
*/

- ( void ) touchesBegan : ( NSSet * ) touches withEvent : ( UIEvent * ) event
{
   // CGPoint pt = [[touches anyObject] locationInView:self]; 
	NSSet *allTouches = [event allTouches];
	UITouch *touch = [allTouches anyObject];
	CGPoint location = [ touch locationInView:touch.view ];
			
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
					hb_vmPushLong( 0 );
					hb_vmPushDouble(location.x , 2 );	
					hb_vmPushDouble(location.y , 2 );
					hb_vmDo( 5 );
										
					
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
			
			UITouch *touch1 = [[allTouches allObjects] objectAtIndex:0];
			UITouch *touch2 = [[allTouches allObjects] objectAtIndex:1];
			
			initialDistance =  distanceBetweenTwoPoints( [touch1 locationInView:self ],[touch2 locationInView:self ]);					
					
			
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
			
}


- (void)drawRect:(CGRect)rect
{
	
  if( symFPH == NULL )
      symFPH = hb_dynsymSymbol( hb_dynsymFindName( "_FPH" ) );
   
   hb_vmPushSymbol( symFPH );
   hb_vmPushNil();
   hb_vmPushLong( ( LONG ) self );
   hb_vmPushLong( WM_VIEWPAINT );
   hb_vmDo( 2 );    
	
}


@end

HB_FUNC( CREATEVIEW )
{
   UIView * parent = ( UIView * ) hb_parnl( 1 );
   View * view = [ [ View alloc ] initWithFrame : CGRectMake( hb_parnl( 2 ), hb_parnl( 3 ), hb_parnl( 4 ), hb_parnl( 5 ) ) ];
   
   [ view setUserInteractionEnabled : YES ];
   
   [ parent addSubview : view ];
   
   hb_retnl( ( LONG ) view );
}   


HB_FUNC( ADDPARENTVIEW )
{
	 UIView * view = ( UIView * ) hb_parnl( 1 );
	 UIView * parent = ( UIView * ) hb_parnl( 2 );
	[ parent addSubview : view ];
}


HB_FUNC( VIEWHEIGHT )
{
   UIView * view = ( UIView * ) hb_parnl( 1 );

   hb_retnd( [ view frame ].size.height );
}  

HB_FUNC( VIEWSETHEIGHT )
{
   UIView * view = ( UIView * ) hb_parnl( 1 );
   CGRect rect;
   
   rect.origin.x    = [ view frame ].origin.x;
   rect.origin.y    = [ view frame ].origin.y;
   rect.size.width  = [ view frame ].size.width;
   rect.size.height = hb_parnd( 2 );
   
   [ view setFrame : rect ];
}          

HB_FUNC( VIEWWIDTH )
{
   UIView * view = ( UIView * ) hb_parnl( 1 );

   hb_retnd( [ view frame ].size.width );
}            

HB_FUNC( VIEWSETWIDTH )
{
   UIView * view = ( UIView * ) hb_parnl( 1 );
   CGRect rect;
   
   rect.origin.x    = [ view frame ].origin.x;
   rect.origin.y    = [ view frame ].origin.y;
   rect.size.width  = hb_parnd( 2 );
   rect.size.height = [ view frame ].size.height;
   
   [ view setFrame : rect ];
}   
   
HB_FUNC( VIEWTOP )
{
   UIView * view = ( UIView * ) hb_parnl( 1 );
   
   hb_retnd( [ view frame ].origin.y );
}

HB_FUNC( VIEWSETTOP )
{
   UIView * view = ( UIView * ) hb_parnl( 1 );
   CGRect rect;
   
   rect.origin.x    = [ view frame ].origin.x;
   rect.origin.y    = hb_parnd( 2 );
   rect.size.width  = [ view frame ].size.width;
   rect.size.height = [ view frame ].size.height;
   
   [ view setFrame : rect ];
}   

HB_FUNC( VIEWSETPOS )
{
   UIView * view = ( UIView * ) hb_parnl( 1 );
   CGRect rect;
   
   rect.origin.x = hb_parnd( 3 );
   rect.origin.y = hb_parnd( 2 );
   rect.size.width  = [ view frame ].size.width;
   rect.size.height = [ view frame ].size.height;
   
   [ view setFrame : rect ];
}   

HB_FUNC( VIEWLEFT )
{
   UIView * view = ( UIView * ) hb_parnl( 1 );
   
   hb_retnd( [ view frame ].origin.x );
}          

HB_FUNC( VIEWSETLEFT )
{
   UIView * view = ( UIView * ) hb_parnl( 1 );
   CGRect rect;
   
   rect.origin.x    = hb_parnd( 2 );
   rect.origin.y    = [ view frame ].origin.y;
   rect.size.width  = [ view frame ].size.width;
   rect.size.height = [ view frame ].size.height;
   
   [ view setFrame : rect ];
}   

HB_FUNC( VIEWHIDDEN )
{
   UIView * view = ( UIView * ) hb_parnl( 1 );
   
   if( hb_pcount() > 1 )
      [ view setHidden : hb_parl( 2 ) ];
   
   hb_retl( view.hidden );
}      

HB_FUNC( VIEWBKGCOLOR ) 
{
   UIView * view = ( UIView * ) hb_parnl( 1 );
   
   if( hb_pcount() > 1 )
      view.backgroundColor = [ UIColor colorWithRed : hb_parnd( 2 ) / 255 green : hb_parnd( 3 ) / 255 
                                       blue : hb_parnd( 4 ) / 255 alpha : hb_parnd( 5 ) / 100 ];
   
   hb_retnl( ( LONG ) view.backgroundColor );
}       

HB_FUNC( VIEWBKGGROUPED ) 
{
	UIView * view = ( UIView * ) hb_parnl( 1 );
	view.backgroundColor = [UIColor groupTableViewBackgroundColor];	
	hb_retnl( ( LONG ) view.backgroundColor );
}    


HB_FUNC( VIEWREPAINT ) 
{
	UIView * view = ( UIView * ) hb_parnl( 1 );
	[ view setNeedsDisplay];	
} 


HB_FUNC( VIEWBKGIMG )
{
	UIView * view = ( UIView * ) hb_parnl( 1 );
	NSString * cImage = [ [ [ NSString alloc ] initWithCString: ISCHAR( 2 ) ? hb_parc( 2 ) : "" ] autorelease ];
	
	UIColor* BgrImg = [[UIColor alloc] initWithPatternImage: [UIImage imageNamed: cImage]];
	
	view.backgroundColor = BgrImg ;
	[BgrImg release];        
}  

HB_FUNC( VIEWEND )
{
	UIView * view = ( UIView * ) hb_parnl( 1 );
	[view removeFromSuperview ];
	[view release];        
}  

HB_FUNC( VIEWANIMATOUTIN )
{
	UIView * view = ( UIView * ) hb_parnl( 1 );
	
	[UIView animateWithDuration:1.0
						  delay: 0.0
						options: UIViewAnimationOptionCurveEaseIn
					 animations:^{
						 view.alpha = 0.0;
					 }
					 completion:^(BOOL finished){
						 // Wait one second and then fade in the view
						 [UIView animateWithDuration:1.0
											   delay: 1.0
											 options:UIViewAnimationOptionCurveEaseOut
										  animations:^{
											  view.alpha = 1.0;
										  }
										  completion:nil];
					 }];	
	
}



HB_FUNC( VIEWANIMATIONEND )
{
	
	UIView * view = ( UIView * ) hb_parnl( 1 );
	
	[UIView transitionWithView: [ view superview ]  duration:0.4
				   options :( hb_parnl(2)*1048576 ) 
					animations:^{ [view removeFromSuperview]; [view release]; }
					completion: nil ] ;
	
	/*
	[ UIView beginAnimations:nil context:nil ];
	[ UIView setAnimationDuration: 0.5 ];
	[ UIView setAnimationBeginsFromCurrentState:NO ];
	[ UIView setAnimationTransition: UIViewAnimationTransitionCurlUp 
							forView: [ view superview ] cache : YES ];  
	
	
	[ view removeFromSuperview ];
	[ view release ];
	 
	[ UIView commitAnimations ];
	*/
	 
}


HB_FUNC( STRINGCLEARAREA )
{
	NSString * MyRectString = hb_NSSTRING_par( 1 ); 
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	CGContextClearRect(ctx,CGRectFromString(MyRectString) );
}

HB_FUNC( NSSTRINGTOSTRING )
{
  NSString * MyString =  (NSString * ) hb_parnl( 1 ) ; 
  hb_retc(  [ MyString cStringUsingEncoding : NSASCIIStringEncoding ] ) ;
}


HB_FUNC( GETCGRECTSTRING )
{
   NSString * MyRectString = NSStringFromCGRect( CGRectMake( hb_parnl( 1 ), hb_parnl( 2 ), hb_parnl( 3 ), hb_parnl( 4 ) ) ) ;
	hb_retc(  [ MyRectString cStringUsingEncoding : NSASCIIStringEncoding ] ) ;
}

HB_FUNC( CLEARAREA )
{
CGContextRef ctx = UIGraphicsGetCurrentContext();
CGContextClearRect(ctx, CGRectMake( hb_parnl( 1 ), hb_parnl( 2 ), hb_parnl( 3 ), hb_parnl( 4 ) ) );
}


HB_FUNC( DRAWBORDERCIRCLE )
{
CGContextRef ctx = UIGraphicsGetCurrentContext();
	// Draw a circle (border only)
CGContextSetRGBStrokeColor(ctx, ( hb_parnl( 5 )/255.0 ), ( hb_parnl( 6 )/255.0 ) , ( hb_parnl( 7 )/255.0 ) , ( hb_parnl( 8 )/100.0 ) );
CGContextStrokeEllipseInRect(ctx, CGRectMake(hb_parnl( 1 ), hb_parnl( 2 ), hb_parnl( 3 ), hb_parnl( 4 ) ) );
}

HB_FUNC( DRAWCIRCLE )
{
CGContextRef ctx = UIGraphicsGetCurrentContext();
// Draw a circle (border only)
CGContextSetRGBFillColor(ctx,( hb_parnl( 5 )/255.0 ), ( hb_parnl( 6 )/255.0 ) , ( hb_parnl( 7 )/255.0 ) , ( hb_parnl( 8 )/100.0 ) );
CGContextFillEllipseInRect(ctx, CGRectMake(hb_parnl( 1 ), hb_parnl( 2 ), hb_parnl( 3 ), hb_parnl( 4 ) ) );
}

HB_FUNC( DRAWLINE )
{
CGContextRef ctx = UIGraphicsGetCurrentContext();
CGContextSetRGBStrokeColor(ctx, ( hb_parnl( 5 )/255.0 ), ( hb_parnl( 6 )/255.0 ) , ( hb_parnl( 7 )/255.0 ) , ( hb_parnl( 8 )/100.0 ) );
CGPoint points[2] = { CGPointMake(hb_parnl( 1 ), hb_parnl( 2 )), CGPointMake(hb_parnl( 3 ),hb_parnl( 4 )) };
CGContextStrokeLineSegments(ctx, points, 2);
}

HB_FUNC( DRAWSETWIDTHLINE )
{
CGContextRef ctx = UIGraphicsGetCurrentContext();
CGContextSetLineWidth(ctx,  ( hb_parnl( 1 )/1.0 ));
}

HB_FUNC( DRAWSETSTROKECOLOR )
{
CGContextRef ctx = UIGraphicsGetCurrentContext();
CGContextSetRGBStrokeColor(ctx, ( hb_parnl( 1 )/255.0 ), ( hb_parnl( 2 )/255.0 ) , ( hb_parnl( 3 )/255.0 ) , ( hb_parnl( 4 )/100.0 ) );
}

HB_FUNC( DRAWSETFILLCOLOR )
{
CGContextRef ctx = UIGraphicsGetCurrentContext();
CGContextSetRGBFillColor(ctx, ( hb_parnl( 1 )/255.0 ), ( hb_parnl( 2 )/255.0 ) , ( hb_parnl( 3 )/255.0 ) , ( hb_parnl( 4 )/100.0 ) );
}

HB_FUNC( DRAWRECTANGLE )
{
CGContextRef ctx = UIGraphicsGetCurrentContext();
CGRect rectangle = CGRectMake(hb_parnl( 1 ), hb_parnl( 2 ), hb_parnl( 3 ),hb_parnl( 4 ) ) ;
CGContextAddRect(ctx, rectangle);
CGContextStrokePath(ctx);
}



HB_FUNC( CGRECTMAKE )
{
	// hb_retnl( ( LONG ) CGRectMake( hb_parnl( 1 ), hb_parnl( 2 ), hb_parnl( 3 ), hb_parnl( 4 ) ) );
}	






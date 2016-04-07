#import <UIKit/UIKit.h>
#import <UIKit/UIApplication.h>
#define HB_DONT_DEFINE_BOOL
#include <hbapi.h>
#include <hbvm.h>
#include <windows.h>
#include <fwprototypes.h>
#include <fmsgs.h>

HB_FUNC( GETVIEWRESOURCE )
{
    UIWindow * window = ( UIWindow * ) hb_parnl( 1 );
	NSString * cNib  = hb_NSSTRING_par( 2 ); 
	
	NSArray *topLevelObjs = nil;
    topLevelObjs = [[NSBundle mainBundle] loadNibNamed: cNib owner:window options:nil];
	
	UIView * view = [ topLevelObjs objectAtIndex : 0 ];
	CGRect rect;
	
	rect.origin.x    = [ view frame ].origin.x;
	rect.origin.y    = [ view frame ].origin.x+ 20 ;
	rect.size.width  = [ view frame ].size.width;
	rect.size.height = [ view frame ].size.height;
	
	[ view setFrame : rect ];	
	
    [window addSubview:  view ];
	
	hb_retnl( ( LONG ) view ); 
	
}    


HB_FUNC( GETCONTROLRESOURCE )
{
    UIWindow * window = ( UIWindow * ) hb_parnl( 1 );
    
	NSObject * miobj = (NSObject *) [window viewWithTag:hb_parnl( 2 )];
    
		
	hb_retnl( ( LONG ) miobj ); 	
	
} 


HB_FUNC( GETBUTTONRESOURCE )
{
    UIWindow * window = ( UIWindow * ) hb_parnl( 1 );
    
	NSObject * miobj = (NSObject *) [window viewWithTag:hb_parnl( 2 )];
    
   hb_OBJECT_ret( miobj );  
	
} 
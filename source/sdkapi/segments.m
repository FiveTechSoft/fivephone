#import <UIKit/UIKit.h>
#define HB_DONT_DEFINE_BOOL
#include <hbapi.h>
#include <hbvm.h>
#include <windows.h>
#include <fmsgs.h>

static PHB_SYMB symFPH = NULL;

@interface SegmentedControl : UISegmentedControl
{
}
- ( void ) segmentAction : ( id ) sender;
@end

@implementation SegmentedControl

- ( void ) segmentAction : ( id ) sender
{
	if( symFPH == NULL )
		symFPH = hb_dynsymSymbol( hb_dynsymFindName( "_FPH" ) );
	
	hb_vmPushSymbol( symFPH );
	hb_vmPushNil();
	hb_vmPushLong( ( LONG ) sender );
	hb_vmPushLong( WM_VALUECHANGE );
	hb_vmDo( 2 );    
}

@end



HB_FUNC( CREATESEGMENT )
{
UIWindow * window = ( UIWindow * ) hb_parnl( 1 );
	
SegmentedControl *segmentedcontrol = [[ SegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"First", @"Second", nil]];
segmentedcontrol.frame = CGRectMake( hb_parnl(3), hb_parnl(2), hb_parnl(4),hb_parnl(5) );
segmentedcontrol.alpha = 1.000;
segmentedcontrol.autoresizesSubviews = YES;
segmentedcontrol.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
segmentedcontrol.clearsContextBeforeDrawing = YES;
segmentedcontrol.clipsToBounds = NO;
segmentedcontrol.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
segmentedcontrol.contentMode = UIViewContentModeScaleToFill;
segmentedcontrol.contentStretch = CGRectFromString(@"{{0, 0}, {1, 1}}");
segmentedcontrol.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
segmentedcontrol.enabled = YES;
segmentedcontrol.hidden = NO;
segmentedcontrol.highlighted = NO;
segmentedcontrol.momentary = NO;
segmentedcontrol.multipleTouchEnabled = NO;
segmentedcontrol.opaque = NO;
segmentedcontrol.segmentedControlStyle = UISegmentedControlStylePlain;
segmentedcontrol.selected = NO;
segmentedcontrol.selectedSegmentIndex = 0;
segmentedcontrol.tag = 0;
segmentedcontrol.userInteractionEnabled = YES;
	
segmentedcontrol.removeAllSegments;
	
[ segmentedcontrol  addTarget : segmentedcontrol action : @selector( segmentAction: ) forControlEvents : UIControlEventValueChanged ];

[window addSubview:segmentedcontrol];

hb_retnl( ( LONG ) segmentedcontrol ); 
	
}

HB_FUNC( AADDSEGMENT )
{
	SegmentedControl * segmentedcontrol = ( SegmentedControl * )hb_parnl( 1 );
	NSString * title = [ [ [ NSString alloc ] initWithCString: ISCHAR( 2 ) ? hb_parc( 2 ) : "" ] autorelease ];	
	[ segmentedcontrol insertSegmentWithTitle : title atIndex:( [segmentedcontrol numberOfSegments ] ) animated : YES ] ;
}

HB_FUNC( CREATESEGMENTEDRESOURCES )
{
	
	UIWindow * window = ( UIWindow * ) hb_parnl( 1 );
    
	SegmentedControl *  miobj = (SegmentedControl *) [window viewWithTag:hb_parnl( 2 )];
	
	miobj.removeAllSegments;
	
	[ miobj addTarget : miobj action : @selector( segmentAction: ) forControlEvents:UIControlEventValueChanged ];
   	
	hb_retnl( ( LONG ) miobj ); 		
	
} 

HB_FUNC( SEGMENTDELETEALLBUTTONS )
{
	SegmentedControl * segmentedcontrol = ( SegmentedControl * ) hb_parnl( 1 );	
	segmentedcontrol.removeAllSegments;
}


HB_FUNC( GETSEGMENTEDVALUE )
{
	UISegmentedControl * Control = ( UISegmentedControl * ) hb_parnl( 1 );	
	hb_retnl( Control.selectedSegmentIndex );
	
}

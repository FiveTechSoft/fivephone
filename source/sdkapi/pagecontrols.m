#import <UIKit/UIKit.h>
#import <UIKit/UIApplication.h>
#define HB_DONT_DEFINE_BOOL
#include <hbapi.h>
#include <hbvm.h>
#include <windows.h>
#include <fmsgs.h>

   
HB_FUNC( CREATEPAGECONTROL )
{
	Window * window = ( Window * ) hb_parnl( 1 );
	
	UIPageControl *pagecontrol = [[UIPageControl alloc] initWithFrame: CGRectMake( hb_parnl( 3 ), hb_parnl( 2 ), hb_parnl( 4 ), hb_parnl( 5 ) ) ];
	pagecontrol.alpha = 1.000;
	pagecontrol.autoresizesSubviews = YES;
	pagecontrol.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
	pagecontrol.clearsContextBeforeDrawing = YES;
	pagecontrol.clipsToBounds = NO;
	pagecontrol.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
	pagecontrol.contentMode = UIViewContentModeScaleToFill;
	pagecontrol.contentStretch = CGRectFromString(@"{{0, 0}, {1, 1}}");
	pagecontrol.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	pagecontrol.currentPage = 0;
	pagecontrol.defersCurrentPageDisplay = NO;
	pagecontrol.enabled = YES;
	pagecontrol.hidden = NO;
	pagecontrol.hidesForSinglePage = NO;
	pagecontrol.highlighted = NO;
	pagecontrol.multipleTouchEnabled = NO;
	pagecontrol.numberOfPages = 3;
	pagecontrol.opaque = NO;
	pagecontrol.selected = NO;
	pagecontrol.tag = 0;
	pagecontrol.userInteractionEnabled = YES;	
	
							
	[ window addSubview: pagecontrol ];
					
  hb_retnl( ( LONG ) pagecontrol );
}


HB_FUNC( SETCURRENTPAGECONTROL )
{
	
UIPageControl  *pagecontrol = ( UIPageControl  * ) hb_parnl( 1 );	
pagecontrol.currentPage =hb_parnl( 2 );	
	
}

HB_FUNC( SETNUMBERPAGESPAGECONTROL )
{
	
	UIPageControl  *pagecontrol = ( UIPageControl  * ) hb_parnl( 1 );	
	pagecontrol.numberOfPages =hb_parnl( 2 );	
	
}

HB_FUNC( GETCURRENTPAGECONTROL )
{
	
	UIPageControl  *pagecontrol = ( UIPageControl  * ) hb_parnl( 1 );	
	hb_retnl( pagecontrol.currentPage );	
	
}
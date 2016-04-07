#import <UIKit/UIKit.h>
#import <UIKit/UIApplication.h>
#define HB_DONT_DEFINE_BOOL
#include <hbapi.h>
#include <hbvm.h>
#include <windows.h>
#include <fmsgs.h>

static PHB_SYMB symFPH = NULL;


HB_FUNC( CREATESCROLLVIEW )
{
	Window * window = ( Window * ) hb_parnl( 1 );
	
	UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake( hb_parnl( 3 ), hb_parnl( 2 ), hb_parnl( 4 ), hb_parnl( 5 ) ) ];

	scrollview.alpha = 1.000;
	scrollview.alwaysBounceHorizontal = NO;
	scrollview.alwaysBounceVertical = NO;
	scrollview.autoresizesSubviews = YES;
	scrollview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	scrollview.bounces = YES;
	scrollview.bouncesZoom = YES;
	scrollview.canCancelContentTouches = YES;
	scrollview.clearsContextBeforeDrawing = YES;
	scrollview.clipsToBounds = YES;
	scrollview.contentMode = UIViewContentModeScaleToFill;
	scrollview.contentStretch = CGRectFromString(@"{{0, 0}, {1, 1}}");
	scrollview.delaysContentTouches = YES;
	scrollview.directionalLockEnabled = NO;
	scrollview.hidden = NO;
	scrollview.indicatorStyle = UIScrollViewIndicatorStyleDefault;
	scrollview.maximumZoomScale = 1.000;
	scrollview.minimumZoomScale = 1.000;
	scrollview.multipleTouchEnabled = YES;
	scrollview.opaque = YES;
	scrollview.pagingEnabled = NO;
	scrollview.scrollEnabled = YES;
	scrollview.showsHorizontalScrollIndicator = YES;
	scrollview.showsVerticalScrollIndicator = YES;
	scrollview.tag = 0;
	scrollview.userInteractionEnabled = YES;
	
	[window addSubview:scrollview];
	
	
					
  hb_retnl( ( LONG ) scrollview );
}


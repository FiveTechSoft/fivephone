
#import <UIKit/UIKit.h>
#import <UIKit/UIApplication.h>
#define HB_DONT_DEFINE_BOOL
#include <hbapi.h>
#include <windows.h>


HB_FUNC( CREATEPROGRESS )
{
	Window * window = ( Window * ) hb_parnl( 1 );
	
UIProgressView *progressview = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
[progressview setFrame:CGRectMake( (hb_parnl(3)/1.0), (hb_parnl(2)/1.0), (hb_parnl(4)/1.0),(hb_parnl(5)/1.0) )];
[progressview setAlpha:1.000];
[progressview setAutoresizesSubviews:YES];
[progressview setAutoresizingMask:UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin];
[progressview setClearsContextBeforeDrawing:YES];
[progressview setClipsToBounds:NO];
[progressview setContentMode:UIViewContentModeScaleToFill];
[progressview setContentStretch:CGRectFromString(@"{{0, 0}, {1, 1}}")];
[progressview setHidden:NO];
[progressview setMultipleTouchEnabled:NO];
[progressview setOpaque:NO];
[progressview setProgress:0.500];
[progressview setProgressViewStyle:UIProgressViewStyleDefault];
[progressview setTag:0];
[progressview setUserInteractionEnabled:YES];
	
[ window addSubview: progressview ];
			
	
hb_retnl( ( LONG ) progressview );
	
}


HB_FUNC( SETPROGRESS )
{
	UIProgressView *progressview = ( UIProgressView * ) hb_parnl( 1 );
    [progressview setProgress: ( hb_parnl(2)/100.0 )];
}
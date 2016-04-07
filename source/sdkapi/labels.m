#import <UIKit/UIKit.h>
#import <UIKit/UIApplication.h>
#define HB_DONT_DEFINE_BOOL
#include <hbapi.h>
#include <windows.h>


static void SetText( UILabel * label, char * lpTitle )
{
	label.text = [ [ [ NSString alloc ] initWithCString: lpTitle ] autorelease ];
}

HB_FUNC( CREATELABEL )
{
	UIWindow * window = ( UIWindow * ) hb_parnl( 1 );
//	NSString * title = [ [ [ NSString alloc ] initWithCString: ISCHAR( 2 ) ? hb_parc( 2 ) : "" ] autorelease ];	
	UILabel * label = [ [ UILabel alloc ] initWithFrame : CGRectMake( (hb_parnl(4)/1.0), (hb_parnl(3)/1.0), (hb_parnl(5)/1.0),(hb_parnl(6)/1.0) )];
	
	// label.frame = CGRectMake((hb_parnl( 3 )/1.0),( hb_parnl( 4 )/1.0), (hb_parnl( 5 )/1.0),(hb_parnl( 6 )/1.0));
	label.adjustsFontSizeToFitWidth = YES;
	label.alpha = 1.000;
	label.autoresizesSubviews = YES;
	label.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
	label.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
	label.clearsContextBeforeDrawing = YES;
	label.clipsToBounds = YES;
	label.contentMode = UIViewContentModeLeft;
	label.contentStretch = CGRectFromString(@"{{0, 0}, {1, 1}}");
	label.enabled = YES;
	label.font = [UIFont fontWithName:@"Helvetica" size:17.000];
	label.hidden = NO;
	label.highlightedTextColor = [UIColor colorWithWhite:1.000 alpha:1.000];
	label.lineBreakMode = UILineBreakModeTailTruncation;
	label.minimumFontSize = 10.000;
	label.multipleTouchEnabled = NO;
	label.numberOfLines = 1;
	label.opaque = NO;
	label.shadowOffset = CGSizeMake(0.0, -1.0);
	label.tag = 0;
//	label.text = title ;
	label.textAlignment = UITextAlignmentLeft;
	label.textColor = [UIColor colorWithRed:0.000 green:0.000 blue:0.000 alpha:1.000];
	label.userInteractionEnabled = NO;
   label.backgroundColor = [UIColor clearColor];
   
	SetText( label, ( char * ) ( ISCHAR( 2 ) ? hb_parc( 2 ) : "" ) );
   
	[ window addSubview : label ];
	
	hb_retnl( ( LONG ) label );
}

HB_FUNC( SETLABELCOLOR )
{
	UILabel *label = ( UILabel * ) hb_parnl( 1 );
	
	label.textColor = [UIColor colorWithRed:(hb_parnl( 2 )/255.0) green: (hb_parnl( 3 )/255.0) blue:(hb_parnl( 4 )/255.0) alpha:(hb_parnl( 5 )/100.0)];
}

HB_FUNC( SETLABELFONT )
{
	UILabel *label = ( UILabel * ) hb_parnl( 1 );
	NSString * fontName = [ [ [ NSString alloc ] initWithCString: ISCHAR( 2 ) ? hb_parc( 2 ) : "" ] autorelease ];	
	
	label.font = [UIFont fontWithName: fontName size:(hb_parnl( 3 )/1.000)];
}

HB_FUNC( SETLABELTEXT )
{
	UILabel *label = ( UILabel * ) hb_parnl( 1 );
	
	SetText( label, ( char * )hb_parc( 2 ) );
}

HB_FUNC( SETLABELSHADOW )
{
	UILabel *label = ( UILabel * ) hb_parnl( 1 );

	label.shadowColor = [UIColor whiteColor];
	label.shadowOffset = CGSizeMake(1.0,1.0);	
}	

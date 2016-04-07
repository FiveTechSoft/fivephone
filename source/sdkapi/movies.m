#import <UIKit/UIKit.h>
#import <UIKit/UIApplication.h>
#import <MediaPlayer/MediaPlayer.h>

#define HB_DONT_DEFINE_BOOL
#include <hbapi.h>
#include <hbvm.h>
#include <windows.h>
#include <fwprototypes.h>
#include <fmsgs.h>

@interface MoviePlayerController : MPMoviePlayerController
{
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;
@end

@implementation MoviePlayerController

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;}

@end

HB_FUNC( CREATEMOVIEPLAYER )
{
	Window * wndParent = ( Window * ) hb_parnl( 1 );  
	NSString * path = [ [ NSBundle mainBundle ] pathForResource : hb_NSSTRING_par( 2 ) ofType : nil ];
	MoviePlayerController * mpc = [ [ MoviePlayerController alloc ] initWithContentURL : [ NSURL fileURLWithPath : path ] ];  
	
	mpc.view.frame = CGRectMake( hb_parnl( 3 ), hb_parnl( 4 ), hb_parnl( 5 ), hb_parnl( 6 ) );
	
	// deprecated
	// mpc.movieControlMode = MPMovieControlModeDefault;
	
	// AirPlay hack
	[ mpc setAllowsWirelessPlayback : YES ];
	
	[ wndParent addSubview : mpc.view ];
	
	mpc.view.tag = ( NSInteger ) mpc;
	
	hb_retnl( ( LONG ) mpc.view );
}

HB_FUNC( MOVIEPLAY )
{
	UIView * view = ( UIView * ) hb_parnl( 1 );
	MoviePlayerController * mpc = ( MoviePlayerController * ) view.tag;

	[ mpc play ];
}
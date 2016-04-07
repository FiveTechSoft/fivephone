#import <UIKit/UIKit.h>
#define HB_DONT_DEFINE_BOOL
#include <hbapi.h>

// - ( void ) OnTimerEvent : ( NSTimer * ) timer

HB_FUNC( CREATETIMER ) // hTimer
{
   NSTimer * timer = [ [ NSTimer scheduledTimerWithTimeInterval : hb_parnd( 1 ) target : ( UIView * ) hb_parnl( 2 ) selector : @selector ( onTimerEvent: ) userInfo : NULL repeats : YES ] retain ];

   hb_retnl( ( LONG ) timer );
}

HB_FUNC( TIMEREND )
{
   NSTimer * timer = ( NSTimer * ) hb_parnl( 1 );
   
   // [self setFadeTimer:nil]; in the container Window or View
   
   [ timer invalidate ];
   [ timer release ];
}
#import <UIKit/UIKit.h>
#import <UIKit/UIApplication.h>
#define HB_DONT_DEFINE_BOOL
#include <hbapi.h>
#include <hbvm.h>
#include <windows.h>
#include <fmsgs.h>

static PHB_SYMB symFPH = NULL;

@interface Switch : UISwitch
{
}
- ( void ) switchAction : ( id ) sender;
@end

@implementation Switch

- ( void ) switchAction : ( id ) sender
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
   
HB_FUNC( CREATESWITCH )
{
	Window * window = ( Window * ) hb_parnl( 1 );
	Switch * Control = [ [ Switch alloc ] initWithFrame : CGRectMake( hb_parnl( 3 ), hb_parnl( 2 ), hb_parnl( 4 ), hb_parnl( 5 ) ) ];

	Control.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
	Control.on = YES;
	Control.tag = 1;
	
  [ Control addTarget : Control action : @selector( switchAction: ) forControlEvents : UIControlEventValueChanged ];
					
	[ window addSubview: Control ];
					
  hb_retnl( ( LONG ) Control );
}

HB_FUNC( SWITCHONOFF )
{
	UISwitch * Control = ( UISwitch * ) hb_parnl( 1 );
	
	[ Control setOn : hb_parl( 2 ) animated : YES ];	
}

HB_FUNC( SWITCHGETVALUE )
{
   UISwitch * Control = ( UISwitch * ) hb_parnl( 1 );
   
   hb_retl( Control.on );
} 


HB_FUNC( CREATESWITCHRESOURCES )
{
  Switch * Control = ( Switch * ) hb_parnl( 1 );
 [ Control addTarget : Control action : @selector( switchAction: ) forControlEvents : UIControlEventValueChanged ];
					
} 

#import <UIKit/UIKit.h>
#define HB_DONT_DEFINE_BOOL
#include <hbapi.h>
#include <hbvm.h>
#include <windows.h>
#include <fmsgs.h>

// static PHB_SYMB symFPH = NULL;

HB_FUNC( CREATEACTINDICATOR )
{
	UIWindow * window = ( UIWindow * ) hb_parnl( 1 );
    UIActivityIndicatorView * actind = [ [ UIActivityIndicatorView alloc ] initWithActivityIndicatorStyle : hb_parnl( 6 )];
	
	[ actind setFrame : CGRectMake( hb_parnl( 2 ), hb_parnl( 3 ), hb_parnl( 4 ), hb_parnl( 5 ) ) ];
	[ window addSubview : actind ];
	
	hb_retnl( ( LONG ) actind );
}

HB_FUNC( ACTINDSTART )
{
   UIActivityIndicatorView * actind = ( UIActivityIndicatorView * ) hb_parnl( 1 );
   
   [ actind startAnimating ];
} 

HB_FUNC( ACTINDSTOP )
{
   UIActivityIndicatorView * actind = ( UIActivityIndicatorView * ) hb_parnl( 1 );
   
   [ actind stopAnimating ];
}

HB_FUNC( ACTINDANIMATING )
{
   UIActivityIndicatorView * actind = ( UIActivityIndicatorView * ) hb_parnl( 1 );
   
   hb_retl( [ actind isAnimating ] );
}        

HB_FUNC( ACTINDSTYLE )
{
	UIActivityIndicatorView * actind = ( UIActivityIndicatorView * ) hb_parnl( 1 );
	
	[ actind setActivityIndicatorViewStyle :  hb_parnl( 2 ) ];
}
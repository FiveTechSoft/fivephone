#import <UIKit/UIKit.h>
#import <UIKit/UIApplication.h>
#define HB_DONT_DEFINE_BOOL
#include <hbapi.h>
#include <fwprototypes.h>

HB_FUNC( APPPATH )
{
   NSString * buPath = [ [ NSBundle mainBundle ] bundlePath ];

   hb_retc( [ buPath cStringUsingEncoding : NSASCIIStringEncoding ] );  	
}

NSInteger ScreenWidth( void )
{
   return [ [ UIScreen mainScreen ] bounds ].size.width;
}

NSInteger ScreenHeight( void )
{
   return [ [ UIScreen mainScreen ] bounds ].size.height;
}      

HB_FUNC( SCREENWIDTH )
{
   hb_retnl( ( LONG ) ScreenWidth() );
}

HB_FUNC( SCREENHEIGHT )
{
   hb_retnl( ( LONG ) ScreenHeight() );
} 

HB_FUNC( SETSTATUSBARHIDDEN )
{
	[ [ UIApplication sharedApplication ] setStatusBarHidden : YES animated : NO ];      
}

HB_FUNC( SETSTATUSACTIVITY )
{
	[UIApplication sharedApplication].networkActivityIndicatorVisible = hb_parl( 1 ) ;
}

HB_FUNC( GETUNIQUEIDENTIFIER )
{
NSString *uniqueIdentifier = [[UIDevice currentDevice] uniqueIdentifier];
 hb_retc( [ uniqueIdentifier cStringUsingEncoding : NSASCIIStringEncoding ] );	
}

HB_FUNC( SETBADGENUMBER )
{
	
[UIApplication sharedApplication].applicationIconBadgeNumber =  hb_parnl( 1 ) ;
}


HB_FUNC( GETCURRENTLOCALE )
{
 hb_retc( [[[NSLocale currentLocale] localeIdentifier]cStringUsingEncoding : NSASCIIStringEncoding ]);
 }
 
HB_FUNC( GETCURRENTLANGUAGE )
{ 
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
NSString *currentLanguage = [languages objectAtIndex:0];
 hb_retc( [currentLanguage cStringUsingEncoding : NSASCIIStringEncoding ] );
}

HB_FUNC( NSLOG )
{
   NSLog( @"%@", hb_NSSTRING_par( 1 ) );
}  


HB_FUNC( ISOS4 )
{

NSComparisonResult order = [[UIDevice currentDevice].systemVersion compare: @"4.0" options: NSNumericSearch];

if (order == NSOrderedSame || order == NSOrderedDescending) {

return hb_retl( YES );

} else {

return hb_retl( NO );

}

}


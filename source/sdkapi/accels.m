#import <UIKit/UIKit.h>
#define HB_DONT_DEFINE_BOOL
#include <hbapi.h>
#include <hbvm.h>
#include <windows.h>
#include <fmsgs.h>

#define kAccelerationThreshold 1.07

static PHB_SYMB symFPH = NULL;

@interface AccelDelegate : NSObject <UIAccelerometerDelegate>
{
    float acex ;
    float acey ;
    float acez ;   
    void * pSender;
}

- (float)getResultx;  
- (float)getResulty;
- (float)getResultz;

@end

@implementation AccelDelegate

- ( void ) accelerometer : ( UIAccelerometer * ) accelerometer didAccelerate : ( UIAcceleration * ) acceleration
{  
	acex = acceleration.x;
	acey = acceleration.y;
	acez = acceleration.z;
	
	if( fabsf( acceleration.x ) > kAccelerationThreshold || 
       fabsf( acceleration.y ) > kAccelerationThreshold || 
       fabsf( acceleration.z ) > kAccelerationThreshold )
	{
		if( symFPH == NULL )
			symFPH = hb_dynsymSymbol( hb_dynsymFindName( "FWEVENTS" ) );
		
		hb_vmPushSymbol( symFPH );
		hb_vmPushNil();
		hb_vmPush( pSender);
		hb_vmPushLong( WM_SHAKING );
		hb_vmDo( 2 );
	}              	
}

- ( void ) setSender : ( void * ) pS
{
   pSender = pS;
}

-(float)getResultx  
{  
    return acex ;  
}  

-(float)getResulty  
{  
    return acey ;  
}  

-(float)getResultz  
{  
    return acez ;  
}  

@end


HB_FUNC( CREATEACCELEROMETER )
{
    UIAccelerometer * accel = [ UIAccelerometer sharedAccelerometer ];
    AccelDelegate * delegate = [ [ AccelDelegate alloc ] init ];
	
    accel.updateInterval = 1.0f / 10.0f;
	
    accel.delegate = delegate;
   
   [ delegate setSender : hb_gcGripGet( hb_param( 1, HB_IT_ANY ) ) ];
	
    hb_retnl( ( LONG ) accel );
}

HB_FUNC( GETACCELEROMETERX )
{
	UIAccelerometer * accel = (UIAccelerometer * ) hb_parnl(1) ;
	AccelDelegate * delegate = [ [ AccelDelegate alloc ] init ];
	delegate= [accel delegate] ;
	
    float acex = [ delegate getResultx];  
	hb_retnd( acex ) ;
}    

HB_FUNC( GETACCELEROMETERY )
{
	UIAccelerometer * accel = (UIAccelerometer * ) hb_parnl(1) ;
	AccelDelegate * delegate = [ [ AccelDelegate alloc ] init ];
	delegate= [accel delegate] ;	
    float acey = [ delegate getResulty];  
	hb_retnd( acey);
}  

HB_FUNC( GETACCELEROMETERZ )
{
	UIAccelerometer * accel = (UIAccelerometer * ) hb_parnl(1) ;
	AccelDelegate * delegate = [ [ AccelDelegate alloc ] init ];
	delegate= [accel delegate] ;
	
    float acez = [ delegate getResultz];  
	hb_retnd( acez) ;
}  
        
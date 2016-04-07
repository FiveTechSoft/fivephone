#import <UIKit/UIKit.h>
#import <UIKit/UIApplication.h>
#define HB_DONT_DEFINE_BOOL
#include <hbapi.h>
#include <hbvm.h>
#include <windows.h>
#include <fmsgs.h>
#include <fwprototypes.h>
#import <fwprotocol.h>

static PHB_SYMB symFPH = NULL;


@interface Slider : UISlider 
{
   void * pSender;
}

@end

@implementation Slider

- ( void ) setSender : ( void * ) pS
{
   pSender = pS;
}

- ( void ) releaseSender
{
   hb_gcGripDrop( ( HB_ITEM_PTR ) pSender );
   pSender = NULL;
}


- ( void ) EventValueChanged : ( id ) sender
{
	if( symFPH == NULL )
		symFPH = hb_dynsymSymbol( hb_dynsymFindName( "FWEVENTS" ) );
	
   if( pSender ){
	hb_vmPushSymbol( symFPH );
	hb_vmPushNil();
	hb_vmPush( pSender );
	hb_vmPushLong( WM_VALUECHANGE );
	hb_vmDo( 2 );
   }
}

- ( void ) releaseObject : ( id ) sender
{
   [ sender removeFromSuperview ]; 
}

@end


HB_FUNC( CREATESLIDER )
{
	UIWindow * window = ( UIWindow * ) hb_parnl( 1 );
	Slider * slider = [ [ Slider alloc ] initWithFrame : CGRectMake( hb_parnl( 3 ), hb_parnl( 2 ), hb_parnl( 4 ), hb_parnl( 5 ) ) ];

	slider.minimumValue = hb_parnl( 7 ) / 1.0;      
	slider.maximumValue = hb_parnl( 8 ) / 1.0;
	slider.value = hb_parnl( 6 ) / 1.0; 
	
	[ slider addTarget:slider action:@selector(EventValueChanged:) forControlEvents:UIControlEventValueChanged];	
  [ slider setSender: hb_gcGripGet( hb_param( 9, HB_IT_ANY ) ) ];

	[ window addSubview : slider ];


hb_OBJECT_ret( slider );
//   hb_retl( ( LONG ) slider );
}


HB_FUNC( CREATESLIDERRESOURCES )
{
	UIWindow * window = ( UIWindow * ) hb_parnl( 1 );
  Slider * slider = (Slider *) [window viewWithTag:hb_parnl( 2 )];
  
  slider.minimumValue = hb_parnl( 4 ) / 1.0;      
	slider.maximumValue = hb_parnl( 5 ) / 1.0;
	slider.value = hb_parnl( 3 ) / 1.0; 
		
	[ slider addTarget:slider action:@selector(EventValueChanged:) forControlEvents:UIControlEventValueChanged];	
  [ slider setSender: hb_gcGripGet( hb_param( 6, HB_IT_ANY ) ) ];
	
	hb_OBJECT_ret( slider ); 
}


HB_FUNC( GETSLIDERVALUE )
{
//   Slider * slider = ( Slider * ) hb_parnl( 1 );
   Slider * slider = ( Slider * ) hb_OBJECT_par( 1 );
   
   hb_retnl( slider.value );
   
}


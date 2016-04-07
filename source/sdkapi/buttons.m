

#import <UIKit/UIKit.h>
#import <UIKit/UIApplication.h>
#define HB_DONT_DEFINE_BOOL
#include <hbapi.h>
#include <hbvm.h>
#include <windows.h>
#include <fwprototypes.h>
#include <fmsgs.h>

static PHB_SYMB symFPH = NULL;

void MsgInfoModal( NSString * text, NSString * title );

NSString * NumToStr( NSInteger myInt );

@interface Button : NSObject
{
@public 
	void * pSender;
	UIButton * button;
}
- ( void ) TouchUpInside : ( id ) sender;
- ( void ) setText : ( NSString * ) string : (UIControlState) nControlState;

@end

@implementation Button

//-------
- (id) init
{
	self = [ super init ];
	// this object is autorelease
	button = [ UIButton buttonWithType:UIButtonTypeRoundedRect ];
	[ button addTarget:self action:@selector(TouchUpInside:) forControlEvents:UIControlEventTouchUpInside ];
	
	return self;
}


//-------
- ( void ) setSender : ( void * ) pS
{
	pSender = pS;
}

//-------

- ( void ) setText :( NSString * ) string : (UIControlState) nControlState {

   [ button setTitle : string forState : nControlState];
}

//-------

- ( void ) releaseSender
{
	hb_gcGripDrop( ( HB_ITEM_PTR ) pSender );
	pSender = NULL;
}

//-------

- ( void ) TouchUpInside : ( id ) sender
{
	if( symFPH == NULL )
		symFPH = hb_dynsymSymbol( hb_dynsymFindName( "FWEVENTS" ) );
	
    if( pSender ){
		hb_vmPushSymbol( symFPH );
		hb_vmPushNil();
		hb_vmPush( pSender );
		hb_vmPushLong( WM_BUTTONUP );
		hb_vmDo( 2 );
    }
    
}

//-------

- ( void ) releaseObject : ( id ) sender
{
	[ button removeFromSuperview ];
}

@end



HB_FUNC( CREATEBUTTON ) 
{
	
	Button * button = [ [ Button alloc ] init ];
	NSString * string = hb_NSSTRING_par( 2 );
	UIWindow * window = ( UIWindow * ) hb_parnl( 1 );
	
	
	[ button->button setFrame:CGRectMake( (hb_parnl(4)/1.0), 
										 (hb_parnl(3)/1.0), 
										 (hb_parnl(5)/1.0),
										 (hb_parnl(6)/1.0) ) ];
	
	
	[ button setSender : hb_gcGripGet( hb_param( 7, HB_IT_ANY ) ) ];
	
	[ button setText : string : UIControlStateNormal ];
	[ window addSubview : button->button ];
	hb_OBJECT_ret( button );   

}   


HB_FUNC( CREATEBUTTONRESOURCES )
{
	Button * button = [ Button alloc ]; 
	UIWindow * window = ( UIWindow * ) hb_parnl( 1 );
   button->button = (UIButton *) [window viewWithTag:hb_parnl( 2 )];
  	
	[ button->button  addTarget:button action:@selector(TouchUpInside: ) forControlEvents:UIControlEventTouchUpInside ] ; 
	
   [ button setSender : hb_gcGripGet( hb_param( 3, HB_IT_ANY ) ) ];
	
	
	hb_OBJECT_ret( button ); 
}



HB_FUNC( SETIMAGEBUTTON ) 
{
	Button * button = ( Button * ) hb_OBJECT_par( 1 );
	NSString * imageNormal  = hb_NSSTRING_par( 2 );
	NSString * imagePressed = hb_NSSTRING_par( 3 );
	
	button->button.backgroundColor = [UIColor clearColor];
	[button->button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal ];
	
	UIImage *buttonImageNormal = [UIImage imageNamed: imageNormal ];
	UIImage *strechableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:12 topCapHeight:0];
	[button->button setBackgroundImage:strechableButtonImageNormal forState:UIControlStateNormal];
	
	UIImage *buttonImagePressed = [UIImage imageNamed: imagePressed ];
	UIImage *strechableButtonImagePressed = [buttonImagePressed stretchableImageWithLeftCapWidth:12 topCapHeight:0];
	[button->button setBackgroundImage:strechableButtonImagePressed forState:UIControlStateHighlighted];
	
}

HB_FUNC( BTNSETTEXT )
{
	Button * button = ( Button * ) hb_OBJECT_par( 1 );
	NSString * sText  = hb_NSSTRING_par( 2 );
   UIControlState nControlState = ( UIControlState ) ( hb_pcount() > 2 ? hb_parnl( 3 ) : UIControlStateNormal );
   
   [ button setText : sText : nControlState ] ;
   
}







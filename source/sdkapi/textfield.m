#import <UIKit/UIKit.h>
#import <UIKit/UIApplication.h>
#define HB_DONT_DEFINE_BOOL
#include <hbapi.h>
#include <windows.h>
#include <hbvm.h>
#include <fmsgs.h>
#include <fwprototypes.h>
#import <fwprotocol.h>

static PHB_SYMB symFPH = NULL;

void MsgInfo( NSString * text );
             
@interface textField : UITextField 
{
   void * pSender;
}

@end

@implementation textField

- ( void ) setSender : ( void * ) pS
{
   pSender = pS;
}

- ( void ) EventEditingChanged : ( id ) sender
{
	if( symFPH == NULL )
		symFPH = hb_dynsymSymbol( hb_dynsymFindName( "FWEVENTS" ) );
	
	hb_vmPushSymbol( symFPH );
	hb_vmPushNil();
   hb_vmPush( pSender );
   hb_vmPushLong( WM_EDITCHANGE );
	hb_vmDo( 2 );  
}

- ( void ) EventEditingBegin : ( id ) sender
{
	if( symFPH == NULL )
		symFPH = hb_dynsymSymbol( hb_dynsymFindName( "FWEVENTS" ) );
	
	hb_vmPushSymbol( symFPH );
	hb_vmPushNil();
	hb_vmPush( pSender );
	hb_vmPushLong( WM_EDITBEGIN );
	hb_vmDo( 2 );  
}


- ( void ) EventEditingEnd : ( id ) sender
{
	if( symFPH == NULL )
		symFPH = hb_dynsymSymbol( hb_dynsymFindName( "FWEVENTS" ) );
	
	hb_vmPushSymbol( symFPH );
	hb_vmPushNil();
	hb_vmPush( pSender );
	hb_vmPushLong( WM_EDITEND );
	hb_vmDo( 2 );  
}


@end

HB_FUNC( CREATETEXT )
{
	Window * window = ( Window * ) hb_parnl( 1 );
	NSString * title = hb_NSSTRING_par( 2 ); 	
	textField * TextField = [ [ [ textField alloc ] initWithFrame : CGRectMake( hb_parnl( 4 ), hb_parnl( 3 ), hb_parnl( 5 ), hb_parnl( 6 ) ) ] autorelease ];
	
	TextField.autoresizesSubviews = YES; 
	TextField.adjustsFontSizeToFitWidth = YES;
	TextField.textColor = [ UIColor blackColor ];
	TextField.font = [ UIFont systemFontOfSize : 17.0 ];
	TextField.placeholder = @"enter name";
	TextField.backgroundColor = [ UIColor clearColor ];
	TextField.autocorrectionType = UITextAutocorrectionTypeNo;        // no auto correction support
	TextField.autocapitalizationType = UITextAutocapitalizationTypeNone; // no auto capitalization support
	TextField.textAlignment = UITextAlignmentRight;
	TextField.borderStyle = UITextBorderStyleRoundedRect;
	TextField.keyboardType = UIKeyboardTypeDefault; // use the default type input method (entire keyboard)
	TextField.returnKeyType = UIReturnKeyDone;
	TextField.clearsContextBeforeDrawing = YES;
	TextField.clearsOnBeginEditing = NO;
	TextField.clipsToBounds = YES;
	TextField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
	TextField.tag = 0;
	TextField.contentMode = UIViewContentModeScaleToFill;
	TextField.contentStretch = CGRectFromString( @"{{0, 0}, {1, 1}}" );	
	TextField.textAlignment = UITextAlignmentLeft;	
	TextField.userInteractionEnabled = YES;
	
//	TextField.delegate = TextField;
					
	TextField.clearButtonMode = UITextFieldViewModeNever; // no clear 'x' button to the right
	TextField.text = title;
	
	[ TextField setAutoresizingMask:UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin];
	[ TextField setEnabled: YES ];
	[ TextField addTarget:TextField action:@selector(EventEditingChanged:) forControlEvents:UIControlEventEditingChanged];	
	[ TextField addTarget:TextField action:@selector(EventEditingBegin:) forControlEvents:UIControlEventEditingDidBegin];	
	[ TextField addTarget:TextField action:@selector(EventEditingEnd:) forControlEvents:UIControlEventEditingDidEnd];	
	[ TextField setSender: hb_gcGripGet( hb_param( 7, HB_IT_ANY ) ) ];
				
	[ window addSubview : TextField ];
	
	hb_retnl( ( LONG ) TextField );
	
	//hb_OBJECT_ret( TextField ); 
	
}


HB_FUNC( CREATETEXTRESOURCES )
{
	UIWindow * window = ( UIWindow * ) hb_parnl( 1 );
    textField * TextField = (textField * ) [window viewWithTag:hb_parnl( 2 )];
 	NSString * title = hb_NSSTRING_par( 3 ); 	
  
  TextField.text = title;
  [ TextField addTarget:TextField action:@selector(EventEditingChanged:) forControlEvents:UIControlEventEditingChanged];	
	[ TextField addTarget:TextField action:@selector(EventEditingBegin:) forControlEvents:UIControlEventEditingDidBegin];	
	[ TextField addTarget:TextField action:@selector(EventEditingEnd:) forControlEvents:UIControlEventEditingDidEnd];	
	
	[ TextField setSender: hb_gcGripGet( hb_param( 4, HB_IT_ANY ) ) ];
	 
	hb_retnl( ( LONG ) TextField );
	
	//hb_OBJECT_ret( TextField ); 
}


HB_FUNC( SETTEXTFIELD )
{
	UITextField * TextField = ( UITextField * ) hb_parnl( 1 );
   NSString * title = hb_NSSTRING_par( 2 );
 	TextField.text = title ;
}

HB_FUNC( GETTEXTFIELD )
{
   textField * TextField = ( textField * ) hb_parnl( 1 );
	
   hb_retc( [ TextField.text cStringUsingEncoding : NSASCIIStringEncoding ] );
}

HB_FUNC( SETPLACEHOLDERTEXT )
{
	UITextField * TextField = ( UITextField * ) hb_parnl( 1 );
   NSString * title = hb_NSSTRING_par( 2 );
  	
 	TextField.placeholder = title;
}

HB_FUNC( SETCLEARBEGINTEXT )
{
	UITextField * TextField = ( UITextField * ) hb_parnl( 1 );
	
 	TextField.clearsOnBeginEditing =  hb_parnl( 2 );
}

HB_FUNC( SETSECURETEXT )
{
	UITextField * TextField = ( UITextField * ) hb_parnl( 1 );
  
  [ TextField setSecureTextEntry : YES ];
}

HB_FUNC( SETTEXTCOLOR )
{
	UITextField * TextField = ( UITextField * ) hb_parnl( 1 );

	TextField.textColor = [ UIColor colorWithRed :  ( hb_parnl( 2 ) / 100.0 ) 
	                                         green: ( hb_parnl( 3 ) / 100.0 ) 
	                                         blue:  ( hb_parnl( 4 ) / 100.0 ) alpha : ( hb_parnl( 5 ) / 100.0 ) ];
}

HB_FUNC( SETTEXTFONT )
{
	UITextField * TextField = ( UITextField * ) hb_parnl( 1 );
	NSString * fontName = hb_NSSTRING_par( 2 );
	
	TextField.font = [ UIFont fontWithName: fontName size: hb_parnl( 3 ) ];
}

HB_FUNC( SETTEXTKEYBOARD )
{
	UITextField * TextField = ( UITextField * ) hb_parnl( 1 );
  TextField. keyboardType =  hb_parnl( 2 ) ;
}


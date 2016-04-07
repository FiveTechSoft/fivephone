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

void MsgInfoModal( NSString * text, NSString * title );

@interface ActionSheetDelegate : UIViewController <UIActionSheetDelegate> 
{
   void * pSender;
}

@end

@implementation ActionSheetDelegate

- ( void ) setSender : ( void * ) pS
{
   pSender = pS;
}

- ( void ) releaseSender
{
   hb_gcGripDrop( ( HB_ITEM_PTR ) pSender );
   pSender = NULL;
}


- ( void ) releaseObject : ( id ) sender
{
   [ sender removeFromSuperview ]; 
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(int)buttonIndex
{
   
   if( symFPH == NULL )
		symFPH = hb_dynsymSymbol( hb_dynsymFindName( "FWEVENTS" ) );
	
   
   if( pSender ){
      hb_vmPushSymbol( symFPH );
      hb_vmPushNil();
      hb_vmPush( pSender );
      hb_vmPushLong( WM_ITEMSEL );
      hb_vmPushInteger( buttonIndex );
      hb_vmDo( 3 );
   }
}

@end



static void AddButton( UIActionSheet * action, const char * lpzTitle ){

   [ action addButtonWithTitle: [ [ [ NSString alloc ] initWithCString: lpzTitle ] autorelease ] ];

}

HB_FUNC( CREATEACTIONSHEET )
{
   int iBtns = hb_parinfa( 4, 0 );
   int n;
	UIWindow * window = ( UIWindow * ) hb_parnl( 1 );
   ActionSheetDelegate * pDelegate = [ [ ActionSheetDelegate alloc ] init ];
   
	UIActionSheet * action = [ [ UIActionSheet alloc ] initWithTitle :ISCHAR( 3 ) ? hb_NSSTRING_par( 3 ) : nil
                                                            delegate:pDelegate
                                                   cancelButtonTitle:ISCHAR( 5 ) ? hb_NSSTRING_par( 5 ) : nil
                                              destructiveButtonTitle:ISCHAR( 6 ) ? hb_NSSTRING_par( 6 ) : nil
                                                   otherButtonTitles:nil ] ;
   
   action.actionSheetStyle = UIBarStyleDefault;
   
   if( n > 0 )
      for( n = 1; n <= iBtns; n++ ) 
         AddButton( action, hb_parvc( 4, n ) );

   
   [ pDelegate setSender: hb_gcGripGet( hb_param( 2, HB_IT_ANY ) ) ];
   [ action showInView: window ];


   [ action release ];

   hb_OBJECT_ret( action );
}



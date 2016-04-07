#import <UIKit/UIKit.h>
#import <UIKit/UIApplication.h>
#define HB_DONT_DEFINE_BOOL
#include <hbapi.h>
#include <hbvm.h>
#include <hbstack.h>
#include <hbset.h>
#include <hbdate.h>
#include <hbapiitm.h>
#include <windows.h>
#include <fmsgs.h>
#include <fwprototypes.h>
#import <fwprotocol.h>

static PHB_SYMB symFPH = NULL;


@interface DatePick : UIDatePicker 
{
   @public
   void * pSender;
   NSDateFormatter *dateFormatter;
}

@end

@implementation DatePick

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
   char * szDate;
	if( symFPH == NULL )
		symFPH = hb_dynsymSymbol( hb_dynsymFindName( "FWEVENTS" ) );
	
   if( pSender ){
      szDate = ( char *) [ [ NSString stringWithFormat:@"%@",
                  [ dateFormatter stringFromDate:self.date] ] cStringUsingEncoding : NSASCIIStringEncoding ];
      hb_vmPushSymbol( symFPH );
      hb_vmPushNil();
      hb_vmPush( pSender );
      hb_vmPushLong( WM_VALUECHANGE );
      hb_vmPushString( szDate, strlen( szDate ) );
      hb_vmDo( 3 );
   }
}

- ( void ) releaseObject : ( id ) sender
{
   [ sender removeFromSuperview ]; 
}

@end


HB_FUNC( CREATEDATEPICK )
{
	UIWindow * window = ( UIWindow * ) hb_parnl( 1 );
	DatePick * datePicker = [ [ DatePick alloc ] initWithFrame : CGRectMake( hb_parnl( 3 ), hb_parnl( 2 ), 325, 250 ) ];
   const char *  szDate = hb_parc( 4 );
   const char * szDateFormat = hb_setGetDateFormat();
   NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
   [dateFormatter setDateFormat: [ [ [ NSString alloc ] initWithCString: szDateFormat ] autorelease ] ];
   
	datePicker.datePickerMode = UIDatePickerModeDate;
	datePicker.hidden = NO;
	datePicker.date = [dateFormatter dateFromString:[ [ [ NSString alloc ] initWithCString: szDate ] autorelease ] ];
   
	[ datePicker addTarget:datePicker action:@selector(EventValueChanged:) forControlEvents:UIControlEventValueChanged];	
   
   [ datePicker setSender: hb_gcGripGet( hb_param( 5, HB_IT_ANY ) ) ];
   
	[ window addSubview : datePicker ];
   
   datePicker->dateFormatter = dateFormatter;
   
   hb_OBJECT_ret( datePicker );
}



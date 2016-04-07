/*
 * $Id
 */

/*
 * FivePhone source code:
 * GUI user messages
 *
 * Copyright 2010 Antonio Linares <alinares@fivetechsoft.com>
 * www - http://www.fivetechsoft.com
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2, or (at your option)
 * any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this software; see the file COPYING.  If not, write to
 * the Free Software Foundation, Inc., 59 Temple Place, Suite 330,
 * Boston, MA 02111-1307 USA (or visit the web site http://www.gnu.org/).
 *
 * As a special exception, this project gives permission for
 * additional uses of the text contained in the release of Harbour.
 *
 * The exception is that, if you link these libraries with other
 * files to produce an executable, this does not by itself cause the
 * resulting executable to be covered by the GNU General Public License.
 * Your use of that executable is in no way restricted on account of
 * linking this library code into it.
 *
 * This exception does not however invalidate any other reasons why
 * the executable file might be covered by the GNU General Public License.
 *
 * This exception applies only to the code released by this
 * Project under the name FivePhone.  If you copy code from other
 * projects or Free Software Foundation releases into this project,
 * as the General Public License permits, the exception does
 * not apply to the code that you add in this way.  To avoid misleading
 * anyone as to the status of such modified files, you must delete
 * this exception notice from them.
 *
 * If you write modifications of your own for FivePhone, it is your choice
 * whether to permit this exception to apply to your modifications.
 * If you do not wish that, delete this exception notice.
 *
 */
 
#import <UIKit/UIKit.h>
#define HB_DONT_DEFINE_BOOL
#include <hbapi.h>
#include <fwprototypes.h>
#include <windows.h>

#import <AudioToolbox/AudioToolbox.h>
 
UIApplication * GetApp( void );

@interface MyUIAlertViewDelegate : UIAlertView <UIAlertViewDelegate>
{
	NSInteger opcion ;
}	

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex ;

- (NSInteger)getResult;  

@end


@implementation MyUIAlertViewDelegate


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	opcion = buttonIndex ;
}

-(NSInteger)getResult  
{  
	return opcion ;  
}  


@end 

void __nsleep( int iSleep )
{
   struct timespec ts;
   ts.tv_sec = 0;
   ts.tv_nsec = iSleep;
   nanosleep (&ts, NULL);
}
   
HB_FUNC( MSGBEEP )
{
   // NSBeep();
}   


void MsgInfoModal( NSString * text, NSString * title )
{
	MyUIAlertViewDelegate *lpDelegate = [[MyUIAlertViewDelegate alloc] init];
	
	UIAlertView *lpAlertView = [ [ UIAlertView alloc ] initWithTitle : title 
															 message : text delegate : lpDelegate 
												   cancelButtonTitle : @"OK" otherButtonTitles : nil ];
	
	[lpAlertView show];
	
	// Run modally!
	while ((!lpAlertView.hidden) && (lpAlertView.superview!=nil))
	{
		[[NSRunLoop currentRunLoop] limitDateForMode:NSDefaultRunLoopMode];
		__nsleep(10);
	}
	[lpAlertView release];
	[lpDelegate release];
}



void MsgInfo( NSString * text )
{
	UIAlertView * alert = [ [ UIAlertView alloc ] initWithTitle : @"Information" 
                         message : text delegate : GetApp() 
                         cancelButtonTitle : @"OK" otherButtonTitles : nil ];  
   
  [ alert show ];
  [ alert autorelease ];                         
}
 
void MsgInfoTitle( NSString * text, NSString * title )
{
   UIAlertView * alert = [ [ UIAlertView alloc ] initWithTitle : title
                         message : text delegate : GetApp()
                         cancelButtonTitle : @"OK" otherButtonTitles : nil ];
   [ alert show ];
   [ alert autorelease ];
}                          
 

NSInteger MsgYesNoModal( NSString * text, NSString * title )
{
	MyUIAlertViewDelegate *lpDelegate = [[MyUIAlertViewDelegate alloc] init];
	
	UIAlertView *lpAlertView = [ [ UIAlertView alloc ] initWithTitle : title 
															 message : text delegate : lpDelegate 
												   cancelButtonTitle : @"NO" otherButtonTitles : @"SI" ,nil];
	
	[lpAlertView show];
	
	// Run modally!
	while ((!lpAlertView.hidden) && (lpAlertView.superview!=nil))
	{
		[[NSRunLoop currentRunLoop] limitDateForMode:NSDefaultRunLoopMode];
		__nsleep(10);
	}
	
	NSInteger opcion = [lpDelegate getResult];  
  	
	[lpAlertView release];
	[lpDelegate release];
	
	return opcion ;
}


void MsgYesNo( NSString * text , NSString * title )
{
   UIAlertView * alert = [ [ UIAlertView alloc ] initWithTitle :title 
                         message : text delegate : alert
                         cancelButtonTitle : @"No" otherButtonTitles : @"YES" , nil];
  [ alert show ];
	
  [ alert autorelease ];                         
}
 
HB_FUNC( MSGINFO )
{
	NSString * text, * title;
	
	if( ! ISCHAR( 1 ) )
	{
		ValToChar( hb_param( 1, -1 ) );
		text = hb_NSSTRING_par( -1 );
	}
	else
		text = hb_NSSTRING_par( 1 );

	if( hb_pcount() > 1 )
	{
		if( ! ISCHAR( 2 ) )
		{
			ValToChar( hb_param( 2, -1 ) );
			title = hb_NSSTRING_par( -1 );
		}
		else
			title = hb_NSSTRING_par( 2 );
	}
	else
		title = @"Information";
	
	MsgInfoTitle( text, title );
}

HB_FUNC( MSGYESNO )
{
	NSString * text = hb_NSSTRING_par( 1 );
	
	if( hb_pcount() > 1 )
		MsgYesNo( text, hb_NSSTRING_par( 2 ) );
	else   
		MsgYesNo( text, @"Attention" );
}

HB_FUNC( MSGYESNOMODAL )
{
	NSString * title;
	
	if( hb_pcount() > 1 )
		title = hb_NSSTRING_par( 2 );
	else
		title = @"Information";	
	
	hb_retnl( MsgYesNoModal( hb_NSSTRING_par( 1 ), title ) );
}


HB_FUNC( MSGINFOMODAL )
{
   NSString * title;
	
   if( hb_pcount() > 1 )
      title = hb_NSSTRING_par( 2 );
   else
      title = @"Information";	
      
   MsgInfoModal( hb_NSSTRING_par( 1 ), title );
}

HB_FUNC( MSGPAUSA )
{
	
	[[NSRunLoop currentRunLoop] limitDateForMode:NSDefaultRunLoopMode];
	__nsleep(100);

}

HB_FUNC( MSGACTIVITY )
{
	NSString * title = [ @"\n\n" stringByAppendingString : hb_NSSTRING_par( 1 ) ];
	
	//MsgInfo(@"si");
	
	UIAlertView *alert = [[[UIAlertView alloc] initWithTitle: title 
										message:nil delegate: alert cancelButtonTitle:nil otherButtonTitles: nil] autorelease];
	
	[alert show];
	
	UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
		
	//indicator.center = CGPointMake(150.0 , 120.0);	
	
	indicator.center = CGPointMake(alert.bounds.size.width/2 , alert.bounds.size.height - 50);
	[indicator startAnimating];
	[alert addSubview:indicator];
	[indicator release];	
	
	hb_retnl( ( LONG ) alert );
}	
	
HB_FUNC( DELMSGACTIVITY )
{
	UIAlertView * alert  = ( UIAlertView  * ) hb_parnl( 1 );
	
	[ alert dismissWithClickedButtonIndex:0 animated:YES];		
}	

HB_FUNC( MSGSILENTMODE ) 
{
	CFStringRef state;
	UInt32 propertySize = sizeof(CFStringRef);
	AudioSessionInitialize(NULL, NULL, NULL, NULL);
	AudioSessionGetProperty(kAudioSessionProperty_AudioRoute, &propertySize, &state);
 
	if(CFStringGetLength(state) == 0)
	{ 
  	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Silent mode" 
													message:@"Please turn sound on"
                					delegate: GetApp() cancelButtonTitle:@"Ok" 
             							otherButtonTitles:nil];
		[alert show];
		[alert release];
		hb_retl( YES );
	}
	else 
	{
		hb_retl( NO );
	}
}

HB_FUNC( MSGSOUND )
{
	SystemSoundID soundID;
	NSString *cSound = [ [ [ NSString alloc ] initWithCString: ISCHAR( 1 ) ? hb_parc( 1 ) : "" ] autorelease ];	
	NSString *sndPath = [[NSBundle mainBundle]  pathForResource: cSound ofType:@"caf" ];

	AudioServicesCreateSystemSoundID ((CFURLRef)[NSURL fileURLWithPath:sndPath], &soundID);
	AudioServicesPlaySystemSound (soundID);
	
	[sndPath release];
	
	//AudioServicesDisposeSystemSoundID(soundID);
}

//////// only for iphone ////////
  
HB_FUNC( MSGVIBRATE )
{        
	AudioServicesPlaySystemSound( kSystemSoundID_Vibrate ); 
}

HB_FUNC( GOTOMAPS )
{  
	NSString *cCity = [ [ [ NSString alloc ] initWithCString: ISCHAR( 1 ) ? hb_parc( 1 ) : "" ] autorelease ];	
	NSString *cURL =  [ [ [ NSString alloc ] initWithCString: "http://maps.google.com/maps?q="   ] autorelease ];	 
	
	cURL = [cURL stringByAppendingString:cCity ];
	
 	UIApplication *app = [UIApplication sharedApplication];  
 	[app openURL:[NSURL URLWithString:cURL]]; 
}

HB_FUNC( PHONECALL )
{
	NSString *ctelf = [ [ [ NSString alloc ] initWithCString: ISCHAR( 1 ) ? hb_parc( 1 ) : "" ] autorelease ]; 
	NSString *cURL =  [ [ [ NSString alloc ] initWithCString: "tel:"   ] autorelease ];     
	
	cURL = [cURL stringByAppendingString:ctelf ];
	NSURL *phoneNumberURL = [NSURL URLWithString: cURL ];
	[[UIApplication sharedApplication] openURL:phoneNumberURL];
}
 
HB_FUNC( SMSCALL )
{
	NSString * ctelf = [ [ [ NSString alloc ] initWithCString: ISCHAR( 1 ) ? hb_parc( 1 ) : "" ] autorelease ]; 
	NSString * cURL =  [ [ [ NSString alloc ] initWithCString: "sms:"   ] autorelease ]; 
	
	cURL = [cURL stringByAppendingString:ctelf ];
	NSURL * phoneNumberURL = [NSURL URLWithString: cURL ];
	[[UIApplication sharedApplication] openURL:phoneNumberURL];		
}

HB_FUNC( SETPROXIMONITOR )
{
	UIDevice * device = [ UIDevice currentDevice ];

	device.proximityMonitoringEnabled = YES;

	if( device.proximityMonitoringEnabled )
		[ device setProximityMonitoringEnabled : hb_parl( 1 ) ];
	else
		MsgInfo( @"No proximity sensor detected" );
}

HB_FUNC( MSGLOGO )
{
   Window * window = GetWndMain();
   UIImageView * logo = [ [ UIImageView alloc ] initWithImage : [ UIImage imageNamed : hb_NSSTRING_par( 1 ) ] ];
   
   [ window addSubview : logo ];
   window->logo = logo;
   
   [ window performSelector : @selector( removeLogo ) withObject : nil afterDelay : 3 ];
}     
/*
 * $Id
 */

/*
 * FivePhone source code:
 * webview support
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
#include <windows.h>
 
HB_FUNC( CREATEWEBVIEW )
{
   Window * window = ( Window * ) hb_parnl( 1 );
//	UIWebView *webview = [[UIWebView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 460.0)];	
	UIWebView *webview = [[UIWebView alloc] initWithFrame:CGRectMake((hb_parnl( 3 )/1.0), (hb_parnl( 2 )/1.0), (hb_parnl( 4 )/1.0), (hb_parnl( 5 )/1.0) )];
	webview.alpha = 1.000;
	webview.autoresizesSubviews = YES;
	webview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	webview.backgroundColor = [UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:1.000];
	webview.clearsContextBeforeDrawing = YES;
	webview.clipsToBounds = NO;
	webview.contentMode = UIViewContentModeScaleToFill;
	webview.contentStretch = CGRectFromString(@"{{0, 0}, {1, 1}}");
	webview.hidden = NO;
	webview.multipleTouchEnabled = NO;
	webview.opaque = YES;
	webview.scalesPageToFit = NO;
	webview.tag = 0;
	webview.userInteractionEnabled = YES;
	
	[window addSubview:webview];
	

   hb_retnl( ( LONG ) webview );
}

HB_FUNC( WEBVIEWLOADBUNDLEFILE )
{
  UIWebView *webview = (  UIWebView * ) hb_parnl( 1 );
NSString * cHtmlFile = [ [ [ NSString alloc ] initWithCString: ISCHAR(2) ? hb_parc(2) : "" ] autorelease ];
NSString *path = [[NSBundle mainBundle] pathForResource:cHtmlFile ofType:@"html"];
[webview loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath: path isDirectory:NO] ]];

}

HB_FUNC( WEBVIEWLOADBUNDLEPDF )
{
  UIWebView *webview = (  UIWebView * ) hb_parnl( 1 );
NSString * cHtmlFile = [ [ [ NSString alloc ] initWithCString: ISCHAR(2) ? hb_parc(2) : "" ] autorelease ];
NSString *path = [[NSBundle mainBundle] pathForResource:cHtmlFile ofType:@"pdf"];
[webview loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath: path isDirectory:NO] ]];

}


HB_FUNC( WEBVIEWLOADREQUEST ) 
{
	NSString * string = [ [ [ NSString alloc ] initWithCString: ISCHAR( 2 ) ? hb_parc( 2 ) : "" ] autorelease ]; 
	UIWebView * webview = ( UIWebView * ) hb_parnl( 1 );
	
	[ webview loadRequest : [ NSURLRequest requestWithURL : [ NSURL URLWithString : string ] ] ];	
} 


HB_FUNC( WEBVIEWGOBACK ) 
{
	UIWebView * Wview = ( UIWebView * ) hb_parnl( 1 );
	
	[ Wview goBack ];	
} 

HB_FUNC( WEBVIEWRELOAD )
{
	UIWebView * Wview = ( UIWebView * ) hb_parnl( 1 );
	
	[ Wview reload ];   
}


HB_FUNC( WEBVIEWGOFORWARD ) 
{
	UIWebView * Wview = ( UIWebView * ) hb_parnl( 1 );
	
	[ Wview goForward ];	
} 

HB_FUNC( WEBVIEWSTOPLOADING )
{
	UIWebView * Wview = ( UIWebView * ) hb_parnl( 1 );
	
	[ Wview stopLoading ];   
}
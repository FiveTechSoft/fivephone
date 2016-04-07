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


@interface SearchBar :  UISearchBar <UISearchBarDelegate>

{
}

- (void) searchBarTextDidBeginEditing:(SearchBar *)theSearchBar;
- (void)searchBar:(UISearchBar *)theSearchBar textDidChange:(NSString *)searchText ;
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar ;

@end


@implementation SearchBar 

- (void) searchBarTextDidBeginEditing:(SearchBar *)theSearchBar
{

	if( symFPH == NULL )
		symFPH = hb_dynsymSymbol( hb_dynsymFindName( "_FPH" ) );
	
	hb_vmPushSymbol( symFPH );
	hb_vmPushNil();
	hb_vmPushLong( ( LONG ) self);
	hb_vmPushLong( WM_SEARCHBEGIN );
	hb_vmDo( 2 );    
}

- (void)searchBar:(UISearchBar *)theSearchBar textDidChange:(NSString *)searchText
{
	
	if( symFPH == NULL )
		symFPH = hb_dynsymSymbol( hb_dynsymFindName( "_FPH" ) );
	
	hb_vmPushSymbol( symFPH );
	hb_vmPushNil();
	hb_vmPushLong( ( LONG ) self);
	hb_vmPushLong( WM_SEARCHCHANGE );
	hb_vmDo( 2 );    	

}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar

{
	
	if( symFPH == NULL )
		symFPH = hb_dynsymSymbol( hb_dynsymFindName( "_FPH" ) );
	
	hb_vmPushSymbol( symFPH );
	hb_vmPushNil();
	hb_vmPushLong( ( LONG ) self);
	hb_vmPushLong( WM_SEARCHVALID );
	hb_vmDo( 2 );    	
	
}


@end



HB_FUNC( CREATESEARCH )
{
	UIWindow * window = ( UIWindow * ) hb_parnl( 1 );
	
	SearchBar * searchbar = [[ SearchBar alloc] initWithFrame:CGRectMake( hb_parnl( 3 ), hb_parnl( 2 ), hb_parnl( 4 ), hb_parnl( 5 ) ) ];
	//searchbar.frame = CGRectMake(0.0, 0.0, 320.0, 44.0);
	searchbar.alpha = 1.000;
	searchbar.autoresizesSubviews = YES;
	searchbar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
	searchbar.barStyle = UIBarStyleDefault;
	searchbar.clearsContextBeforeDrawing = YES;
	searchbar.clipsToBounds = NO;
	searchbar.contentMode = UIViewContentModeRedraw;
	searchbar.contentStretch = CGRectFromString(@"{{0, 0}, {1, 1}}");
	searchbar.hidden = NO;
	searchbar.multipleTouchEnabled = NO;
	searchbar.opaque = YES;
	searchbar.scopeButtonTitles = [NSArray arrayWithObjects:nil];
	searchbar.showsBookmarkButton = NO;
	searchbar.showsCancelButton = NO;
	searchbar.showsScopeBar = NO;
	searchbar.showsSearchResultsButton = NO;
	searchbar.tag = 0;
	//searchbar.returnKeyType = UIReturnKeyDone;
	((UITextField *)[(NSArray *)[searchbar subviews] objectAtIndex:0]).returnKeyType = UIReturnKeyDone;	
	searchbar.userInteractionEnabled = YES;	
	searchbar.autocorrectionType = UITextAutocorrectionTypeNo;
	searchbar.delegate = searchbar ;
	
 [ window addSubview : searchbar ];

   hb_retnl( ( LONG ) searchbar );

}

HB_FUNC( CREATEFREESEARCH )
{
	//UIWindow * window = ( UIWindow * ) hb_parnl( 1 );
	
	SearchBar * searchbar = [[ SearchBar alloc] initWithFrame:CGRectMake( hb_parnl( 2 ), hb_parnl( 1 ), hb_parnl( 3 ), hb_parnl( 4 ) ) ];
	//searchbar.frame = CGRectMake(0.0, 0.0, 320.0, 44.0);
	searchbar.alpha = 1.000;
	searchbar.autoresizesSubviews = YES;
	searchbar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
	searchbar.barStyle = UIBarStyleDefault;
	searchbar.clearsContextBeforeDrawing = YES;
	searchbar.clipsToBounds = NO;
	searchbar.contentMode = UIViewContentModeRedraw;
	searchbar.contentStretch = CGRectFromString(@"{{0, 0}, {1, 1}}");
	searchbar.hidden = NO;
	searchbar.multipleTouchEnabled = NO;
	searchbar.opaque = YES;
	searchbar.scopeButtonTitles = [NSArray arrayWithObjects:nil];
	searchbar.showsBookmarkButton = NO;
	searchbar.showsCancelButton = NO;
	searchbar.showsScopeBar = NO;
	searchbar.showsSearchResultsButton = NO;
	searchbar.tag = 0;
	searchbar.userInteractionEnabled = YES;	
	searchbar.autocorrectionType = UITextAutocorrectionTypeNo;
	searchbar.delegate = searchbar ;
	
	//[ window addSubview : searchbar ];
	
	hb_retnl( ( LONG ) searchbar );
	
}





HB_FUNC( SETSEARCHUPPERTYPE )
{
	SearchBar *searchbar = ( SearchBar * ) hb_parnl( 1 );	
	searchbar.autocapitalizationType  =  hb_parnl( 2 );	
}

HB_FUNC( GETSEARCHTEXT )
{
	SearchBar *searchbar = ( SearchBar * ) hb_parnl( 1 );	
  NSString * cText = searchbar.text ;
  hb_retc( [ cText cStringUsingEncoding : NSASCIIStringEncoding ] );  	
}

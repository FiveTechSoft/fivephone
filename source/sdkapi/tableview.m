#import <UIKit/UIKit.h>
#define HB_DONT_DEFINE_BOOL
#include <hbapi.h>
#include <hbvm.h>
#include <windows.h>
#include <fmsgs.h>
#include <fwprototypes.h>

static PHB_SYMB symFPH = NULL;


@interface SearchBar :  UISearchBar

{
	
}

- (void) searchBarTextDidBeginEditing:(SearchBar *)theSearchBar;


@end


@interface TableViewController : UITableViewController <UITableViewDelegate>
{

}
- ( void ) tableView : ( UITableView * ) tableView didSelectRowAtIndexPath : ( NSIndexPath * ) indexPath; 
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath ;
@end

@implementation TableViewController

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	
	
	if( symFPH == NULL )
		symFPH = hb_dynsymSymbol( hb_dynsymFindName( "_FPH" ) );
	
	hb_vmPushSymbol( symFPH );
	hb_vmPushNil();
	hb_vmPushLong( ( LONG ) tableView );
	hb_vmPushLong( WM_CELLSTYLE );
	hb_vmPushLong( 0 );
	hb_vmPushLong( indexPath.row );
	hb_vmDo( 4 );
	
	NSInteger  style = hb_parnl( -1 ) ;
		
	return style ;
	
	/*if (tableView.editing == NO || !indexPath) return UITableViewCellEditingStyleNone;
	
	// Determine the editing style based on whether the cell is a placeholder for adding content or already
	// existing content. Existing content can be deleted.
	
	if ( indexPath.row == 4 )
	{
		return UITableViewCellEditingStyleInsert;
	}	
		
		
	if (tableView.editing )
		{
		if (  [ tableView numberOfRowsInSection:0 ]  == indexPath.row )
			    {
	
		return UITableViewCellEditingStyleInsert;
		} 
		else {
				return UITableViewCellEditingStyleDelete;
			}
	
	
	return UITableViewCellEditingStyleNone;
		}	
	 
	 */
}



- ( void ) tableView : ( UITableView * ) tableView didSelectRowAtIndexPath : ( NSIndexPath * ) indexPath 
{
	if( symFPH == NULL )
		symFPH = hb_dynsymSymbol( hb_dynsymFindName( "_FPH" ) );
	
	hb_vmPushSymbol( symFPH );
	hb_vmPushNil();
	hb_vmPushLong( ( LONG ) tableView );
	hb_vmPushLong( WM_BRWSELECT );
	hb_vmPushLong( 0 );
	hb_vmPushLong( indexPath.row );
	hb_vmPushLong( indexPath.section );
	hb_vmDo( 5 );
}

@end


@interface DataSource : NSObject <UITableViewDataSource>
{

}

- ( NSInteger ) tableView : ( UITableView * ) tableView numberOfRowsInSection : ( NSInteger ) section;
- ( UITableViewCell * ) tableView : ( UITableView * ) tableView cellForRowAtIndexPath : ( NSIndexPath * ) indexPath;
- ( NSString * ) tableView : ( UITableView * ) tableView titleForHeaderInSection : ( NSInteger )section;
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath ;

@end

@implementation DataSource

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		MsgInfo(@"delete") ;
		//[arryData removeObjectAtIndex:indexPath.row];
		[tableView reloadData];
		} 
	else
		{
			if (editingStyle == UITableViewCellEditingStyleInsert)
			{
				MsgInfo(@"aadd") ;	
				//[arryData insertObject:@"Mac Mini" atIndex:[arryData count]];
			  [tableView reloadData];
			}
		}	
	}
	

- ( NSInteger ) tableView : ( UITableView * ) tableView numberOfRowsInSection : ( NSInteger ) section 
{
	
   if( symFPH == NULL )
      symFPH = hb_dynsymSymbol( hb_dynsymFindName( "_FPH" ) );
   
   hb_vmPushSymbol( symFPH );
   hb_vmPushNil();
   hb_vmPushLong( ( LONG ) tableView );
   hb_vmPushLong( WM_BRWROWS );
   hb_vmDo( 2 );

	 NSInteger  count = hb_parnl( -1 ) ;
	
		
	return count ;
 
}

- ( UITableViewCell * ) tableView : ( UITableView * ) tableView cellForRowAtIndexPath : ( NSIndexPath * ) indexPath 
{
   static NSString * CellIdentifier = @"Cell";
	
	 UITableViewCell * cell = [ tableView dequeueReusableCellWithIdentifier : CellIdentifier ];
     NSString * text;
	
	
	
	
   if( cell == nil ) 	   
   {
	 cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"]autorelease ];
	//cell = [ [ [ UITableViewCell alloc ] initWithFrame : CGRectMake( 0, 0, 0, 0 ) reuseIdentifier : CellIdentifier ] autorelease ];
		   
	  }
	
	
	if( symFPH == NULL )
      symFPH = hb_dynsymSymbol( hb_dynsymFindName( "_FPH" ) );
   
	hb_vmPushSymbol( symFPH );
	hb_vmPushNil();
	hb_vmPushLong( ( LONG ) tableView );
	hb_vmPushLong( WM_BRWCELL );
	hb_vmPushLong( 0 );	
	hb_vmPushLong( ( LONG ) cell );
	hb_vmPushLong( indexPath.row );
	hb_vmDo( 5 );
	
 	cell =  ( UITableViewCell * ) hb_parnl( -1 ) ; 
	
   	 
	
		
   hb_vmPushSymbol( symFPH );
   hb_vmPushNil();
   hb_vmPushLong( ( LONG ) tableView );
   hb_vmPushLong( WM_BRWVALUE );
   hb_vmPushLong( 0 );	
   hb_vmPushLong( indexPath.row );
   hb_vmPushLong( indexPath.section );
   hb_vmDo( 5 );
   
	
		
   text = [ [ [ NSString alloc ] initWithCString: ISCHAR( -1 ) ? hb_parc( -1 ) : "" ] autorelease ];
   cell.textLabel.text = text;	
   
   hb_vmPushSymbol( symFPH );
   hb_vmPushNil();
   hb_vmPushLong( ( LONG ) tableView );
   hb_vmPushLong( WM_BRWCELLBACK );
   hb_vmDo( 2 );
   
   if( cell.backgroundView == nil && ISCHAR( -1 ) )
   {
      cell.backgroundView = [ [ [ UIImageView alloc ] initWithImage : [ UIImage imageNamed : hb_NSSTRING_par( -1 ) ] ] autorelease ];
      tableView.backgroundColor = [ UIColor clearColor ];
      tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
      cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
   }
      
   hb_vmPushSymbol( symFPH );
   hb_vmPushNil();
   hb_vmPushLong( ( LONG ) tableView );
   hb_vmPushLong( WM_BRWCELLIMAGE );
   hb_vmDo( 2 );
   
   if( ISCHAR( -1 ) )
      cell.imageView.image = [ UIImage imageNamed : hb_NSSTRING_par( -1 ) ];
	
		
	//cell.hidesAccessoryWhenEditing = YES;	
		
            
   return cell;  
} 

- ( NSString * ) tableView : ( UITableView * ) tableView titleForHeaderInSection : ( NSInteger ) section
{
	if( symFPH == NULL )
		symFPH = hb_dynsymSymbol( hb_dynsymFindName( "_FPH" ) );
	
	hb_vmPushSymbol( symFPH );
	hb_vmPushNil();
	hb_vmPushLong( ( LONG ) tableView );
	hb_vmPushLong( WM_BRWHEAD );
	hb_vmPushLong( 0 );
	hb_vmPushLong( section );
	hb_vmDo( 4 );
	
	return hb_NSSTRING_par( -1 );;  
}

@end
 
HB_FUNC( CREATEBRW )
{
	Window * window = ( Window * ) hb_parnl( 1 );
	DataSource * dataSource = [ [ DataSource alloc ] init ];
	TableViewController * tvc = [ [ TableViewController alloc ] init ];
	UITableView * tableview = [ [ UITableView alloc ] initWithFrame : CGRectMake( hb_parnl( 2 ), hb_parnl( 3 ), hb_parnl( 4 ) , hb_parnl( 5 ) ) style : UITableViewStylePlain ];
	
	[ tableview setAllowsSelectionDuringEditing:NO ];
	[ tableview setAlpha:1.000 ];
	[ tableview setAlwaysBounceHorizontal:NO ];
	[ tableview setAlwaysBounceVertical:YES ];
	[ tableview setAutoresizesSubviews:YES ];
	[ tableview setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight ];
	[ tableview setBackgroundColor:[UIColor colorWithWhite:1.000 alpha:1.000 ] ];
	[ tableview setBounces:YES ];
	[ tableview setBouncesZoom:YES ];
	[ tableview setCanCancelContentTouches:YES ];
	[ tableview setClearsContextBeforeDrawing:YES ];
	[ tableview setClipsToBounds:YES ];
	[ tableview setContentMode:UIViewContentModeScaleToFill ];
	[ tableview setContentStretch:CGRectFromString(@"{{0, 0}, {1, 1}}") ];
	[ tableview setDelaysContentTouches:YES ];
	[ tableview setDirectionalLockEnabled:NO ];
	[ tableview setHidden:NO ];
	[ tableview setIndicatorStyle:UIScrollViewIndicatorStyleDefault ];
	[ tableview setMaximumZoomScale:1.000 ];
	[ tableview setMinimumZoomScale:1.000 ];
	[ tableview setMultipleTouchEnabled:NO ];
	[ tableview setOpaque:YES ];
	[ tableview setPagingEnabled:NO ];
	[ tableview setRowHeight:44 ];
	[ tableview setScrollEnabled:YES ];
	[ tableview setSectionFooterHeight:22 ];
	[ tableview setSectionHeaderHeight:22 ];
	[ tableview setSectionIndexMinimumDisplayRowCount:0 ];
	[ tableview setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine ];
	[ tableview setShowsHorizontalScrollIndicator:YES ];
	[ tableview setShowsVerticalScrollIndicator:YES ];
	[ tableview setTag:0 ];
	[ tableview setUserInteractionEnabled:YES ];	
			
	tableview.dataSource = dataSource;
	tableview.delegate = tvc;
	
	if( ISNUM( 6 ) )
	   tableview.rowHeight = hb_parnl( 6 ); // cells height
	
	[ window addSubview : tableview ];
	
	hb_retnl( ( LONG ) tableview );
}

HB_FUNC( CREATEBRWGRP )
{
	Window * window = ( Window * ) hb_parnl( 1 );
	DataSource * dataSource = [ [ DataSource alloc ] init ];
	TableViewController * tvc = [ [ TableViewController alloc ] init ];
	UITableView * tableview = [ [ UITableView alloc ] initWithFrame : CGRectMake( hb_parnl( 2 ), hb_parnl( 3 ), hb_parnl( 4 ), hb_parnl( 5 ) ) style : UITableViewStyleGrouped ];
	
	[ tableview setAllowsSelectionDuringEditing:NO ];
	[ tableview setAlpha:1.000 ];
	[ tableview setAlwaysBounceHorizontal:NO ];
	[ tableview setAlwaysBounceVertical:YES ];
	[ tableview setAutoresizesSubviews:YES ];
	[ tableview setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight ];
	[ tableview setBackgroundColor:[UIColor colorWithWhite:1.000 alpha:1.000 ] ];
	[ tableview setBounces:YES ];
	[ tableview setBouncesZoom:YES ];
	[ tableview setCanCancelContentTouches:YES ];
	[ tableview setClearsContextBeforeDrawing:YES ];
	[ tableview setClipsToBounds:YES ];
	[ tableview setContentMode:UIViewContentModeScaleToFill ];
	[ tableview setContentStretch:CGRectFromString(@"{{0, 0}, {1, 1}}") ];
	[ tableview setDelaysContentTouches:YES ];
	[ tableview setDirectionalLockEnabled:NO ];
	[ tableview setHidden:NO ];
	[ tableview setIndicatorStyle:UIScrollViewIndicatorStyleDefault ];
	[ tableview setMaximumZoomScale:1.000 ];
	[ tableview setMinimumZoomScale:1.000 ];
	[ tableview setMultipleTouchEnabled:NO ];
	[ tableview setOpaque:YES ];
	[ tableview setPagingEnabled:NO ];
	[ tableview setRowHeight:44 ];
	[ tableview setScrollEnabled:YES ];
	[ tableview setSectionFooterHeight:22 ];
	[ tableview setSectionHeaderHeight:22 ];
	[ tableview setSectionIndexMinimumDisplayRowCount:0 ];
	[ tableview setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine ];
	[ tableview setShowsHorizontalScrollIndicator:YES ];
	[ tableview setShowsVerticalScrollIndicator:YES ];
	[ tableview setTag:0 ];
	[ tableview setUserInteractionEnabled:YES ];	
	
	tableview.dataSource = dataSource;
	tableview.delegate = tvc;
	
	if( ISNUM( 6 ) )
		tableview.rowHeight = hb_parnl( 6 ); // cells height	
	
	[ window addSubview : tableview ];
	
	hb_retnl( ( LONG ) tableview );
}


HB_FUNC( CREATEBRWRESOURCES )
{
	UITableView * tableview =  ( UITableView * ) hb_parnl( 1 );
	TableViewController * tvc = [ [ TableViewController alloc ] init ];
	DataSource * dataSource = [ [ DataSource alloc ] init ];
	tableview.dataSource = dataSource;
	tableview.delegate = tvc;
	
}


HB_FUNC( AADDSEARCHBRW )
{
	UITableView * tableview =  ( UITableView * ) hb_parnl( 1 );
/*
	SearchBar *searchbar = [[ SearchBar alloc] initWithFrame:CGRectMake( hb_parnl( 3 ), hb_parnl( 2 ), hb_parnl( 4 ), hb_parnl( 5 ) ) ];
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
*/	
    SearchBar *searchbar = ( SearchBar * ) hb_parnl( 2 );	 
	tableview.tableHeaderView = searchbar ;	
	
	//hb_retnl( ( LONG ) searchbar );
		
	
}


HB_FUNC( RELOADBRW )
{
	UITableView * tableview =  ( UITableView * ) hb_parnl( 1 );
	 [ tableview reloadData ];
}


HB_FUNC( DELSEARCHBRW )
{
	UITableView * tableview =  ( UITableView * ) hb_parnl( 1 );
	tableview.tableHeaderView = nil ;	
}


HB_FUNC( SETEDITMODEBRW )
{
	UITableView * tableview =  ( UITableView * ) hb_parnl( 1 );
	[ tableview setEditing: hb_parl( 2 )  animated: YES];
}


HB_FUNC( SETBRWBACKCLEAR)
{
	UITableView * tableview =  ( UITableView * ) hb_parnl( 1 );	
	tableview.backgroundColor = [ UIColor clearColor ];
}


HB_FUNC( SETBRWSEPARATORSTYLE)
{
	UITableView *tableview = ( UITableView * ) hb_parnl( 1 );	
	tableview.separatorStyle = hb_parnl( 2 ) ; 
}

HB_FUNC( SETBRWSEPARATORCOLOR)
{
	UITableView *tableview = ( UITableView * ) hb_parnl( 1 );	
	tableview.separatorColor = [UIColor colorWithRed:(hb_parnl( 2 )/255.0) green: (hb_parnl( 3 )/255.0) blue:(hb_parnl( 4 )/255.0) alpha:(hb_parnl( 5 )/100.0)];
}


HB_FUNC( FILTRADO )
{
	NSString * searchText = [ [ [ NSString alloc ] initWithCString: ISCHAR( 2 ) ? hb_parc( 2 ) : "" ] autorelease ];	
    NSString * eleText = [ [ [ NSString alloc ] initWithCString: ISCHAR( 1 ) ? hb_parc( 1 ) : "" ] autorelease ];
	
	NSRange titleResultsRange = [eleText rangeOfString:searchText options:NSCaseInsensitiveSearch];
		
		if (titleResultsRange.length > 0)
		{
			 hb_retl( YES );	
		}
	   else {
		   hb_retl(NO) ;
	   }

}



#import <UIKit/UIKit.h>
#import <UIKit/UIApplication.h>
#define HB_DONT_DEFINE_BOOL
#include <hbapi.h>
#include <windows.h>
#include <fwprototypes.h>
#include <fmsgs.h>





HB_FUNC( CREATECELL )
{
	
 //UITableViewCell *tableviewcell = [ [ [ UITableViewCell alloc ] initWithFrame : CGRectMake( 0, 0, 0, 0 ) reuseIdentifier :@"miCell" ] autorelease ];
	
	UITableViewCell *tableviewcell = [[[UITableViewCell alloc] initWithStyle: hb_parnl( 1 ) reuseIdentifier:@"Cell"]autorelease];
	tableviewcell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
	/*
	tableviewcell.alpha = 1.000;
	tableviewcell.autoresizesSubviews = YES;
	tableviewcell.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
	tableviewcell.backgroundColor = [UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:1.000];
	tableviewcell.clearsContextBeforeDrawing = YES;
	tableviewcell.clipsToBounds = NO;
	tableviewcell.contentMode = UIViewContentModeScaleToFill;
	tableviewcell.contentStretch = CGRectFromString(@"{{0, 0}, {1, 1}}");
	tableviewcell.detailTextLabel.font = [UIFont fontWithName:@"Helvetica" size:17.000];
	tableviewcell.detailTextLabel.highlightedTextColor = [UIColor colorWithWhite:1.000 alpha:1.000];
	tableviewcell.detailTextLabel.lineBreakMode = UILineBreakModeTailTruncation;
	tableviewcell.detailTextLabel.textAlignment = UITextAlignmentLeft;
	tableviewcell.detailTextLabel.textColor = [UIColor colorWithWhite:0.000 alpha:1.000];
	tableviewcell.editingAccessoryType = UITableViewCellAccessoryNone;
	tableviewcell.hidden = NO;
	tableviewcell.indentationLevel = 0;
	tableviewcell.indentationWidth = 10.000;
	tableviewcell.multipleTouchEnabled = NO;
	tableviewcell.opaque = YES;
	tableviewcell.selectionStyle = UITableViewCellSelectionStyleBlue;
	tableviewcell.shouldIndentWhileEditing = YES;
	tableviewcell.showsReorderControl = NO;
	tableviewcell.tag = 0;
	tableviewcell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:17.000];
	tableviewcell.textLabel.highlightedTextColor = [UIColor colorWithWhite:1.000 alpha:1.000];
	tableviewcell.textLabel.lineBreakMode = UILineBreakModeTailTruncation;
	tableviewcell.textLabel.textAlignment = UITextAlignmentLeft;
	tableviewcell.textLabel.textColor = [UIColor colorWithWhite:0.000 alpha:1.000];
	tableviewcell.userInteractionEnabled = YES;
	*/
	hb_retnl( ( LONG ) tableviewcell );
	
	
}


HB_FUNC( SETCELLACESORY )
{
	UITableViewCell *tableviewcell = ( UITableViewCell * ) hb_parnl( 1 );	
	tableviewcell.accessoryType = hb_parnl( 2 );
}


HB_FUNC( SETCELLDETAIL)
{
	NSString * text  = hb_NSSTRING_par( 2 );
	UITableViewCell *tableviewcell = ( UITableViewCell * ) hb_parnl( 1 );	
	tableviewcell.detailTextLabel.text = text ; 
}


HB_FUNC( SETCELLIMAGE)
{
	UITableViewCell *tableviewcell = ( UITableViewCell * ) hb_parnl( 1 );	
	tableviewcell.imageView.image = [ UIImage imageNamed : hb_NSSTRING_par( 2 ) ];
}

HB_FUNC( SETCELLBACKVIEW)
{
UITableViewCell *tableviewcell = ( UITableViewCell * ) hb_parnl( 1 );
//UITableView *tableview = ( UITableView * ) hb_parnl( 2 );

tableviewcell.backgroundColor = [ UIColor clearColor ];
tableviewcell.backgroundView = [ [ [ UIImageView alloc ] initWithImage : [ UIImage imageNamed : hb_NSSTRING_par( 2 ) ] ] autorelease ];
}

HB_FUNC( SETCELLSETBACKCOLOR)
{
	UITableViewCell *tableviewcell = ( UITableViewCell * ) hb_parnl( 1 );
	
	tableviewcell.backgroundColor= [UIColor colorWithRed:(hb_parnl(2 )/255) green:( hb_parnl( 3 )/255) blue:(hb_parnl( 4 )/255) alpha:(hb_parnl( 5 )/100.0)];
}

HB_FUNC( SETCELLSETDETAILCOLOR)
{
	UITableViewCell *tableviewcell = ( UITableViewCell * ) hb_parnl( 1 );	
	tableviewcell.detailTextLabel.textColor = [UIColor colorWithRed:(hb_parnl( 2 )/255.0) green: (hb_parnl( 3 )/255.0) blue:(hb_parnl( 4 )/255.0) alpha:(hb_parnl( 5 )/100.0)];
}

HB_FUNC( SETCELLTEXTCOLOR)
{
	UITableViewCell *tableviewcell = ( UITableViewCell * ) hb_parnl( 1 );	
	tableviewcell.textLabel.textColor = [UIColor colorWithRed:(hb_parnl( 2 )/255.0) green: (hb_parnl( 3 )/255.0) blue:(hb_parnl( 4 )/255.0) alpha:(hb_parnl( 5 )/100.0)];
}

HB_FUNC( SETCELLSETTEXT)
{
	NSString * text  = hb_NSSTRING_par( 2 );
	UITableViewCell *tableviewcell = ( UITableViewCell * ) hb_parnl( 1 );	
	tableviewcell.textLabel.text = text ; 
}

HB_FUNC( SETCELLSELSTYLE)
{
	UITableViewCell *tableviewcell = ( UITableViewCell * ) hb_parnl( 1 );	
	tableviewcell.selectionStyle = hb_parnl( 2 ) ; 
}

HB_FUNC( SETCELLEDITMODE)
{
	UITableViewCell *tableviewcell = ( UITableViewCell * ) hb_parnl( 1 );	
	[ tableviewcell setEditing: hb_parl( 2 ) animated:YES ]; 
	
	// tableviewcell.editingStyle = hb_parnl( 3 ) ; 	
}

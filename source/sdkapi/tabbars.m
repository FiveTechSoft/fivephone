#import <UIKit/UIKit.h>
#import <UIKit/UIApplication.h>
#define HB_DONT_DEFINE_BOOL
#include <hbapi.h>
#include <hbvm.h>
#include <windows.h>
#include <fmsgs.h>

static PHB_SYMB symFPH = NULL;

@interface TabBar : UITabBar <UITabBarDelegate>
{
}
- ( void ) tabBar : ( UITabBar * ) tabBar didSelectItem : ( UITabBarItem * ) item;
@end

@implementation TabBar

- ( void ) tabBar : ( UITabBar * ) tabBar didSelectItem : ( UITabBarItem * ) item
{
   if( symFPH == NULL )
      symFPH = hb_dynsymSymbol( hb_dynsymFindName( "_FPH" ) );
   
   hb_vmPushSymbol( symFPH );
   hb_vmPushNil();
   hb_vmPushLong( ( LONG ) self );
   hb_vmPushLong( WM_ITEMSEL );
   hb_vmDo( 2 );            
}

@end

HB_FUNC( CREATETABBAR )
{
   UIWindow * window = ( UIWindow * ) hb_parnl( 1 );
   TabBar * tabbar = [ [ TabBar alloc ] initWithFrame : CGRectMake( 0, ScreenHeight() - 49, ScreenWidth(), 49 ) ];
   
   [ tabbar setAutoresizesSubviews : YES ];
   [ tabbar setAutoresizingMask : UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin ];
   [ tabbar setClipsToBounds : NO ];
   [ tabbar setContentMode : UIViewContentModeScaleToFill ];
   [ tabbar setMultipleTouchEnabled : NO ];
   
   tabbar.delegate = tabbar;
   
   [ window addSubview : tabbar ];
   
   hb_retnl( ( LONG ) tabbar );
}



HB_FUNC( CREATETABBARRESOURCES )
{
   UIWindow * window = ( UIWindow * ) hb_parnl( 1 );
   TabBar * tabbar = (TabBar *) [window viewWithTag:hb_parnl( 2 )];
   tabbar.delegate = tabbar ; 
   hb_retnl( ( LONG ) tabbar ); 
} 



HB_FUNC( CREATEITEMTABBAR )
{
   UITabBar * tabbar = ( UITabBar * ) hb_parnl( 1 );
   UITabBarItem * item = [ [ UITabBarItem alloc ] initWithTabBarSystemItem : hb_parnl( 2 ) tag : 0 ];
   NSMutableArray * items = [ [ NSMutableArray alloc ] init ];
   
   for( UITabBarItem * tabbaritem in [ tabbar items ] ) 
      [ items addObject : tabbaritem ];
   
   [ items addObject : item ];
   [ tabbar setItems : items animated : YES ];          
   
   hb_retnl( ( LONG ) item );
}       


HB_FUNC( CREATECUSTOMITEMTABBAR )
{
   UITabBar * tabbar = ( UITabBar * ) hb_parnl( 1 );
   NSString * title = [ [ [ NSString alloc ] initWithCString: ISCHAR( 2 ) ? hb_parc( 2 ) : "" ] autorelease ];    
   NSString * cImage = [ [ [ NSString alloc ] initWithCString: ISCHAR( 3 ) ? hb_parc( 3 ) : "" ] autorelease ];
   UIImage * image   = [ [ UIImage imageNamed : cImage ] autorelease ];
   
   UITabBarItem * item = [ [ UITabBarItem alloc ] initWithTitle: title image: image tag: 0 ];
   
   NSMutableArray * items = [ [ NSMutableArray alloc ] init ];
   
   for( UITabBarItem * tabbaritem in [ tabbar items ] ) 
      [ items addObject : tabbaritem ];
   
   [ items addObject : item ];
   [ tabbar setItems : items animated : YES ];          
   
   hb_retnl( ( LONG ) item );
}       


HB_FUNC( SETITEMTABBARBADGE )
{
   UITabBarItem * item =( UITabBarItem * ) hb_parnl( 1 );
   NSString * text = [ [ [ NSString alloc ] initWithCString: ISCHAR( 2 ) ? hb_parc( 2 ) : "" ] autorelease ];     
   item.badgeValue = text ;
}



HB_FUNC( TABITEMS )
{
  UITabBar * tabbar = ( UITabBar * ) hb_parnl( 1 );
  hb_retnl( [[ tabbar items ] count ] );
}


HB_FUNC( TABBARAT )
{
   UITabBar * tabbar = ( UITabBar * ) hb_parnl( 1 );
   long lAt = 1;
   
   for( UITabBarItem * item in [ tabbar items ] )
   {
      if( item == tabbar.selectedItem )
      {
         hb_retnl( lAt );
         return;
      }   
      else
         lAt++;
   }   
   
   hb_retnl( 0 );
}
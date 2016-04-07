#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#define HB_DONT_DEFINE_BOOL
#include <hbapi.h>

@interface DataSource : NSObject <UIPickerViewDataSource>
{
   @public NSMutableArray * items;
}
- ( NSInteger ) numberOfComponentsInPickerView : ( UIPickerView * ) pickerView;
- ( NSInteger ) pickerView : ( UIPickerView * ) pickerView numberOfRowsInComponent : ( NSInteger ) component;
@end

@implementation DataSource

- ( NSInteger ) numberOfComponentsInPickerView : ( UIPickerView * ) pickerView
{
   return 1;
}

- ( NSInteger ) pickerView : ( UIPickerView * ) pickerView numberOfRowsInComponent : ( NSInteger ) component
{
   return [ items count ];
}   

@end

@interface PickerView : UIPickerView <UIPickerViewDelegate>
{
}
- ( NSString * ) pickerView : ( UIPickerView * ) pickerView titleForRow : ( NSInteger ) row forComponent : ( NSInteger ) component;
@end

@implementation PickerView 

- ( NSString * ) pickerView : ( UIPickerView * ) pickerView titleForRow : ( NSInteger ) row forComponent : ( NSInteger ) component
{
   return [ ( ( DataSource * ) pickerView.dataSource )->items objectAtIndex : row ];
}

@end

HB_FUNC( CREATEPICKERVIEW )
{
	 UIWindow * window = ( UIWindow * ) hb_parnl( 1 );
   PickerView * picker = [ [ PickerView alloc ] 
                             initWithFrame : CGRectMake( hb_parnl( 4 ), hb_parnl( 3 ), hb_parnl( 5 ), hb_parnl( 6 ) ) ];
   DataSource * dataSource = [ [ DataSource alloc ] init ];
   int n;
	
	 dataSource->items = [ [ NSMutableArray alloc ] init ];
	 for( n = 1; n <= hb_parinfa( 2, 0 ); n++ )
	    [ dataSource->items addObject : [ [ [ NSString alloc ] initWithCString: hb_parvc( 2, n ) ] autorelease ] ];
	  
	 picker.dataSource = dataSource;
	 [ picker setDelegate : picker ];
	 [ picker selectRow : 1 inComponent : 0 animated : NO ];
	
	 [ window addSubview : picker ];
	
	 hb_retnl( ( LONG ) picker );
}


HB_FUNC( CREATEPICKERRESOURCES )
{
	 PickerView * picker =   ( PickerView * ) hb_parnl( 1 );
	 
	 DataSource * dataSource = [ [ DataSource alloc ] init ];
   int n;
	
	 dataSource->items = [ [ NSMutableArray alloc ] init ];
	 for( n = 1; n <= hb_parinfa( 2, 0 ); n++ )
	    [ dataSource->items addObject : [ [ [ NSString alloc ] initWithCString: hb_parvc( 2, n ) ] autorelease ] ];
	  
	 picker.dataSource = dataSource;
	 [ picker setDelegate : picker ];
	 [ picker selectRow : 1 inComponent : 0 animated : NO ];	
	 
}
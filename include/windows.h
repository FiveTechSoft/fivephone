#ifndef _WINDOWS_H
#define _WINDOWS_H

UIApplication * GetApp( void );

void MsgInfo( NSString * );

@interface Window : UIWindow
{
   @public UIView * logo;
}
- ( void ) touchesBegan : ( NSSet * ) touches withEvent : ( UIEvent * ) event;
- ( void ) BarLeftClick : ( id ) sender;
- ( void ) BarRightClick : ( id ) sender;
- ( void ) ToolBarClick : ( id ) sender;
- ( void ) onTimerEvent : ( NSTimer * ) timer;
@end 

Window * GetWndMain( void );

NSInteger ScreenWidth( void );
NSInteger ScreenHeight( void );

#endif

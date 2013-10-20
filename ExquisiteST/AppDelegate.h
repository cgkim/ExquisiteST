//
//  AppDelegate.h
//  ExquisiteST
//
//  Created by kim on 13-10-11.
//
//

#import <UIKit/UIKit.h>
#import "BaseTabBarController.h"
#import "HomeController.h"
#import "TQLYController.h"
#import "TZSTController.h"
#import "WebController.h"

#import "RESTfulEngine.h"
#define NTAppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) BaseTabBarController *tab;

@property (strong, nonatomic) HomeController *home;
@property (strong, nonatomic) TQLYController *tqly;
@property (strong, nonatomic) TZSTController *tzst;
@property (strong, nonatomic) WebController *weibo;

@property (strong, nonatomic) RESTfulEngine *engine;

@end

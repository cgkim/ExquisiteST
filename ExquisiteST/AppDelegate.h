//
//  AppDelegate.h
//  ExquisiteST
//
//  Created by kim on 13-10-11.
//
//

#import <UIKit/UIKit.h>

#import "HomeController.h"
#import "RESTfulEngine.h"
#define NTAppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@property (strong, nonatomic) HomeController *home;
@property (strong, nonatomic) RESTfulEngine *engine;

@end

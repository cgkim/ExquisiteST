//
//  AppDelegate.m
//  ExquisiteST
//
//  Created by kim on 13-10-11.
//
//

#import "AppDelegate.h"

#import "BaseNavigationController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [UIApplication sharedApplication].statusBarHidden = NO;
    
    self.engine = [[RESTfulEngine alloc] initWithHostName:BASE_URL];
//    [self.engine useCache];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self initBaseControllers];
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark Helpers

- (void)initBaseControllers {
    self.home = [[HomeController alloc] initWithNibName:nil bundle:nil];
    self.home.title = @"精致汕头";
    BaseNavigationController *homeNav = [[BaseNavigationController alloc] initWithRootViewController:self.home];
    homeNav.tabBarItem.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"icon_home" ofType:@"png"]];
    homeNav.tabBarItem.title = @"首页";
    
    self.tqly = [[TQLYController alloc] initWithNibName:nil bundle:nil];
    self.tqly.title = @"特区掠影";
    BaseNavigationController *tqlyNav = [[BaseNavigationController alloc] initWithRootViewController:self.tqly];
    tqlyNav.tabBarItem.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"icon_sar" ofType:@"png"]];
    
    self.tzst = [[TZSTController alloc] initWithNibName:nil bundle:nil];
    self.tzst.title = @"投资汕头";
    BaseNavigationController *tzstNav = [[BaseNavigationController alloc] initWithRootViewController:self.tzst];
    tzstNav.tabBarItem.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"icon_invest" ofType:@"png"]];
    
    self.weibo = [[WebController alloc] initWithNibName:nil bundle:nil];
    self.weibo.title = @"政府微博";
    self.weibo.urlString = @"http://3g.shantou.gov.cn/";
    BaseNavigationController *weiboNav = [[BaseNavigationController alloc] initWithRootViewController:self.weibo];
    weiboNav.tabBarItem.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"icon_weibo" ofType:@"png"]];
    
    self.tab = [[BaseTabBarController alloc] initWithNibName:nil bundle:nil];
    self.tab.viewControllers = @[homeNav, tqlyNav, tzstNav, weiboNav];
    self.tab.tabBar.backgroundColor = [UIColor colorWithRed:33/255.0 green:33/255.0 blue:33/255.0 alpha:1.0];
    if ([self.tab.tabBar respondsToSelector:@selector(barTintColor)]) {
        self.tab.tabBar.barTintColor = [UIColor colorWithRed:33/255.0 green:33/255.0 blue:33/255.0 alpha:1.0];
        self.tab.tabBar.tintColor = [UIColor colorWithRed:45/255.0 green:159/255.0 blue:255/255.0 alpha:1.0];   // iOS7 选中的颜色
    }
    self.window.rootViewController = self.tab;
}

//- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
//{
//    return UIInterfaceOrientationMaskPortrait;
//}


@end

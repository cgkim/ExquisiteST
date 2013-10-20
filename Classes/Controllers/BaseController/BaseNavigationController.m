//
//  BaseNavigationController.m
//  ExquisiteST
//
//  Created by kim on 13-10-12.
//
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        UIImage *navBg = [[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"navbg" ofType:@"png"]] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
//        [self.navigationBar setBackgroundImage:navBg forBarMetrics:UIBarMetricsDefault];
//        self.navigationBar.tintColor = [UIColor colorWithRed:58/255.0 green:105/255.0 blue:144/255.0 alpha:1];
        self.navigationBar.tintColor = [UIColor colorWithRed:0 green:47/255.0 blue:196/255.0 alpha:1];
        
        self.tabBarItem.titlePositionAdjustment = UIOffsetMake(0.0, -2.0);
        
        // iOS7+
        if ([self.navigationBar respondsToSelector:@selector(barTintColor)]) {
            
        }
    }
    return self;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration

{
    if (UIInterfaceOrientationIsLandscape(interfaceOrientation))
    {
        // landscape
        NSLog(@"landscape");
    }
    else
    {
        //portrait
        NSLog(@"portrait");
    }
}

#pragma mark -
- (BOOL)shouldAutorotate
{
    return self.topViewController.shouldAutorotate;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return self.topViewController.supportedInterfaceOrientations;
}

@end

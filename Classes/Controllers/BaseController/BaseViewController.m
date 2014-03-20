//
//  BaseViewController.m
//  ExquisiteST
//
//  Created by kim on 13-10-12.
//
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]){
            self.edgesForExtendedLayout = 0;
            self.extendedLayoutIncludesOpaqueBars = NO; // 指定了当Bar使用了不透明图片时，视图是否延伸至Bar所在区域，默认值时NO
            self.automaticallyAdjustsScrollViewInsets = YES; // 默认YES，如果视图里面存在唯一一个UIScrollView或其子类View，那么它会自动设置相应的内边距，这样可以让scroll占据整个视图，又不会让导航栏遮盖
//            self.edgesForExtendedLayout = UIRectEdgeNone;
//            self.extendedLayoutIncludesOpaqueBars = YES;
        }
        
        self.view.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

// 卸载界面，用于在收到内存警告时调用
- (void)unLoadViews {
    // TODO 具体的释放操作
    // 具体可以在子类中去实现
}

// IOS6.x 不再会调到此方法
- (void)viewDidUnload {
    [super viewDidUnload];
    [self unLoadViews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    if (![self isViewLoaded]) {
        return; // 这里做好异常处理
    }
    
    // 6.0以前屏蔽以下代码，否则会在下面使用self.view时自动加载viewDidLoad
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0) {
        if (self.view.window == nil)// 是否是正在使用的视图
        {
            [self unLoadViews];
            // 下面这句代码，目的是再次进入时能够重新加载
            self.view = nil;
        }
    }
}

#pragma mark -
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

@end

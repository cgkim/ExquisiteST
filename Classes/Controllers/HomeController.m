//
//  HomeController.m
//  ExquisiteST
//
//  Created by kim on 13-10-12.
//
//

#import "HomeController.h"
#import "ScrollPageView.h"
#import "NimbusLauncher.h"
#import <QuartzCore/QuartzCore.h>

#import "XMLDictionary.h"
#import "AppDelegate.h"
#import "News.h"

#import "BaseNavigationController.h"
#import "TableController.h"
#import "CollectionController.h"
#import "ZBSTController.h"
#import "Table2Controller.h"
#import "WebController.h"


static NSString *const kButtonReuseIdentifier = @"launcherButton";

@interface HomeController () <ScrollPageViewDelegate, NILauncherDelegate>

@property (weak, nonatomic) ScrollPageView *scrollPageView;
@property (strong, nonatomic) NSMutableArray *newsItems;

@property (weak, nonatomic) NILauncherView *launcherView;
@property (nonatomic, readwrite, strong) NILauncherViewModel *model;
@property (strong, nonatomic) NSMutableArray *menuItems;

@end

@implementation HomeController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *sliderPath = [[NSBundle mainBundle] pathForResource:@"slider" ofType:@"xml"];
    NSData *sliderXmlData = [NSData dataWithContentsOfFile:sliderPath];
    NSDictionary *sliderDictionary = [NSDictionary dictionaryWithXMLData:sliderXmlData];
    NSArray *sliderItems = [sliderDictionary objectForKey:@"Item"];
    self.newsItems = [NSMutableArray array];
    [sliderItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [self.newsItems addObject:[[News alloc] initWithDictionary:obj]];
    }];
    
    CGFloat scrollPageViewHeight = IS_WIDESCREEN ? 240.0 : 160.0;
    CGFloat bottomViewHeight = 37.0;
    
    ScrollPageView *scrollPageView = [[ScrollPageView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.bounds.size.width, scrollPageViewHeight)];
    self.scrollPageView = scrollPageView;
    scrollPageView.dataSource = self.newsItems;
    scrollPageView.delegate = self;
    [self.view addSubview:scrollPageView];
    
    
    NSString *jzstPath = [[NSBundle mainBundle] pathForResource:@"jzst" ofType:@"xml"];
    NSData *jzstXmlData = [NSData dataWithContentsOfFile:jzstPath];
    NSDictionary *jzstDictionary = [NSDictionary dictionaryWithXMLData:jzstXmlData];
    NSArray *jzstItems = [jzstDictionary objectForKey:@"Item"];

    NSMutableArray *page1Content = [NSMutableArray array];
    NSMutableArray *page2Content = [NSMutableArray array];
    [jzstItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        News *news = [[News alloc] initWithDictionary:obj];
        if (idx > 5) {
            [page2Content addObject:[NILauncherViewObject objectWithTitle:news.Title image:[UIImage imageNamed:news.Image] itemid:news.ItemId]];
        } else {
            [page1Content addObject:[NILauncherViewObject objectWithTitle:news.Title image:[UIImage imageNamed:news.Image] itemid:news.ItemId]];
        }
    }];
    NSArray *contents = [NSArray arrayWithObjects:page1Content, page2Content, nil];
    _model = [[NILauncherViewModel alloc] initWithArrayOfPages:contents delegate:nil];
    
    NILauncherView *launcherView = [[NILauncherView alloc] initWithFrame:CGRectMake(0.0, scrollPageViewHeight, self.view.bounds.size.width, self.view.bounds.size.height - scrollPageViewHeight - bottomViewHeight)];
    self.launcherView = launcherView;
    launcherView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0];
    launcherView.autoresizingMask = UIViewAutoresizingFlexibleDimensions;
    [self.view addSubview:launcherView];

    self.launcherView.dataSource = _model;
    self.launcherView.delegate = self;
    [self.launcherView reloadData];
    
    UIImageView *bottomView;
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]){
        bottomView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, self.view.bounds.size.height - 64.0 - bottomViewHeight, self.view.bounds.size.width, bottomViewHeight)];
    } else {
        bottomView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, self.view.bounds.size.height - 44.0 - bottomViewHeight, self.view.bounds.size.width, bottomViewHeight)];
    }
    bottomView.image = [UIImage imageNamed:@"toolbar_bg.png"];
    [self.view addSubview:bottomView];
}

#pragma mark - ScrollPageView Delegate
- (void)scrollPageView:(ScrollPageView *)scrollPageView didSelectAtIndex:(NSUInteger)index
{
//    News *news = (News *)self.newsItems[index];
//    WebController *wc = [[WebController alloc] initWithNibName:nil bundle:nil];
//    wc.urlString = WEBVIEW_URL(news.ItemId);
//    [self.navigationController pushViewController:wc animated:YES];
}

#pragma mark - NILauncherDelegate

- (void)launcherView:(NILauncherView *)launcher didSelectItemOnPage:(NSInteger)page atIndex:(NSInteger)index {
    id<NILauncherViewObject> object = [self.model objectAtIndex:index pageIndex:page];
    
    NSLog(@"%@", object.title);
    
    NSArray *collectionArray = @[@"qbh", @"mlst", @"xyfc"];
    NSArray *tableArray = @[@"cfhy", @"tzfz", @"mskx"];
    NSArray *table2Array = @[@"dcst", @"3gxt"];
    if ([collectionArray containsObject:object.itemid]) {
        CollectionController *cc = [[CollectionController alloc] initWithNibName:nil bundle:nil];
        cc.title = object.title;
        cc.ItemId = object.itemid;
        [self.navigationController pushViewController:cc animated:YES];
    } else if ([tableArray containsObject:object.itemid]) {
        TableController *tc = [[TableController alloc] initWithStyle:UITableViewStylePlain];
        tc.title = object.title;
        tc.ItemId = object.itemid;
        [self.navigationController pushViewController:tc animated:YES];
    } else if ([table2Array containsObject:object.itemid]) {
        Table2Controller *tc = [[Table2Controller alloc] initWithStyle:UITableViewStyleGrouped];
        tc.title = object.title;
        tc.ItemId = object.itemid;
        [self.navigationController pushViewController:tc animated:YES];
    } else if ([object.itemid isEqualToString:@"zbst"]) {
        ZBSTController *zbst = [[ZBSTController alloc] initWithNibName:nil bundle:nil];
        zbst.title = object.title;
        [self.navigationController pushViewController:zbst animated:YES];
    } else {
        NSLog(@"none?");
    }
}

- (void)unLoadViews {
    // TODO 具体的释放操作
    self.newsItems = nil;
    self.menuItems = nil;
}

@end

//
//  HomeController.m
//  ExquisiteST
//
//  Created by kim on 13-10-12.
//
//

#import "HomeController.h"
#import "ScrollPageView.h"

#import "XMLDictionary.h"
#import "AppDelegate.h"
#import "News.h"

#import "BaseNavigationController.h"
#import "WebController.h"
#import "XFSTController.h"
#import "ZJSTController.h"
#import "CollectionController.h"

#import "TableController.h"
#import "PSCollectionView.h"
#import "CollectionViewCell.h"


@interface HomeController () <ScrollPageViewDelegate, PSCollectionViewDelegate, PSCollectionViewDataSource>

@property (weak, nonatomic) ScrollPageView *scrollPageView;
@property (strong, nonatomic) NSMutableArray *newsItems;

@property (weak, nonatomic) PSCollectionView *collectionView;
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
    
    CGFloat scrollPageViewHeight = IS_WIDESCREEN ? 250.0 : 170.0;
    
    ScrollPageView *scrollPageView = [[ScrollPageView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.bounds.size.width, scrollPageViewHeight)];
    self.scrollPageView = scrollPageView;
    scrollPageView.dataSource = self.newsItems;
    scrollPageView.delegate = self;
    [self.view addSubview:scrollPageView];
    
    
    NSString *jzstPath = [[NSBundle mainBundle] pathForResource:@"jzst" ofType:@"xml"];
    NSData *jzstXmlData = [NSData dataWithContentsOfFile:jzstPath];
    NSDictionary *jzstDictionary = [NSDictionary dictionaryWithXMLData:jzstXmlData];
    NSArray *jzstItems = [jzstDictionary objectForKey:@"Item"];
    self.menuItems = [NSMutableArray array];
    [jzstItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [self.menuItems addObject:[[News alloc] initWithDictionary:obj]];
    }];
    
    PSCollectionView *collectionView = [[PSCollectionView alloc] initWithFrame:CGRectMake(0.0, scrollPageViewHeight, self.view.bounds.size.width, self.view.bounds.size.height - scrollPageViewHeight)];
    self.collectionView = collectionView;
    collectionView.collectionViewDelegate = self;
    collectionView.collectionViewDataSource = self;
    collectionView.scrollEnabled = NO;
    collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
    collectionView.numColsPortrait = 3;
    collectionView.numColsLandscape = 3;
    [self.view addSubview:collectionView];
    [collectionView reloadData];
}

#pragma mark - ScrollPageView Delegate
- (void)scrollPageView:(ScrollPageView *)scrollPageView didSelectAtIndex:(NSUInteger)index
{
    News *news = (News *)self.newsItems[index];
    WebController *detail = [[WebController alloc] initWithNibName:nil bundle:nil];
    detail.title = news.Text;
    detail.UrIId = news.UrIId;
    detail.hidesBottomBarWhenPushed = YES;
//    detail.urlString = WEBVIEW_URL(news.UrIId);
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark - PSCollectionViewDelegate and DataSource
- (NSInteger)numberOfViewsInCollectionView:(PSCollectionView *)collectionView {
    return self.menuItems.count;
}

- (CGFloat)heightForViewAtIndex:(NSInteger)index {
    return 90.0;
}

- (PSCollectionViewCell *)collectionView:(PSCollectionView *)collectionView viewAtIndex:(NSInteger)index {
    
    CollectionViewCell *cell = (CollectionViewCell *)[self.collectionView dequeueReusableView];
    if (!cell) {
        cell = [[CollectionViewCell alloc] initWithFrame:CGRectZero];
    }
    
    [cell fillViewWithObject:self.menuItems[index]];
    
    return cell;
}


- (void)collectionView:(PSCollectionView *)collectionView didSelectView:(PSCollectionViewCell *)view atIndex:(NSInteger)index {
    News *news = (News *)self.menuItems[index];

    switch (index) {
        case 0:
        {
            XFSTController *xfst = [[XFSTController alloc] initWithNibName:nil bundle:nil];
            xfst.hidesBottomBarWhenPushed = YES;
            xfst.title = news.Text;
            xfst.UrIId = news.UrIId;
            [self.navigationController pushViewController:xfst animated:YES];
        }
            break;
        case 1:
        {
            TableController *zjst = [[TableController alloc] initWithStyle:UITableViewStyleGrouped];
            zjst.hidesBottomBarWhenPushed = YES;
            zjst.title = news.Text;
            zjst.UrIId = news.UrIId;
            [self.navigationController pushViewController:zjst animated:YES];
        }
            break;
        default:
        {
            // 其他 聚焦汕头 衣食住行 文化风情 经济发展
            CollectionController *other = [[CollectionController alloc] initWithNibName:nil bundle:nil];
            other.hidesBottomBarWhenPushed = YES;
            other.title = news.Text;
            other.UrIId = news.UrIId;
            [self.navigationController pushViewController:other animated:YES];
        }
            break;
    }
}


- (void)unLoadViews {
    // TODO 具体的释放操作
    self.newsItems = nil;
    self.menuItems = nil;
}

@end

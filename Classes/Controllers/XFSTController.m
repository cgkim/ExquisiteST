//
//  XFSTController.m
//  ExquisiteST
//
//  Created by kim on 13-10-13.
//
//

#import "XFSTController.h"

#import "PSCollectionView.h"
#import "CollectionViewCell.h"

#import "AppDelegate.h"
#import "News.h"

#import "SVProgressHUD.h"
#import "WebController.h"

#import "MovieController.h"

@interface XFSTController () <PSCollectionViewDelegate, PSCollectionViewDataSource>

@property (weak, nonatomic) PSCollectionView *collectionView;
@property (strong, nonatomic) MKNetworkOperation *netOperation;
@property (strong, nonatomic) NSMutableArray *newsItems;


@end

@implementation XFSTController

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

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10.0, 15.0, 300.0, 118.0)];
    imageView.image = [UIImage imageNamed:@"a.jpg"];
    imageView.userInteractionEnabled = YES;
    [self.view addSubview:imageView];
    UITapGestureRecognizer *viewShowTap = [[UITapGestureRecognizer alloc] initWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
        NSLog(@"Video show。");
        MovieController *moviePlayer = [[MovieController alloc] initWithContentURL:[NSURL URLWithString:VIDEO_URL]];
        [self presentMoviePlayerViewControllerAnimated:moviePlayer];
    }];
    [imageView addGestureRecognizer:viewShowTap];
    
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 150.0, self.view.bounds.size.width, 30.0)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
    titleLabel.textAlignment = 1;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.text = @"幸福汕头 城市形象片";
    [self.view addSubview:titleLabel];

    
    PSCollectionView *collectionView = [[PSCollectionView alloc] initWithFrame:CGRectMake(0.0, 180.0, self.view.bounds.size.width, self.view.bounds.size.height - 180.0)];
    self.collectionView = collectionView;
    collectionView.collectionViewDelegate = self;
    collectionView.collectionViewDataSource = self;
    collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
    collectionView.numColsPortrait = 3;
    collectionView.numColsLandscape = 3;
    [self.view addSubview:collectionView];
}

#pragma mark - PSCollectionViewDelegate and DataSource
- (NSInteger)numberOfViewsInCollectionView:(PSCollectionView *)collectionView {
    return self.newsItems.count;
}

- (CGFloat)heightForViewAtIndex:(NSInteger)index {
    return 120.0;
}

- (PSCollectionViewCell *)collectionView:(PSCollectionView *)collectionView viewAtIndex:(NSInteger)index {
    
    CollectionViewCell *cell = (CollectionViewCell *)[self.collectionView dequeueReusableView];
    if (!cell) {
        cell = [[CollectionViewCell alloc] initWithFrame:CGRectZero];
    }
    
    [cell fillViewWithObject:self.newsItems[index]];
    
    return cell;
}


- (void)collectionView:(PSCollectionView *)collectionView didSelectView:(PSCollectionViewCell *)view atIndex:(NSInteger)index {
    News *news = (News *)self.newsItems[index];
    WebController *detail = [[WebController alloc] initWithNibName:nil bundle:nil];
    detail.title = news.Text;
    detail.UrIId = news.UrIId;
    detail.hidesBottomBarWhenPushed = YES;
//    detail.urlString = WEBVIEW_URL(news.UrIId);
    [self.navigationController pushViewController:detail animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    if (!self.newsItems) {
        [SVProgressHUD showWithStatus:NSLocalizedString(@"loading", nil) maskType:SVProgressHUDMaskTypeBlack];
        self.netOperation = [NTAppDelegate.engine getNewsListWithNlid:self.UrIId OnSucceeded:^(NSMutableArray *objects) {
            self.newsItems = objects;
            [self.collectionView reloadData];
            [SVProgressHUD dismiss];
        } onError:^(NSError *engineError) {
            [SVProgressHUD dismiss];
            NSLog(@"%@", [engineError description]);
        }];
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    if (self.netOperation) {
        [self.netOperation cancel];
        self.netOperation = nil;
    }
}

- (void)unLoadViews {
    // TODO 具体的释放操作
    self.newsItems = nil;
}

@end

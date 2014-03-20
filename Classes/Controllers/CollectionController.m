//
//  CollectionController.m
//  ExquisiteST
//
//  Created by kim on 13-10-14.
//
//

#import "CollectionController.h"

#import "RESTfulEngine.h"

#import "SVProgressHUD.h"
#import "SVPullToRefresh.h"

#import "PSCollectionView.h"
#import "CollectionViewCell.h"

#import "News.h"
#import "WebController.h"
#import "MovieController.h"

@interface CollectionController () <PSCollectionViewDelegate, PSCollectionViewDataSource>

@property (strong, nonatomic) MKNetworkOperation *netOperation;
@property (weak, nonatomic) PSCollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *newsItems;
@property (assign, nonatomic) NSUInteger pnum;

@end

@implementation CollectionController

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
  
    PSCollectionView *collectionView = [[PSCollectionView alloc] initWithFrame:self.view.bounds];
    self.collectionView = collectionView;
    collectionView.collectionViewDelegate = self;
    collectionView.collectionViewDataSource = self;
    collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    collectionView.numColsPortrait = 2;
    collectionView.numColsLandscape = 2;
    [self.view addSubview:collectionView];
//    [collectionView reloadData];
    
    __weak CollectionController *weakSelf = self;
    debugMethod();
    
    // setup pull-to-refresh
    [self.collectionView addPullToRefreshWithActionHandler:^{
        int64_t delayInSeconds = DELAYINSECONDS;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [weakSelf.collectionView.pullToRefreshView stopAnimating];
            weakSelf.collectionView.showsInfiniteScrolling = YES;
            
            weakSelf.pnum = 1;
            [weakSelf.newsItems removeAllObjects];
            [weakSelf loadData];
        });
    }];
    
    // setup infinite scrolling
    [self.collectionView addInfiniteScrollingWithActionHandler:^{
        int64_t delayInSeconds = DELAYINSECONDS;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [weakSelf.collectionView.infiniteScrollingView stopAnimating];
            
            weakSelf.pnum++;
            [weakSelf loadData];
        });
    }];
}

#pragma mark - LoadData

- (void)loadData
{
    debugMethod();
    
    [SVProgressHUD showWithStatus:NSLocalizedString(@"loading", nil)];
    self.netOperation = [[RESTfulEngine sharedEngine] getNewsListToAppWithNlid:self.ItemId WithPnum:self.pnum WithPsize:PSIZE OnSucceeded:^(NSMutableArray *objects) {
        [self.newsItems addObjectsFromArray:objects];
        if (objects.count < PSIZE) {
            self.collectionView.showsInfiniteScrolling = NO;
        }
        [self.collectionView reloadData];
        [self.netOperation cancel];
        [SVProgressHUD dismiss];
    } onError:^(NSError *engineError) {
        [SVProgressHUD dismiss];
        NSLog(@"%@", [engineError description]);
    }];
}

#pragma mark - PSCollectionViewDelegate and DataSource
- (NSInteger)numberOfViewsInCollectionView:(PSCollectionView *)collectionView {
    return self.newsItems.count;
}

- (CGFloat)heightForViewAtIndex:(NSInteger)index {
    return 140.0;
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
    if ([news.ItemType isEqualToString:@"V"] || [news.ItemType isEqualToString:@"M"]) {
        ;
        NSURL *videoURL;
        NSRange range = [news.Image rangeOfString:@"http://"];
        if (range.location == 0) {
            videoURL = [NSURL URLWithString:news.ItemId];
        } else {
            videoURL = [NSURL URLWithString:VIDEO_URL(news.ItemId)];
        }
//        videoURL = [NSURL URLWithString:@"http://yinyueshiting.baidu.com/data2/music/114982694/114944077133200128.mp3?xcode=ea6d1c4cba0f540aa4a10d243fcb7c29841e426b4214a5f4"];

        MovieController *mv = [[MovieController alloc] initWithContentURL:videoURL];
        [self presentMoviePlayerViewControllerAnimated:mv];
    } else {
        WebController *wc = [[WebController alloc] initWithNibName:nil bundle:nil];
        wc.urlString = WEBVIEW_URL(news.ItemId);
        wc.title = news.Title;
        [self.navigationController pushViewController:wc animated:YES];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    debugMethod();
    if (!self.newsItems) {
        self.newsItems = [[NSMutableArray alloc] init];
        self.pnum = 1;
        [self loadData];
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    if ([SVProgressHUD isVisible]) {
        [SVProgressHUD dismiss];
    }
    if (self.netOperation) {
        [self.netOperation cancel];
        self.netOperation = nil;
    }
}

- (void)unLoadViews {
    // TODO 具体的释放操作
    [self.newsItems removeAllObjects];
    self.newsItems = nil;
}

@end

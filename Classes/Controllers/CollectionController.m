//
//  CollectionController.m
//  ExquisiteST
//
//  Created by kim on 13-10-14.
//
//

#import "CollectionController.h"

#import "AppDelegate.h"
#import "SVProgressHUD.h"

#import "PSCollectionView.h"
#import "CollectionViewCell.h"

#import "News.h"
#import "WebController.h"
#import "MovieController.h"

@interface CollectionController () <PSCollectionViewDelegate, PSCollectionViewDataSource>

@property (strong, nonatomic) MKNetworkOperation *netOperation;
@property (weak, nonatomic) PSCollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *newsItems;

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
    [collectionView reloadData];
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
    if ([news.ItemType isEqualToString:@"V"]) {
        ;
        NSURL *videoURL;
        NSRange range = [news.Image rangeOfString:@"http://"];
        if (range.location == 0) {
            videoURL = [NSURL URLWithString:news.ItemId];
        } else {
            videoURL = [NSURL URLWithString:VIDEO_URL(news.ItemId)];
        }
        MovieController *mv = [[MovieController alloc] initWithContentURL:videoURL];
        [self presentMoviePlayerViewControllerAnimated:mv];
    } else {
        WebController *wc = [[WebController alloc] initWithNibName:nil bundle:nil];
        wc.urlString = WEBVIEW_URL(news.ItemId);
        [self.navigationController pushViewController:wc animated:YES];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    if (!self.newsItems) {
        [SVProgressHUD showWithStatus:NSLocalizedString(@"loading", nil)];
        self.netOperation = [NTAppDelegate.engine getNewsListV2WithNlid:self.ItemId OnSucceeded:^(NSMutableArray *objects) {
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
    self.newsItems = nil;
}

@end

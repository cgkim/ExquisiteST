//
//  TableController.m
//  ExquisiteST
//
//  Created by kim on 13-10-16.
//
//

#import "TableController.h"
#import "TableViewCell.h"
#import "News.h"

#import "SVProgressHUD.h"
#import "SVPullToRefresh.h"

#import "RESTfulEngine.h"
#import "WebController.h"
#import "MovieController.h"

@interface TableController ()

@property (strong, nonatomic) MKNetworkOperation *netOperation;
@property (strong, nonatomic) NSMutableArray *newsItems;
@property (assign, nonatomic) NSUInteger pnum;

@end

@implementation TableController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    __weak TableController *weakSelf = self;
    
    // setup pull-to-refresh
    [self.tableView addPullToRefreshWithActionHandler:^{
        int64_t delayInSeconds = DELAYINSECONDS;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [weakSelf.tableView.pullToRefreshView stopAnimating];
            weakSelf.tableView.showsInfiniteScrolling = YES;
            
            weakSelf.pnum = 1;
            [weakSelf.newsItems removeAllObjects];
            [weakSelf loadData];
        });
    }];
    
    // setup infinite scrolling
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        int64_t delayInSeconds = DELAYINSECONDS;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [weakSelf.tableView.infiniteScrollingView stopAnimating];
            weakSelf.pnum++;
            [weakSelf loadData];
        });
    }];
}

#pragma mark - LoadData

- (void)loadData
{
    [SVProgressHUD showWithStatus:NSLocalizedString(@"loading", nil)];
    self.netOperation = [[RESTfulEngine sharedEngine] getNewsListToAppWithNlid:self.ItemId WithPnum:self.pnum WithPsize:PSIZE OnSucceeded:^(NSMutableArray *objects) {
        [self.newsItems addObjectsFromArray:objects];
        [self.tableView reloadData];
        if (objects.count < PSIZE) {
            self.tableView.showsInfiniteScrolling = NO;
        }
        [self.netOperation cancel];
        [SVProgressHUD dismiss];
    } onError:^(NSError *engineError) {
        [SVProgressHUD dismiss];
        NSLog(@"%@", [engineError description]);
    }];
}

#pragma mark - TableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.newsItems.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ListCellIdentifier = @"ListCellIdentifier";
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ListCellIdentifier];
    if (cell == nil) {
        cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ListCellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    News *news = (News *)self.newsItems[indexPath.row];
    cell.model = news;
    
    return cell;
}

#pragma mark - TableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    News *news = (News *)self.newsItems[indexPath.row];
    if ([news.ItemType isEqualToString:@"V"] || [news.ItemType isEqualToString:@"M"]) {
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
        wc.title = news.Title;
        [self.navigationController pushViewController:wc animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)viewWillAppear:(BOOL)animated
{
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
    self.newsItems = nil;
}

@end


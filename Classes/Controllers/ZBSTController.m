//
//  ZBSTController.m
//  ExquisiteST
//
//  Created by kim on 13-10-25.
//
//

#import "ZBSTController.h"
#import "TableViewCell.h"
#import "WebController.h"
#import "News.h"

#import "SVProgressHUD.h"

#import "AppDelegate.h"
#import "WebController.h"
#import "MovieController.h"

@interface ZBSTController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) UITableView *tableView;
@property (strong, nonatomic) MKNetworkOperation *netOperation;
@property (strong, nonatomic) NSMutableArray *newsItems;


@end

@implementation ZBSTController

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

    UIButton *tabFocus = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [tabFocus setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tab_but_focus" ofType:@"png"]] forState:UIControlStateNormal];
    [tabFocus setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tab_but_focus" ofType:@"png"]] forState:UIControlStateHighlighted];
    [tabFocus setFrame:CGRectMake(70.0, 10.0, 86.0, 43.0)];
    [tabFocus setTitle:@"报刊" forState:UIControlStateNormal];
    tabFocus.titleLabel.font = [UIFont boldSystemFontOfSize:16.0];
    [tabFocus setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    tabFocus.enabled = NO;
    [self.view addSubview:tabFocus];
    
    UIButton *tabNormal = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [tabNormal setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tab_but_normal" ofType:@"png"]] forState:UIControlStateNormal];
    [tabNormal setFrame:CGRectMake(170.0, 10.0, 86.0, 43.0)];
    [tabNormal setTitle:@"视频" forState:UIControlStateNormal];
    tabNormal.titleLabel.font = [UIFont boldSystemFontOfSize:16.0];
    [tabNormal setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [tabNormal addTarget:self action:@selector(videoShow) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tabNormal];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 60.0, self.view.bounds.size.width, self.view.bounds.size.height - 60.0)];
    self.tableView = tableView;
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
}

- (void)videoShow
{
//    MovieController *mv = [[MovieController alloc] initWithContentURL:[NSURL URLWithString:ZBST_VIDEO_URL]];
//    [self presentMoviePlayerViewControllerAnimated:mv];
    WebController *wc = [[WebController alloc] initWithNibName:nil bundle:nil];
    wc.urlString = ZBST_SP_URL;
    wc.title = @"视频";
    [self.navigationController pushViewController:wc animated:YES];
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
    WebController *wc = [[WebController alloc] initWithNibName:nil bundle:nil];
    wc.urlString = WEBVIEW_URL(news.ItemId);
    [self.navigationController pushViewController:wc animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)viewWillAppear:(BOOL)animated
{
    if (!self.newsItems) {
        [SVProgressHUD showWithStatus:NSLocalizedString(@"loading", nil)];
        self.netOperation = [NTAppDelegate.engine getNewsListV2WithNlid:@"bk" OnSucceeded:^(NSMutableArray *objects) {
            self.newsItems = objects;
            [self.tableView reloadData];
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


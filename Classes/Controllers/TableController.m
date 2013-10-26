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

#import "AppDelegate.h"
#import "WebController.h"

@interface TableController ()

@property (strong, nonatomic) MKNetworkOperation *netOperation;
@property (strong, nonatomic) NSMutableArray *newsItems;

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
        self.netOperation = [NTAppDelegate.engine getNewsListV2WithNlid:self.ItemId OnSucceeded:^(NSMutableArray *objects) {
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


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

#import "XMLDictionary.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "SVProgressHUD.h"

#import "AppDelegate.h"


@interface TableController ()

@property (strong, nonatomic) MKNetworkOperation *netOperation;
@property (strong, nonatomic) NSMutableArray *newsItems;

@end

@implementation TableController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

#pragma mark - TableView DataSource

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.newsItems.count;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 100.0f;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ListCellIdentifier = @"ListCellIdentifier";
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ListCellIdentifier];
    if (cell == nil) {
        cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ListCellIdentifier];
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (self.newsItems.count > 0) {
        News *news = (News *)self.newsItems[indexPath.row];
        NSRange range = [news.Img rangeOfString:@"http"];
        if (range.location == 0) {
            NSLog(@"img : %@", news.Img);
            NSURL *imageURL = [NSURL URLWithString:news.Img];
            [cell.imageView setImageWithURL:imageURL placeholderImage:nil];
        } else {
            cell.imageView.image = [UIImage imageNamed:news.Img];
        }
        cell.textLabel.text = news.Text;
    }
    
    return cell;
}

#pragma mark - TableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (!(self.segment.selectedSegmentIndex == 0 && indexPath.section == 0)) {
//        News *news = (News *)self.newsDataSource[indexPath.row];
//        NewsDetailViewController *detail = [[NewsDetailViewController alloc] initWithModel:news];
//        [self.navigationController pushViewController:detail animated:YES];
//        [tableView deselectRowAtIndexPath:indexPath animated:NO];
//    }
}

- (void)viewWillAppear:(BOOL)animated
{
    if (!self.newsItems) {
        if (self.tableView.style == UITableViewStyleGrouped) {
            NSString *xmlPath = [[NSBundle mainBundle] pathForResource:self.UrIId ofType:@"xml"];
            NSData *xmlData = [NSData dataWithContentsOfFile:xmlPath];
            NSDictionary *zjstDictionary = [NSDictionary dictionaryWithXMLData:xmlData];
            NSArray *jzstItems = [zjstDictionary objectForKey:@"Item"];
            self.newsItems = [NSMutableArray array];
            [jzstItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                [self.newsItems addObject:[[News alloc] initWithDictionary:obj]];
            }];
            [self.tableView reloadData];
        } else {
            [SVProgressHUD showWithStatus:NSLocalizedString(@"loading", nil) maskType:SVProgressHUDMaskTypeBlack];
            self.netOperation = [NTAppDelegate.engine getNewsListWithNlid:self.UrIId OnSucceeded:^(NSMutableArray *objects) {
                self.newsItems = objects;
                [self.tableView reloadData];
                [SVProgressHUD dismiss];
            } onError:^(NSError *engineError) {
                [SVProgressHUD dismiss];
                NSLog(@"%@", [engineError description]);
            }];
        }
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


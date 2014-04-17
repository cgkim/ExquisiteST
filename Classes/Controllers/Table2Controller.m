//
//  Table2Controller.m
//  ExquisiteST
//
//  Created by kim on 13-10-26.
//  
//

#import "Table2Controller.h"
#import "Table2ViewCell.h"
#import "News.h"
#import "XMLDictionary.h"

#import "CollectionController.h"
#import "TableController.h"
#import "MovieController.h"
#import "WebController.h"
#import "VideoController.h"


@interface Table2Controller ()

@property (strong, nonatomic) NSMutableArray *menuItems;

@end

@implementation Table2Controller

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

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - TableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.menuItems.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ListCellIdentifier = @"ListCellIdentifier";
    Table2ViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ListCellIdentifier];
    if (cell == nil) {
        cell = [[Table2ViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ListCellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    News *news = (News *)self.menuItems[indexPath.row];
    cell.model = news;
    
    return cell;
}

#pragma mark - TableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    News *news = (News *)self.menuItems[indexPath.row];
    NSLog(@"items: %@", news.ItemId);

//    (类别名称)-(后台对应ID)
//    
//    侨博会-10
//    美丽汕头-2
//    县域风采-7
//    潮风海韵-4
//    投资发展-5
//    民生快线-8
//    
//    直播汕头，多彩汕头，3G学堂这三个大类存在的2级列表都是写死的，照原来的处理即可，只是3级的也要照列表页的方式去请求数据，具体如下：
//    
//    [直播汕头]
//    报刊-11
//    视频-加载第5点的电视直播rtsp源
//    [多彩汕头]
//    美食-12
//    旅游-13
//    人文-14 文化
//    [3G学堂]
//    十八大专区-15
//    圆梦南粤-16
//    理论动态-17
//    社会热点-18
//    名家书画-19
//    生活百科-20
    
    NSArray *collectionArray = @[@"13"];
    NSArray *tableArray = @[@"12",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"11"];
    NSArray *videoArray = @[@"sp"];
    NSArray *webArray = @[@"wdy_bsbm", @"wdy_sczp", @"wdy_gs"];
    if ([collectionArray containsObject:news.ItemId]) {
        CollectionController *cc = [[CollectionController alloc] initWithNibName:nil bundle:nil];
        cc.title = news.Title;
        cc.ItemId = news.ItemId;
        [self.navigationController pushViewController:cc animated:YES];
    } else if ([tableArray containsObject:news.ItemId]) {
        TableController *tc = [[TableController alloc] initWithStyle:UITableViewStylePlain];
        tc.title = news.Title;
        tc.ItemId = news.ItemId;
        [self.navigationController pushViewController:tc animated:YES];
    } else if ([videoArray containsObject:news.ItemId]) {
        VideoController *wc = [[VideoController alloc] initWithNibName:nil bundle:nil];
        wc.urlString = ZBST_VIDEO_URL;
        wc.title = @"视频";
        [self presentModalViewController:wc animated:YES];
//        [self.navigationController pushViewController:wc animated:YES];
    } else if ([webArray containsObject:news.ItemId]) {
        WebController *wc = [[WebController alloc] initWithNibName:nil bundle:nil];
        // E京
        wc.urlString = @"http://mo.st001.com/";
        wc.title = news.Title;
        [self.navigationController pushViewController:wc animated:YES];
    } else {
        NSLog(@"none?");
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)viewWillAppear:(BOOL)animated
{
    if (!self.menuItems) {
        NSString *xmlPath = [[NSBundle mainBundle] pathForResource:self.ItemId ofType:@"xml"];
        NSData *xmlData = [NSData dataWithContentsOfFile:xmlPath];
        NSDictionary *tempDictionary = [NSDictionary dictionaryWithXMLData:xmlData];
        NSArray *tempItems = [tempDictionary objectForKey:@"Item"];
        self.menuItems = [NSMutableArray array];
        [tempItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [self.menuItems addObject:[[News alloc] initWithDictionary:obj]];
        }];
    }
}

- (void)unLoadViews {
    // TODO 具体的释放操作
    self.menuItems = nil;
}

@end


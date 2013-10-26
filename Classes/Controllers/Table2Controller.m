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
    NSArray *collectionArray = @[@"ms", @"ly"];
    NSArray *tableArray = @[@"rw"];
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


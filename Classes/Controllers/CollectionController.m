//
//  CollectionController.m
//  ExquisiteST
//
//  Created by kim on 13-10-14.
//
//

#import "CollectionController.h"

#import "XMLDictionary.h"

#import "PSCollectionView.h"
#import "CollectionViewCell.h"

#import "News.h"
#import "TableController.h"

@interface CollectionController () <PSCollectionViewDelegate, PSCollectionViewDataSource>

@property (weak, nonatomic) PSCollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *menuItems;

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
  
    PSCollectionView *collectionView = [[PSCollectionView alloc] initWithFrame:CGRectMake(0.0, 20.0, self.view.frame.size.width, self.view.frame.size.height)];
    self.collectionView = collectionView;
    collectionView.collectionViewDelegate = self;
    collectionView.collectionViewDataSource = self;
    collectionView.scrollEnabled = NO;
    collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
    collectionView.numColsPortrait = 2;
    collectionView.numColsLandscape = 2;
    [self.view addSubview:collectionView];
    [collectionView reloadData];
}

#pragma mark - PSCollectionViewDelegate and DataSource
- (NSInteger)numberOfViewsInCollectionView:(PSCollectionView *)collectionView {
    return self.menuItems.count;
}

- (CGFloat)heightForViewAtIndex:(NSInteger)index {
    return 110.0;
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
    TableController *lists = [[TableController alloc] initWithStyle:UITableViewStylePlain];
    lists.hidesBottomBarWhenPushed = YES;
    lists.title = news.Text;
    lists.UrIId = news.UrIId;
    [self.navigationController pushViewController:lists animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    if (!self.menuItems) {
        NSString *xmlPath = [[NSBundle mainBundle] pathForResource:self.UrIId ofType:@"xml"];
        NSData *xmlData = [NSData dataWithContentsOfFile:xmlPath];
        NSDictionary *jzstDictionary = [NSDictionary dictionaryWithXMLData:xmlData];
        NSArray *xmlItems = [jzstDictionary objectForKey:@"Item"];
        self.menuItems = [NSMutableArray array];
        [xmlItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [self.menuItems addObject:[[News alloc] initWithDictionary:obj]];
        }];
        [self.collectionView reloadData];
    }
}

- (void)unLoadViews {
    // TODO 具体的释放操作
    self.menuItems = nil;
}

@end

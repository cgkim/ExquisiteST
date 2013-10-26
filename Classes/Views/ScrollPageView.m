//
//  ScrollPageView.m
//  ExquisiteST
//
//  Created by kim on 13-10-13.
//
//

#import "ScrollPageView.h"
#import "News.h"


@implementation ScrollPageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 0.0, frame.size.width, frame.size.height)];
        self.scrollView = scrollView;
        scrollView.backgroundColor = [UIColor clearColor];
        scrollView.pagingEnabled = YES;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.delegate = self;
        [self addSubview:scrollView];
        
        UIView *bottomBackground = [[UIView alloc] initWithFrame:CGRectMake(0.0, frame.size.height - 40, frame.size.width, 40.0)];
        bottomBackground.backgroundColor = [UIColor colorWithRed:0 green:95/255.0 blue:166/255.0 alpha:0.7];
//        bottomBackground.backgroundColor = [UIColor blackColor];
//        bottomBackground.alpha = 0.8;
        [self addSubview:bottomBackground];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, frame.size.height - 40.0, frame.size.width, 20.0)];
        self.titleLabel = titleLabel;
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font = [UIFont systemFontOfSize:14.0];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.textAlignment = 1;
        [self addSubview:titleLabel];
        
        UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0.0, frame.size.height - 20.0, frame.size.width, 20.0)];
        self.pageControl = pageControl;
        pageControl.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        if ([pageControl respondsToSelector:@selector(setPageIndicatorTintColor:)]) {
            pageControl.pageIndicatorTintColor = [UIColor whiteColor];
            pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:0 green:144/255.0 blue:255/255.0 alpha:1.0];
        }

//        [pageControl addTarget:self action:@selector(pageControlPageDidChange:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:pageControl];
    }
    return self;
}

- (void)setDataSource:(NSArray *)dataSource
{
    _dataSource = dataSource;
    
//    倒序
//    _dataSource = [[dataSource reverseObjectEnumerator] allObjects];
    
    NSUInteger modelCount = self.dataSource.count;
    if (modelCount == 0) {
        return;
    }
    self.pageControl.numberOfPages = modelCount;
    self.scrollView.contentSize = CGSizeMake(modelCount * self.bounds.size.width, self.bounds.size.height);
    
    [self.dataSource enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(idx * self.bounds.size.width, 0.0, self.bounds.size.width, self.bounds.size.height)];
        News *news = (News *)obj;
        imageView.image = [UIImage imageNamed:news.Image];
//        picView.layer.masksToBounds = YES;
//        picView.layer.cornerRadius = 10.0;
        [self.scrollView addSubview:imageView];
    }];
    
    News *news = (News *)dataSource[0];
    self.titleLabel.text = news.Title;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured:)];
    [self addGestureRecognizer:singleTap];
    
    [self setNeedsLayout];
}

- (void)singleTapGestureCaptured:(UITapGestureRecognizer *)gesture
{
    [self.delegate scrollPageView:self didSelectAtIndex:self.pageControl.currentPage];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    self.pageControl.currentPage = offset.x / self.bounds.size.width;
    News *news = (News *)self.dataSource[self.pageControl.currentPage];
    self.titleLabel.text = news.Title;
}

@end

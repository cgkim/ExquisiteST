//
//  ScrollPageView.h
//  ExquisiteST
//
//  Created by kim on 13-10-13.
//
//

#import <UIKit/UIKit.h>

#pragma mark - Delegate

@protocol ScrollPageViewDelegate;

@interface ScrollPageView : UIView <UIScrollViewDelegate>

@property (strong, nonatomic) NSArray *dataSource;
@property (nonatomic) id<ScrollPageViewDelegate> delegate;

@property (weak, nonatomic) UIScrollView *scrollView;
@property (weak, nonatomic) UIPageControl *pageControl;
@property (weak, nonatomic) UILabel *titleLabel;

@end


@protocol ScrollPageViewDelegate <NSObject>

@optional
- (void)scrollPageView:(ScrollPageView *)scrollPageView didSelectAtIndex:(NSUInteger)index;

@end
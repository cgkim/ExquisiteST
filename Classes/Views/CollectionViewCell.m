//
//  CollectionViewCell.m
//  ExquisiteST
//
//  Created by kim on 13-10-14.
//
//

#import "CollectionViewCell.h"
#import "News.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation CollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self addSubview:_imageView];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont systemFontOfSize:12.0];
        _titleLabel.textAlignment = 1;
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.numberOfLines = 3;
        [self addSubview:_titleLabel];
    }
    return self;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    _imageView.image = nil;
}

- (void)fillViewWithObject:(id)object {
    [super fillViewWithObject:object];
    
    News *news = (News *)object;
    NSRange range = [news.Img rangeOfString:@"http"];
    if (range.location == 0) {
        NSURL *imageURL = [NSURL URLWithString:news.Img];
        [_imageView setImageWithURL:imageURL placeholderImage:nil];
        _imageView.contentMode = UIViewContentModeScaleToFill;
    } else {
        _imageView.contentMode = UIViewContentModeCenter;
        _imageView.image = [UIImage imageNamed:news.Img];
    }
    _titleLabel.text = news.Text;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _imageView.frame = CGRectMake(0.0, 0.0, self.frame.size.width, 70.0);
    _titleLabel.frame = CGRectMake(0.0, 70.0, self.frame.size.width, self.frame.size.height - 70.0);
}

@end

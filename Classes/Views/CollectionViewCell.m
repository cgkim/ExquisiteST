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
#define IMAGEHEIGHT 100.0

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
        _titleLabel.numberOfLines = 2;
        [self addSubview:_titleLabel];
    }
    return self;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    _imageView.image = nil;
    _playIcon.image = nil;
}

- (void)fillViewWithObject:(id)object {
    [super fillViewWithObject:object];
    
    News *news = (News *)object;
    NSRange range = [news.Image rangeOfString:@"http://"];
    NSURL *imageURL;
    if (range.location == 0) {
        imageURL = [NSURL URLWithString:news.Image];
    } else {
        imageURL = [NSURL URLWithString:IMAGE_URL(news.Image)];
//        _imageView.contentMode = UIViewContentModeCenter;
    }
    _imageView.contentMode = UIViewContentModeScaleToFill;
    [_imageView setImageWithURL:imageURL placeholderImage:nil];
    
    _titleLabel.text = news.Title;
    
    if ([news.ItemType isEqualToString:@"V"] || [news.ItemType isEqualToString:@"M"]) {
        _playIcon = [[UIImageView alloc] initWithFrame:CGRectZero];
        _playIcon.image = [UIImage imageNamed:@"icon_play.png"];
        _playIcon.contentMode = UIViewContentModeCenter;
        [_imageView addSubview:_playIcon];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _imageView.frame = CGRectMake(0.0, 0.0, self.frame.size.width, IMAGEHEIGHT);
    _titleLabel.frame = CGRectMake(0.0, IMAGEHEIGHT, self.frame.size.width, self.frame.size.height - IMAGEHEIGHT);
    if (_playIcon) {
        _playIcon.center = _imageView.center;
    }
}

@end

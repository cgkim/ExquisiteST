//
//  CollectionViewCell.h
//  ExquisiteST
//
//  Created by kim on 13-10-14.
//
//

#import "PSCollectionViewCell.h"

@interface CollectionViewCell : PSCollectionViewCell

@property (strong, nonatomic, readonly) UIImageView *imageView;
@property (strong, nonatomic, readonly) UILabel *titleLabel;
@property (strong, nonatomic, readonly) UIImageView *playIcon;

@end

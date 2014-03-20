//
//  TableViewCell.m
//  ExquisiteST
//
//  Created by kim on 13-10-16.
//
//

#import "TableViewCell.h"

@implementation TableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.textLabel.font = [UIFont systemFontOfSize:16.0];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(News *)model
{
    _model = model;
    if ([_model.ItemType isEqualToString:@"V"] || [_model.ItemType isEqualToString:@"M"]) {
        self.imageView.image = [UIImage imageNamed:@"t_video.png"];
    }else if ([_model.ItemType isEqualToString:@"T"]) {
        self.imageView.image = [UIImage imageNamed:@"t_text.png"];
    }else if ([_model.ItemType isEqualToString:@"I"]) {
        self.imageView.image = [UIImage imageNamed:@"t_pic.png"];
    } else {
        
    }
    self.textLabel.text = _model.Title;
}

- (void)layoutSubviews {
    [super layoutSubviews];

//    self.imageView.frame = CGRectMake(self.imageView.frame.origin.x, self.imageView.frame.origin.y, 35.0, 27.0);
}

@end

//
//  Table2ViewCell.m
//  ExquisiteST
//
//  Created by kim on 13-10-26.
//
//

#import "Table2ViewCell.h"

@implementation Table2ViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.textLabel.font = [UIFont systemFontOfSize:16.0];
//        self.textLabel.textColor = [UIColor whiteColor];
//        UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tablecell_bg.png"]];
//        background.frame = CGRectMake(12.0, 8.0, 295.0, 35.0);
//        [self addSubview:background];
//        [self sendSubviewToBack:background];
        
        self.backgroundColor = [UIColor colorWithRed:93/255.0 green:156/255.0 blue:236/255.0 alpha:1];
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
   
    self.imageView.image = [UIImage imageNamed:_model.Image];
    self.textLabel.text = _model.Title;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
}


@end

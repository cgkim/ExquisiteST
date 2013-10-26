//
//  News.h
//  ExquisiteST
//
//  Created by kim on 13-10-13.
//
//

#import "BaseModel.h"

@interface News : BaseModel

@property (strong, nonatomic) NSString *Image;
@property (strong, nonatomic) NSString *Title;
@property (strong, nonatomic) NSString *SubTitle;
@property (strong, nonatomic) NSString *ItemId;
@property (strong, nonatomic) NSString *ItemType;

@end

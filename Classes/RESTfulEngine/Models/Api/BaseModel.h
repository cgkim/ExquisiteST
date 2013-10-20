//
//  BaseModel.h
//  ExquisiteST
//
//  Created by kim on 13-10-13.
//
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject <NSCoding, NSCopying, NSMutableCopying>

- (id)initWithDictionary:(NSMutableDictionary *)xmlObject;

@end

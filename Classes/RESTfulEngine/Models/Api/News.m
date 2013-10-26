//
//  News.m
//  ExquisiteST
//
//  Created by kim on 13-10-13.
//
//

#import "News.h"

@implementation News

//===========================================================
//  Keyed Archiving
//
//===========================================================
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.Image forKey:@"Image"];
    [encoder encodeObject:self.Title forKey:@"Title"];
    [encoder encodeObject:self.SubTitle forKey:@"SubTitle"];
    [encoder encodeObject:self.ItemId forKey:@"ItemId"];
    [encoder encodeObject:self.ItemType forKey:@"ItemType"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        self.Image = [decoder decodeObjectForKey:@"Image"];
        self.Title = [decoder decodeObjectForKey:@"Title"];
        self.SubTitle = [decoder decodeObjectForKey:@"SubTitle"];
        self.ItemId = [decoder decodeObjectForKey:@"ItemId"];
        self.ItemType = [decoder decodeObjectForKey:@"ItemType"];
    }
    return self;
}

@end

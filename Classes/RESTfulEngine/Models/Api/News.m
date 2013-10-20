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
    [encoder encodeObject:self.Img forKey:@"Img"];
    [encoder encodeObject:self.Text forKey:@"Text"];
    [encoder encodeObject:self.UrIId forKey:@"UrIId"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        self.Img = [decoder decodeObjectForKey:@"Img"];
        self.Text = [decoder decodeObjectForKey:@"Text"];
        self.UrIId = [decoder decodeObjectForKey:@"UrIId"];
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    id theCopy = [[[self class] allocWithZone:zone] init];  // use designated initializer
    
    [theCopy setImg:[self.Img copy]];
    [theCopy setText:[self.Text copy]];
    [theCopy setUrIId:[self.UrIId copy]];
    
    return theCopy;
}

@end

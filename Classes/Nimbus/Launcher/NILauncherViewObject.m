//
// Copyright 2011-2012 Jeff Verkoeyen
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

#import "NILauncherViewObject.h"
#import "NILauncherButtonView.h"

#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "Nimbus requires ARC support."
#endif

static NSString* const kTitleCodingKey = @"title";
static NSString* const kImageCodingKey = @"image";
static NSString* const kItemidCodingKey = @"itemid";

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation NILauncherViewObject

@synthesize title = _title;
@synthesize image = _image;
@synthesize itemid = _itemid;


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithTitle:(NSString *)title image:(UIImage *)image itemid:(NSString *)itemid {
  if ((self = [super init])) {
    _title = title;
    _image = image;
      _itemid = itemid;
  }
  return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
+ (id)objectWithTitle:(NSString *)title image:(UIImage *)image itemid:(NSString *)itemid {
  return [[self alloc] initWithTitle:title image:image itemid:itemid];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (Class)buttonViewClass {
  return [NILauncherButtonView class];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark NSCoding


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)encodeWithCoder:(NSCoder *)coder {
  [coder encodeObject:self.title forKey:kTitleCodingKey];
  [coder encodeObject:self.image forKey:kImageCodingKey];
  [coder encodeObject:self.itemid forKey:kItemidCodingKey];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithCoder:(NSCoder *)decoder {
  if ((self = [super init])) {
    _title = [decoder decodeObjectForKey:kTitleCodingKey];
    _image = [decoder decodeObjectForKey:kImageCodingKey];
    _itemid = [decoder decodeObjectForKey:kItemidCodingKey];
  }
  return self;
}


@end

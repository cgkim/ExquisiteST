//
//  RESTfulEngine.h
//  ExquisiteST
//
//  Created by kim on 13-10-13.
//
//

#import "MKNetworkEngine.h"
#import "MKNetworkOperation.h"
#import "BaseModel.h"

typedef void (^VoidBlock)();
typedef void (^StringBlock)(NSString *content);
typedef void (^ModelBlock)(BaseModel *object);
typedef void (^ArrayBlock)(NSMutableArray *objects);
typedef void (^ErrorBlock)(NSError *engineError);

@interface RESTfulEngine : MKNetworkEngine

- (MKNetworkOperation *)getNewsListWithNlid:(NSString *)nlid
                                OnSucceeded:(ArrayBlock)succeededBlock
                                    onError:(ErrorBlock)errorBlock;

- (MKNetworkOperation *)getNewsContentWithNid:(NSString *)nid
                                  OnSucceeded:(StringBlock)succeededBlock
                                      onError:(ErrorBlock)errorBlock;

@end

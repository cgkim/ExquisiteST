//
//  RESTfulEngine.m
//  ExquisiteST
//
//  Created by kim on 13-10-13.
//
//

#import "RESTfulEngine.h"
#import "XMLDictionary.h"
#import "News.h"



@implementation RESTfulEngine

#pragma mark -
#pragma mark Custom Methods

- (MKNetworkOperation *)getNewsListV2WithNlid:(NSString *)nlid
                                  OnSucceeded:(ArrayBlock)succeededBlock
                                      onError:(ErrorBlock)errorBlock
{
    NSDictionary *params = @{@"nlid": nlid};
    MKNetworkOperation *op = (MKNetworkOperation *)[self operationWithPath:GET_NEWS_LIST params:params httpMethod:@"GET"];
    NSLog(@"url: %@", [op url]);
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSData *xmlData = [completedOperation responseData];
        NSDictionary *responseDictionary = [NSDictionary dictionaryWithXMLData:xmlData];
        NSMutableArray *newsItems = [NSMutableArray array];
        NSMutableArray *tempItems = [responseDictionary objectForKey:@"Item"];
        [tempItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [newsItems addObject:[[News alloc] initWithDictionary:obj]];
        }];
        succeededBlock(newsItems);
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        errorBlock(error);
    }];
    [self enqueueOperation:op];
    return op;
}

- (MKNetworkOperation *)getNewsContentWithNid:(NSString *)nid
                                  OnSucceeded:(StringBlock)succeededBlock
                                      onError:(ErrorBlock)errorBlock
{
    NSDictionary *params = @{@"nid": nid};
    MKNetworkOperation *op = (MKNetworkOperation *)[self operationWithPath:GET_NEWS_CONTENT params:params httpMethod:@"GET"];
    NSLog(@"url: %@", [op url]);
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSString *string = [completedOperation responseString];
        succeededBlock(string);
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        errorBlock(error);
    }];
    [self enqueueOperation:op];
    return op;
}


@end

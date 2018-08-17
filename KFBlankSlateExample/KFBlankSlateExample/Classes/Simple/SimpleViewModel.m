//
//  SimpleViewModel.m
//  KFBlankSlateExample
//
//  Created by carefree on 2018/8/17.
//  Copyright © 2018年 Carefree. All rights reserved.
//

#import "SimpleViewModel.h"
#import "KFNetworkService.h"

@implementation SimpleViewModel

- (void)querySimpleListWithPage:(NSUInteger)page success:(void (^)(void))success failure:(void (^)(NSError *))failure {
    NSString *url = [NSString stringWithFormat:@"%@%@%@", BaseURL, API_METHOD_CATE_IOS, @(page)];
    [[KFNetworkService sharedService] getWithURLString:url parameters:nil success:^(id responseObject) {
        if ([[responseObject objectForKey:API_RESPONSE_KEY_ERROR] boolValue]) {
            if (failure) {
                failure(nil);
            }
            return;
        }
        
        NSArray *results = [responseObject objectForKey:API_RESPONSE_KEY_RESULT];
        NSMutableArray *list = [NSMutableArray array];
        for (NSDictionary *dict in results) {
            SimpleModel *model = [[SimpleModel alloc] init];
            model._id = [dict objectForKey:@"_lid"];
            model.desc = [dict objectForKey:@"desc"];
            [model.images addObjectsFromArray:[dict objectForKey:@"images"]];
            model.url = [dict objectForKey:@"url"];
            model.who = [dict objectForKey:@"who"];
            
            [list addObject:model];
        }
        self.list = list;
        
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end

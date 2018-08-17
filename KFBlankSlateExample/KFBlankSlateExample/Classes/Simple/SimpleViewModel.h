//
//  SimpleViewModel.h
//  KFBlankSlateExample
//
//  Created by carefree on 2018/8/17.
//  Copyright © 2018年 Carefree. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SimpleModel.h"

@interface SimpleViewModel : NSObject

@property (nonatomic, strong) NSArray<SimpleModel *>    *list;

- (void)querySimpleListWithPage:(NSUInteger)page success:(void(^)(void))success failure:(void(^)(NSError *error))failure;

@end

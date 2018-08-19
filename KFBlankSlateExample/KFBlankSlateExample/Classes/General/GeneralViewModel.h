//
//  GeneralViewModel.h
//  KFBlankSlateExample
//
//  Created by Carefree on 2018/8/18.
//  Copyright © 2018年 Carefree. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GeneralModel.h"

@interface GeneralViewModel : NSObject

@property (nonatomic, strong) NSArray<GeneralModel *>    *list;

- (void)queryListWithPage:(NSUInteger)page success:(void(^)(void))success failure:(void(^)(NSError *error))failure;

@end

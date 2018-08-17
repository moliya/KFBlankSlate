//
//  SimpleModel.h
//  KFBlankSlateExample
//
//  Created by carefree on 2018/8/17.
//  Copyright © 2018年 Carefree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SimpleModel : NSObject

@property (nonatomic, copy) NSString    *_id;
@property (nonatomic, copy) NSString    *desc;
@property (nonatomic, strong) NSMutableArray    *images;
@property (nonatomic, copy) NSString    *url;
@property (nonatomic, copy) NSString    *who;

@end

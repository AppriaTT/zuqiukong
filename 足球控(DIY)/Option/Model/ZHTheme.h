//
//  ZHTheme.h
//  足球控(DIY)
//
//  Created by Aaron on 16/1/17.
//  Copyright © 2016年 叶无道. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHTheme : NSObject
@property (nonatomic ,copy) NSString *name;
@property (nonatomic ,copy) NSString *address;
@property (nonatomic ,copy) NSString *teamId;

+ (instancetype)themeWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end

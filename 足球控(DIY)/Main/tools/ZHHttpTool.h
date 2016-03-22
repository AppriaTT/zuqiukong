//
//  ZHHttpTool.h
//  微博
//
//  Created by Aaron on 15/12/3.
//  Copyright (c) 2015年 叶无道. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@interface ZHHttpTool : NSObject
//基于AFNetworking 3.0 的网络请求
+(void)Get:(NSString *)urlString parameters:(NSDictionary *)params acceptableContentTypes:(NSString *)types success:(void(^)(id responseObject))success failure:(void(^)(NSError * error))failure;

+(void)Post:(NSString *)urlString parameters:(NSDictionary *)params acceptableContentTypes:(NSString *)types success:(void(^)(id responseObject))success failure:(void(^)(NSError * error))failure;

@end

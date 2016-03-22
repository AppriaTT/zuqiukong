//
//  ZHHttpTool.m
//  微博
//
//  Created by Aaron on 15/12/3.
//  Copyright (c) 2015年 叶无道. All rights reserved.
//

#import "ZHHttpTool.h"

@implementation ZHHttpTool
+(void)Get:(NSString *)urlString parameters:(NSDictionary *)params acceptableContentTypes:(NSString *)types success:(void(^)(id responseObject))success failure:(void(^)(NSError * error))failure
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:types, nil];
    [mgr GET:urlString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        success (responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure (error);
        
    }];
    
//    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
//    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:types, nil];
//    [session GET:urlString parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
//        success(responseObject);
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        failure(error);
//    }];
}

+(void)Post:(NSString *)urlString parameters:(NSDictionary *)params acceptableContentTypes:(NSString *)types success:(void(^)(id responseObject))success failure:(void(^)(NSError * error))failure
{
//    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
//    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:types, nil];
//    [mgr POST:urlString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        success (responseObject);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        failure (error);
//    }];
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:types, nil];
    
    [session POST:urlString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        success (responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure (error);
    }];
}
@end

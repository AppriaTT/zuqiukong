//
//  ZHUser.h
//  足球控(DIY)
//
//  Created by Aaron on 16/1/9.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHUser : NSObject
/**
 *  名字
 */
@property (nonatomic ,copy) NSString *name;
@property (nonatomic ,copy) NSString *username;
/**
 *  图标
 */
@property (nonatomic ,copy) NSString *profile_image_url;
@property (nonatomic ,copy) NSString *headImage_leanImgUrl;
/**
 *  是否认证了
 */
@property (nonatomic,assign,getter=isVerified)BOOL verified;
@end

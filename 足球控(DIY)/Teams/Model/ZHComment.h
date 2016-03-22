//
//  ZHComment.h
//  足球控(DIY)
//
//  Created by Aaron on 16/1/9.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHComment : NSObject
/**
 *  评论文字
 */
@property (nonatomic ,copy) NSString *last_comment_text;

/**
 *  头像
 */
@property (nonatomic ,copy) NSString *headImage_leanImgUrl;

/**
 *  名字
 */
@property (nonatomic ,copy) NSString *displayName;
@end

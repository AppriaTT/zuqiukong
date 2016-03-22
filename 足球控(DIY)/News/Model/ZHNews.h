//
//  ZHNews.h
//  足球控(DIY)
//
//  Created by Aaron on 16/1/5.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHNews : NSObject
@property (nonatomic ,copy) NSString *title;
@property (nonatomic ,copy) NSString *desc;
@property (nonatomic ,copy) NSString *desImg;
@property (nonatomic ,copy) NSString *mark;
@property (nonatomic,assign)NSNumber *commentCount;
/**
 *  点击后的网页链接
 */
@property (nonatomic ,copy) NSString *appLink;
/**
 *  图片链接
 */
@property (nonatomic ,copy) NSString *img;
@end

//
//  ZHRefreshGifHeader.h
//  足球控(DIY)
//
//  Created by Aaron on 16/1/5.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import "MJRefreshNormalHeader.h"

@interface ZHRefreshGifHeader : MJRefreshNormalHeader
/** 设置state状态下的动画图片images 动画持续时间duration*/
- (void)setImagesForRefreshingState:(NSArray *)images;
@end

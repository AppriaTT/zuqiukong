//
//  ZHNewsDetailReadController.h
//  足球控(DIY)
//
//  Created by Aaron on 16/1/10.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHNews;
/*
 *这是一个专门用来加载webView的控制器 传入一个url即可
 */
@interface ZHNewsDetailReadController : UIViewController
@property (nonatomic,strong)  ZHNews *news;
@property (nonatomic ,copy) NSString *shareLink;
@end

//
//  ZHShowNewsTableView.h
//  足球控(DIY)
//
//  Created by Aaron on 16/1/5.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHNews.h"
@interface ZHShowNewsTableView : UITableView
@property (nonatomic ,copy) NSArray *newsArray;
@property (nonatomic ,copy) NSArray *bannersArray;

@property (nonatomic ,copy) NSArray *smallVideoArray;

@property (nonatomic,copy)void(^refreshBlock) (void);

//点击cell后调用
@property (nonatomic,copy)void(^cellClickHandler) (id responseObjc,NSIndexPath *indexPath);

/**
 *  点击顶部广告栏要调用的block
 */
@property (nonatomic,copy)void(^adSViewClickHandler) (id responseObjc);

@end

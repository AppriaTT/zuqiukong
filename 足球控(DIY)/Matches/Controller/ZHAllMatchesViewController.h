//
//  ZHViewController.h
//  UIFengzhuang
//
//  Created by qianfeng on 15/12/21.
//  Copyright (c) 2015年 叶无道. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHAllMatchesViewController : UIViewController
/**
 *  点击cell告诉母控制器要pushpageView了
 */
@property (nonatomic,copy)void(^CellClickHandler) (id respondObjc, NSIndexPath *path);

@end

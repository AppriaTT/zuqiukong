//
//  ZHNGMainTool.h
//  足球控(DIY)
//
//  Created by Aaron on 16/4/20.
//  Copyright © 2016年 叶无道. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ZHNGMainTool : NSObject
@property (nonatomic, weak) UITabBarController *mainTabVC;
/**
 *  单例 用来保存指向tabbar里面各个主控制器的指针对象, 方便push操作
 */
+(instancetype)sharedVCTool;
@end

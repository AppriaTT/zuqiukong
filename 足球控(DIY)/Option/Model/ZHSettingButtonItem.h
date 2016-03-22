//
//  ZHSettingButtonItem.h
//  足球控(DIY)
//
//  Created by Aaron on 16/1/5.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import "ZHSettingItem.h"

@interface ZHSettingButtonItem : ZHSettingItem
/**
 *  目标控制器
 */
@property (nonatomic, assign) Class destVC;
/**
 *  图标的名字
 */
@property (nonatomic ,copy) NSString *icon;

/**
 *  右侧文字
 */
@property (nonatomic ,copy) NSString *rightTitle;

- (instancetype)initWithTitle:(NSString *)title destClass:(Class)destVc iconName :(NSString *)iconName rightTitle :(NSString *)rightTitle;
@end

//
//  ZHSettingArrowItem.h
//  足球控(DIY)
//
//  Created by Aaron on 16/1/5.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import "ZHSettingItem.h"

@interface ZHSettingArrowItem : ZHSettingItem
/**
 *  目标控制器
 */
@property (nonatomic, assign) Class destVC;

- (instancetype)initWithTitle:(NSString *)title destClass:(Class)destVc;
@end

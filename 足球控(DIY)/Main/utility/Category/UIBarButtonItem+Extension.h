//
//  UIBarButtonItem+Extension.h
//  微博
//
//  Created by Aaron on 15/12/11.
//  Copyright (c) 2015年 叶无道. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
/**
 * 创建一个可以设置普通状态和高亮状态背景图片的barButtonItem
 */
+(UIBarButtonItem *)itemWithNormalImageName :(NSString *)norImg highlitedImageName:(NSString *)higImg andTarget:(id)target action:(SEL)action;

+(UIBarButtonItem *)itemWithNormalImageName :(NSString *)norImg highlitedImageName:(NSString *)higImg imageEdgeInsets:(UIEdgeInsets)edge andTarget:(id)target action:(SEL)action;
@end

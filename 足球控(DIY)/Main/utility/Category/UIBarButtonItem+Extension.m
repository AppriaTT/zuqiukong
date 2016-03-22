//
//  UIBarButtonItem+Extension.m
//  微博
//
//  Created by Aaron on 15/12/11.
//  Copyright (c) 2015年 叶无道. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"
#import "UIView+Extension.h"
@implementation UIBarButtonItem (Extension)
+(UIBarButtonItem *)itemWithNormalImageName :(NSString *)norImg highlitedImageName:(NSString *)higImg andTarget:(id)target action:(SEL)action
{

    UIButton *btn= [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:norImg] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:higImg] forState:UIControlStateHighlighted];
    btn.size = CGSizeMake(44, 44);
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[self alloc]initWithCustomView:btn];
    
    return item;
}
+(UIBarButtonItem *)itemWithNormalImageName :(NSString *)norImg highlitedImageName:(NSString *)higImg imageEdgeInsets:(UIEdgeInsets)edge andTarget:(id)target action:(SEL)action
{
    
    UIButton *btn= [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:norImg] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:higImg] forState:UIControlStateHighlighted];
    btn.size = CGSizeMake(44, 44);
    btn.imageEdgeInsets = edge;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[self alloc]initWithCustomView:btn];
    return item;
}
@end

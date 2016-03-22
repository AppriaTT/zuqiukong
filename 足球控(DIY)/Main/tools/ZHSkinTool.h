//
//  ZHSkinTool.h
//  足球控(DIY)
//
//  Created by Aaron on 16/1/17.
//  Copyright © 2016年 叶无道. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//一键换肤类
@interface ZHSkinTool : NSObject
+(void)setThemeName:(NSString *)themeName team_id:(NSString *)team_id;

+(UIImage*)skinToolWithThemeImg:(NSString *)imgName ;
/*
 * 导航栏的颜色
 */
+(UIColor *)skinToolWithNorBGColor;
/*
 * searchbar的颜色
 */
+(UIColor *)skinToolWithDarkBGColor;

+(NSString *)team_id;
@end

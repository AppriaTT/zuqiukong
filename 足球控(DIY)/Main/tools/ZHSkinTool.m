//
//  ZHSkinTool.m
//  足球控(DIY)
//
//  Created by Aaron on 16/1/17.
//  Copyright © 2016年 叶无道. All rights reserved.
//

#import "ZHSkinTool.h"

@implementation ZHSkinTool
static NSString *_themeName;
static NSString *_team_id;

+(void)initialize
{
    _themeName = [[NSUserDefaults standardUserDefaults] objectForKey:@"themeName"];
    _team_id = [[NSUserDefaults standardUserDefaults]objectForKey:@"team_id"];
    if (!_themeName) {
       _themeName = @"teamTheme/arsenal";
       _team_id = @"660";
    }
}

+(NSString *)team_id
{
    return _team_id;
}

+(void)setThemeName:(NSString *)themeName team_id:(NSString *)team_id
{
    _themeName = themeName;
    _team_id = team_id;
    //保存主题
    [[NSUserDefaults standardUserDefaults]setObject:_themeName forKey:@"themeName"];
    [[NSUserDefaults standardUserDefaults]setObject:_team_id forKey:@"team_id"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    //进行广播 换肤
    [[NSNotificationCenter defaultCenter]postNotificationName:@"theme" object:nil];
}
+(UIImage*)skinToolWithThemeImg:(NSString *)imgName
{
    NSString *themePath = [NSString stringWithFormat:@"%@/%@",_themeName,imgName];
    return [UIImage imageNamed:themePath];
}

+(UIColor *)skinToolWithNorBGColor
{
    //plist
    NSString *plistPath = [NSString stringWithFormat:@"%@/themeColor.plist",_themeName];
    NSString *dictPath = [[NSBundle mainBundle]pathForResource:plistPath ofType:nil];
    NSDictionary *colorDict = [NSDictionary dictionaryWithContentsOfFile:dictPath];
    NSArray *array = [colorDict[@"kHomeButtonDefault"] componentsSeparatedByString:@","];
    NSInteger red = [array[0] integerValue];
    NSInteger green = [array[1] integerValue];
    NSInteger blue = [array[2] integerValue];
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
}

+(UIColor *)skinToolWithDarkBGColor
{
    NSString *plistPath = [NSString stringWithFormat:@"%@/themeColor.plist",_themeName];
    NSString *dictPath = [[NSBundle mainBundle]pathForResource:plistPath ofType:nil];
    NSDictionary *colorDict = [NSDictionary dictionaryWithContentsOfFile:dictPath];
    NSArray *array = [colorDict[@"kHomeButtonPress"] componentsSeparatedByString:@","];
    NSInteger red = [array[0] integerValue];
    NSInteger green = [array[1] integerValue];
    NSInteger blue = [array[2] integerValue];
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
}

#pragma mark dealloc
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end

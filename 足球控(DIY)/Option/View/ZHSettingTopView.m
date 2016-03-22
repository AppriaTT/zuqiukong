//
//  ZHSettingTopView.m
//  足球控(DIY)
//
//  Created by Aaron on 16/1/4.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import "ZHSettingTopView.h"
#import "ZHSkinTool.h"
@interface ZHSettingTopView()
@property (weak, nonatomic) IBOutlet UIImageView *topBGView;

@end
@implementation ZHSettingTopView
- (IBAction)settingClick {
    self.settingBtnBlock();
}

//点击头像后
- (IBAction)iconBtn:(id)sender {
    self.iconBtnBlock();
    
}

+(instancetype)settingTopView
{
    return [[[NSBundle mainBundle]loadNibNamed:@"ZHSettingTopView" owner:nil options:nil]lastObject];
}
-(void)awakeFromNib
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeTheme) name:@"theme" object:nil];
    [self changeTheme];
}

- (void)changeTheme
{
    self.topBGView.image = [ZHSkinTool skinToolWithThemeImg:@"player_top_bg.jpg"];
}
#pragma mark dealloc
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end

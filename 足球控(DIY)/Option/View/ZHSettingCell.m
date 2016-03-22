//
//  ZHSettingCell.m
//  足球控(DIY)
//
//  Created by Aaron on 16/1/5.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import "ZHSettingCell.h"
#import "ZHSettingButtonItem.h"
#import "TotalAPI.h"
#import "ZHSkinTool.h"
@interface ZHSettingCell ()
@property (nonatomic, strong) UIImageView *arrowIv;
@property (nonatomic, strong) UISwitch *switchBtn;
@property (nonatomic, strong) UIView *buttonView;
@end
@implementation ZHSettingCell
{
    UIImageView *_subImageView;
}
//懒加载控件
- (UIImageView *)arrowIv
{
    if (_arrowIv == nil) {
        _arrowIv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CellArrow"]];
    }
    return _arrowIv;
}

- (UISwitch *)switchBtn
{
    if (_switchBtn == nil) {
        _switchBtn = [[UISwitch alloc] init];
        //后期要随着主题而更改
        _switchBtn.tintColor = [UIColor redColor];
        _switchBtn.enabled = NO;
        // 监听开关的改变
        [_switchBtn addTarget:self action:@selector(switchBtnChagne) forControlEvents:UIControlEventValueChanged];
    }
    return _switchBtn;
}
- (UIView *)buttonView
{
    if (!_buttonView) {
        ZHSettingButtonItem *buttonItem = (id)self.item;
        _buttonView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
        CGFloat imgW = 30;
        CGFloat imgH = 30;
        UILabel *label = [[UILabel alloc]init];
        label.font = [UIFont systemFontOfSize:13];
        label.text = buttonItem.rightTitle;
        label.textColor = [UIColor lightGrayColor];
        CGSize size = [label.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
        [_buttonView addSubview:label];
        CGFloat labelW = size.width;
        CGFloat labelH = size.height;
        UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:buttonItem.icon]];
        _subImageView = imgView;
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeTheme) name:@"theme" object:nil];
        [self changeTheme];
        
        [_buttonView addSubview:imgView];
        
        imgView.frame = CGRectMake((_buttonView.frame.size.width - imgW - labelW) / 2, 5, imgW, imgH);
        label.frame = CGRectMake((_buttonView.frame.size.width - imgW - labelW) / 2 + imgW, (_buttonView.frame.size.height - labelH) / 2, labelW, labelH);
    }
    return _buttonView;
}
- (void)changeTheme
{
    NSString *name = [NSString stringWithFormat:@"%@.png",[ZHSkinTool team_id]]; ;
    [_subImageView sd_setImageWithURL:[NSURL URLWithString:ZHTeamsIconURL(name)]];
}
- (void)switchBtnChagne
{
        NSLog(@"switchBtnChagne %@", self.switchBtn);
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setBool:self.switchBtn.isOn forKey:self.item.title];
    
    [defaults synchronize];
}


+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *settingCell = @"settingCell";
   ZHSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:settingCell];
    if (cell == nil) {
        cell = [[ZHSettingCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:settingCell];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 初始化操作
        
        // 2. 清空子控件
        [self clearSubView];
        
        // 设置cell的宽度和屏幕一样宽
        //        self.frame = CGRectMake(0, 0, 1320, 44);

    }
    return self;
}


- (void)clearSubView
{
    // 3.清空子视图的背景颜色
    self.textLabel.backgroundColor = [UIColor clearColor];
    self.detailTextLabel.backgroundColor = [UIColor clearColor];
}

- (void)setItem:(ZHSettingItem *)item
{
    _item = item;
    // 设置数据
    self.textLabel.text = _item.title;
    //副标题
    self.detailTextLabel.text = _item.subTitle;
    // 设置辅助视图
    if ([NSStringFromClass(_item.class) isEqualToString:@"ZHSettingArrowItem"]) {
//        self.accessoryView = self.arrowIv;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }else if ([NSStringFromClass(_item.class) isEqualToString:@"ZHSettingSwitchItem"])
    {
        self.accessoryView = self.switchBtn;
        // 回复存储的状态
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        self.switchBtn.on = [defaults boolForKey:self.item.title];
        
        // 设置没有选中样式
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
    }else if ([NSStringFromClass(_item.class) isEqualToString:@"ZHSettingButtonItem"])
    {
        self.accessoryView = self.buttonView;
    }
    else
    {
        self.accessoryView = nil;
    }
    
}

@end

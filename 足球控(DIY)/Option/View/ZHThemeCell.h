//
//  ZHThemeCell.h
//  足球控(DIY)
//
//  Created by Aaron on 16/1/17.
//  Copyright © 2016年 叶无道. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHTheme;
@interface ZHThemeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *teamBGView;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
//对阵模型
@property (nonatomic,strong)  ZHTheme *model;

- (instancetype) initWithTableView :(UITableView *)tableView;
+ (instancetype) cellWithTableView :(UITableView *)tableView;
@end

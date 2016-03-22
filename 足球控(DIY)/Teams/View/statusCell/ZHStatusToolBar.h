//
//  ZHStatusToolBar.h
//  无道博博
//
//  Created by Aaron on 15/12/23.
//  Copyright (c) 2015年 叶无道. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHStatus.h"
@interface ZHStatusToolBar : UIView
@property (nonatomic,assign)CGRect toolBarFrame;
@property (nonatomic,strong)  ZHStatus *status;

//second
@property (weak, nonatomic) IBOutlet UIButton *commentClick;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *commentNumL;

- (IBAction)commentClick:(id)sender;


+(instancetype)toolBarComment;
+(instancetype)toolBarShowMsg;
@end

//
//  ZHTopView.h
//  足球控(DIY)
//
//  Created by Aaron on 15/12/30.
//  Copyright (c) 2015年 叶无道. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHFavourite.h"
@interface ZHTopView : UIView
@property (nonatomic,copy)void(^leftButtonClickBlock) ();
@property (nonatomic,copy)void(^shareButtonClickBlick) ();

@property (weak, nonatomic) IBOutlet UIImageView *teamIcon;
@property (weak, nonatomic) IBOutlet UIImageView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *teamNameL;
/**
 *  近期五场比赛的结果view
 */
@property (weak, nonatomic) IBOutlet UIView *recentResultsView;

@property (nonatomic,strong)  ZHFavourite *selectedTeam;
- (IBAction)leftButtonClick:(id)sender;
+(instancetype)topView;
@end

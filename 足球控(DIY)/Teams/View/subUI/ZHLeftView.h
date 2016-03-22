//
//  ZHLeftView.h
//  足球控(DIY)
//
//  Created by Aaron on 15/12/30.
//  Copyright (c) 2015年 叶无道. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FXBlurView.h"
#import "ZHFavourite.h"
@interface ZHLeftView : UIView<UITableViewDataSource,UITableViewDelegate>

/**
 * 点击cellrow后回调的代码
 */
@property (nonatomic,copy)void(^cellClickHandler) (ZHFavourite *selectedTeam);
/**
 *  这是点击添加按钮触发的block
 */
@property (nonatomic,copy)void(^addClickBlock) (void);
- (IBAction)editClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UITableView *myFavsTV;
/**
 *  关注的数据
 */
@property (nonatomic ,copy) NSArray *favsArray;

- (IBAction)addClick:(id)sender;
+(instancetype)leftView;
@end

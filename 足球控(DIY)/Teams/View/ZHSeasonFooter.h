//
//  ZHSeasonFooter.h
//  足球控(DIY)
//
//  Created by Aaron on 16/1/15.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Example2PieView;
@class ZHSeasonResult;
@interface ZHSeasonFooter : UIView
@property (weak, nonatomic) IBOutlet Example2PieView *pieView;
/**
 *  冠军
 */
@property (weak, nonatomic) IBOutlet UILabel *winL;
//亚军
@property (weak, nonatomic) IBOutlet UILabel *runnerL;
@property (nonatomic,strong)ZHSeasonResult *footerData;

+(instancetype)footer;
@end

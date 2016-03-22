//
//  ZHSeasonFooter.m
//  足球控(DIY)
//
//  Created by Aaron on 16/1/15.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import "ZHSeasonFooter.h"
#import "MyPieElement.h"
#import "Example2PieView.h"
#import "PieLayer.h"
#import "PieElement.h"
#import "ZHSeasonResult.h"
#import "UIView+Extension.h"
@interface ZHSeasonFooter ()
@property (weak, nonatomic) IBOutlet UILabel *goalL;
@property (weak, nonatomic) IBOutlet UILabel *lostL;
@property (weak, nonatomic) IBOutlet UILabel *pureL;
@property (weak, nonatomic) IBOutlet UILabel *pointsL;

@property (weak, nonatomic) IBOutlet UILabel *totalGL;


@end


typedef enum
{
    ZHLeagueResultWin,
    ZHLeagueResultLost,
    ZHLeagueResultDraw
}ZHLeagueResult;

@implementation ZHSeasonFooter

+(instancetype)footer
{
    return [[[NSBundle mainBundle]loadNibNamed:@"ZHSeasonFooter" owner:nil options:nil]lastObject];
}

//增加values
- (void)addValues:(CGFloat)value forResult:(ZHLeagueResult)result
{
    MyPieElement *ele;//保存冰冰
    switch (result) {
        case 0:
            ele = [MyPieElement pieElementWithValue:value color:ZHColor(97, 174, 33)];
            if (value) {
              ele.title = [NSString stringWithFormat:@"赢 %d",(int)value];
            }
            break;
        case 1:
            ele = [MyPieElement pieElementWithValue:value color:ZHColor(197, 56, 32)];
            if (value) {
               ele.title = [NSString stringWithFormat:@"输 %d",(int)value];
            }
            break;
        case 2:
            ele = [MyPieElement pieElementWithValue:value color:ZHColor(210, 136, 0)];
            if (value) {
              ele.title = [NSString stringWithFormat:@"平 %d",(int)value];
            }
            break;
        default:
            break;
    }
    [self.pieView.layer addValues:@[ele] animated:YES];
    
    // 设置每一块标题的内容
    self.pieView.layer.transformTitleBlock = ^(PieElement* elem){
        MyPieElement *myele = (MyPieElement *)elem;
        return myele.title;
    };
    // 设置每一块的标题的显示样式
    self.pieView.layer.showTitles = ShowTitlesAlways;
}

//传递模型
-(void)setFooterData:(ZHSeasonResult *)footerData
{
    self.goalL.text = [NSString stringWithFormat:@"%lu", footerData.w_ball_count];
    self.lostL.text = [NSString stringWithFormat:@"%lu", footerData.l_ball_count];
    self.pureL.text = [NSString stringWithFormat:@"%ld", footerData.w_ball_count - footerData.l_ball_count];
    
    self.pointsL.text = [NSString stringWithFormat:@"%lu", footerData.points];

    //添加饼图数据
    [self addValues:(CGFloat)footerData.w_game_count forResult:ZHLeagueResultWin];
    [self addValues:(CGFloat)footerData.l_game_count forResult:ZHLeagueResultLost];
    [self addValues:(CGFloat)footerData.d_game_count forResult:ZHLeagueResultDraw];
    self.totalGL.text = [NSString stringWithFormat:@"%ld", footerData.w_game_count + footerData.l_game_count + footerData.d_game_count];
}
@end

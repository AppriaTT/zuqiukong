//
//  ZHPersonStatisView.h
//  足球控(DIY)
//
//  Created by Aaron on 16/1/17.
//  Copyright © 2016年 叶无道. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHPerson;
@interface ZHPersonStatisView : UIView

@property (nonatomic,strong)  ZHPerson *person;
+(instancetype)view;
@end

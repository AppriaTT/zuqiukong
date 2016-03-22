//
//  ZHSectionHeaderView.h
//  足球控(DIY)
//
//  Created by Aaron on 16/1/5.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHSectionHeaderView : UIView
@property (nonatomic,copy)void(^moreClickblock) ();
@property (nonatomic,copy)void(^newsClickblock) ();

- (IBAction)rightMoreClick;
- (IBAction)rightNewsClick;

+(instancetype)headerViewWithIndex:(NSInteger)index;
@end

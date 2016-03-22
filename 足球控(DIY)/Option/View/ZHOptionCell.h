//
//  ZHOptionCell.h
//  足球控(DIY)
//
//  Created by Aaron on 16/1/11.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHOptionCell : UITableViewCell
@property (nonatomic,copy)void(^optionBlock) (NSString *title,NSString*url);

+(instancetype)cellWithIndexPath:(NSIndexPath   *)indexPath;
@end

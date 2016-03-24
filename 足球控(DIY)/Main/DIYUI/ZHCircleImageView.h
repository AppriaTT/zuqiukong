//
//  ZHCircleImageView.h
//  LinkHere(R)
//
//  Created by arron on 16/3/17.
//  Copyright © 2016年 LinkHere. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  高效率的创建圆角view
 */
@interface ZHCircleImageView : UIImageView
//@property (nonatomic, strong) UIImage *image;
////圆角的弧度
@property (nonatomic, assign) NSUInteger cornerRadius;
@end

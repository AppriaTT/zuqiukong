//
//  ZHAdvertisementSView.h
//  02-广告视图
//
//  Created by Aaron on 15/12/15.
//  Copyright (c) 2015年 肖喆. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ZHAdvertisementSView : UIScrollView<UIScrollViewDelegate>
/**
 *  可以设置是否添加定时器
 */
@property (nonatomic,assign,getter=isAddTimer)BOOL addTimer;
//@property (nonatomic,strong)UIPageControl *pageControl;

/**
 *  返回一个顶部的广告滚动条 默认为宽度375 ,高度150
 */

/**
 *  点击图片回调的block
 */
@property (nonatomic,copy)void(^imgViewClickHandler) (NSInteger index);

+ (instancetype)advertisementScrollVeiw;
/**
 *  添加需要滚动的图片数组
 */


- (void)addImages :(NSArray *)imageNames;

/**
 *可初始化frame
 */
- (instancetype)initWithFrame:(CGRect)frame;
@end

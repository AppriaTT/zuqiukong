//
//  ZHPageSlider.h
//  shareCode
//
//  Created by Aaron on 15/12/17.
//  Copyright (c) 2015年 叶无道. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHPageSlider;
@protocol ZHPageSliderDelegate <NSObject>
@optional
- (void)ZHPageSliderTitleButtonDidClicked:(ZHPageSlider *)pageSlider atIndex:(NSUInteger)index WithButton:(UIButton *)button;
@end

@interface ZHPageSlider : UIScrollView
@property(nonatomic,assign)NSUInteger pageNumber;
/**
 *  设置此属性可以调整当前被选中的按钮index
 */
@property(nonatomic,assign)NSInteger selectedIndex;
//@property(nonatomic,strong)UILabel *rollLable;
/**
 *  移动的小三角
 */
@property (nonatomic,strong) UIImageView *rollLable;
/**
 *  两个button之间的间距
 */
@property(nonatomic,assign)CGFloat margin;

/**
 *  标题的数组,必须要设置的 ,默认为1
 */

@property (nonatomic ,copy) NSArray *titleArray;
/**
 *  特别的代理
 */
@property (nonatomic,weak) id<ZHPageSliderDelegate> pageDelegate;

///**
// *  设置一个标题的宽度
// */
//@property (nonatomic,assign)CGFloat titleButtonWidth;

/**
 *  @return 返回一个可滚动的标题条,默认背景色为透明
 */
+(instancetype)pageSlider;
+(instancetype)pageSliderWithFrame:(CGRect)frame;

/**
 *  titleMargin 默认占据整个pageSlider宽度  可以进行titleMargin的重置
 */
-(void)setMargin:(CGFloat)margin;


@end

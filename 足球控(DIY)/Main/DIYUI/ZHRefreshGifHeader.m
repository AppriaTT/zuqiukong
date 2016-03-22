//
//  ZHRefreshGifHeader.m
//  足球控(DIY)
//
//  Created by Aaron on 16/1/5.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import "ZHRefreshGifHeader.h"
@interface ZHRefreshGifHeader()
@property (weak, nonatomic) UIImageView *gifView;
/** 所有状态对应的动画图片 */
@property (strong, nonatomic) NSMutableDictionary *stateImages;
/** 所有状态对应的动画时间 */
@property (strong, nonatomic) NSMutableDictionary *stateDurations;
//覆盖父类的小菊花
@property (weak, nonatomic) UIActivityIndicatorView *loadingView;
@end

@implementation ZHRefreshGifHeader
{
    __unsafe_unretained UIImageView *_arrowView;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        //隐藏时间
        self.lastUpdatedTimeLabel.hidden = YES;
        // 设置正在刷新状态的动画图片
        NSArray *refreshingImages = @[@"refresh_ic00",@"refresh_ic01",@"refresh_ic02",@"refresh_ic03"];
        NSMutableArray   *mArray = [NSMutableArray array];
        for (int i = 0; i < refreshingImages.count; i++) {
            UIImage *img = [UIImage imageNamed:refreshingImages[i]];
            [mArray addObject:img];
        }
        refreshingImages = mArray;
        [self setImagesForRefreshingState:refreshingImages];
    }
    return self;
}


//重写这个方法 改变图片样式
- (UIImageView *)arrowView
{
    if (!_arrowView) {
        UIImage *image = [UIImage imageNamed:@"refresh_down"] ?: [UIImage imageNamed:@"refresh_down"];
        UIImageView *arrowView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:_arrowView = arrowView];
        
    }
    return _arrowView;
}

#pragma mark - 懒加载
- (UIImageView *)gifView
{
    if (!_gifView) {
        UIImageView *gifView = [[UIImageView alloc] init];
        [self addSubview:_gifView = gifView];
    }
    return _gifView;
}

- (NSMutableDictionary *)stateImages
{
    if (!_stateImages) {
        self.stateImages = [NSMutableDictionary dictionary];
    }
    return _stateImages;
}

- (NSMutableDictionary *)stateDurations
{
    if (!_stateDurations) {
        self.stateDurations = [NSMutableDictionary dictionary];
    }
    return _stateDurations;
}

#pragma mark - 公共方法
- (void)setImages:(NSArray *)images duration:(NSTimeInterval)duration forState:(MJRefreshState)state
{
    if (images == nil) return;
    
    self.stateImages[@(state)] = images;
    self.stateDurations[@(state)] = @(duration);
    
    /* 根据图片设置控件的高度 */
    UIImage *image = [images firstObject];
    if (image.size.height > self.mj_h) {
        self.mj_h = image.size.height;
    }
}

- (void)setImagesForRefreshingState:(NSArray *)images
{
    [self setImages:images duration:images.count * 0.1 forState:MJRefreshStateRefreshing];
}

- (void)placeSubviews
{
    [super placeSubviews];
    
    if (self.gifView.constraints.count) return;
    
    self.gifView.frame = self.bounds;
    if (self.stateLabel.hidden && self.lastUpdatedTimeLabel.hidden) {
        self.gifView.contentMode = UIViewContentModeCenter;
    } else {
        self.gifView.contentMode = UIViewContentModeRight;
        self.gifView.mj_w = self.mj_w * 0.5 - 90;
    }
}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState
    if (state == MJRefreshStateIdle || state == MJRefreshStatePulling) {
        [self.gifView stopAnimating];
        [super setState:state];
        
    }else
    {// refreshing
        NSArray *images = self.stateImages[@(state)];
        if (images.count == 0) return;
        
        [self.gifView stopAnimating];
        if (images.count == 1) { // 单张图片
            self.gifView.image = [images lastObject];
            
            
        } else { // 多张图片
            self.gifView.animationImages = images;
            self.gifView.animationDuration = [self.stateDurations[@(state)] doubleValue];
            [self.gifView startAnimating];
        }
    }
}
@end

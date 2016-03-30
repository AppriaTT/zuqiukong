//
//  ZHStatusOriginView.m
//  无道博博
//
//  Created by Aaron on 15/12/23.
//  Copyright (c) 2015年 叶无道. All rights reserved.
//

#import "ZHStatusOriginView.h"
#import "UIImageView+WebCache.h"
#import "UIView+Extension.h"
#import "ZHStatus.h"
#import "FXBlurView.h"
#import "ZHCircleImageView.h"
@implementation ZHStatusOriginView
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.width = screenW;
        //        //文字
        UILabel *textLable = [[UILabel alloc]init];
        textLable.numberOfLines = 0;
        textLable.font = textFont;
        [self addSubview:textLable];
        _textLable = textLable;
        //图片
        ZHCircleImageView *picView = [[ZHCircleImageView alloc]init];
        picView.cornerRadius = 5;
//        picView.layer.masksToBounds = YES;
        picView.contentMode = UIViewContentModeScaleAspectFill;
        picView.clipsToBounds = YES;
        [self addSubview:picView];
        _picView = picView;
    }
    return self;
}
-(void)setOriginalFrame:(ZHStatusOriginalFrame *)originalFrame
{
    _originalFrame = originalFrame;
    self.textLable.frame = _originalFrame.textFrame;
    self.picView.frame = _originalFrame.picFrame;

    if ([_status.source containsString:@"IFTTT_Official"]) {
        //蒙版图层
        UIView *bgView = [[UIView alloc]initWithFrame:_originalFrame.hudViewFrame];
        [UIView insertColorLayerWithView:bgView];
        _bgView = bgView;
        [self addSubview:_bgView];
    }
    [self bringSubviewToFront:self.textLable];
    self.height = _originalFrame.viewHeight;
}

//设置数据
-(void)setStatus:(ZHStatus *)status
{
    _status =status;
    _textLable.text = status.text;
    if ([_status.source containsString:@"IFTTT_Official"]) {
     [_picView sd_setImageWithURL:[NSURL URLWithString:status.original_pic] placeholderImage:[UIImage imageNamed:@"news_ic_image_default"]];
    }else{
        [_picView sd_setImageWithURL:[NSURL URLWithString:status.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"news_ic_image_default"]];
    }
}
@end

//
//  ZHCircleImageView.m
//  LinkHere(R)
//
//  Created by arron on 16/3/17.
//  Copyright © 2016年 LinkHere. All rights reserved.
//

#import "ZHCircleImageView.h"

@implementation ZHCircleImageView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGRect bounds = self.bounds;
    
    [[UIColor clearColor] set];
    UIRectFill(bounds);
    
    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:_cornerRadius] addClip];
    
    [self.image drawInRect:bounds];
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
//- (void)setImage:(UIImage *)image {
//    
//    _image = image;
//    [self setNeedsDisplay];
//}

- (void)setCornerRadius:(NSUInteger)cornerRadius
{
    _cornerRadius = cornerRadius;
    [self setNeedsDisplay];
}
@end

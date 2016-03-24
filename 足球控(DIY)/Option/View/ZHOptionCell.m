//
//  ZHOptionCell.m
//  足球控(DIY)
//
//  Created by Aaron on 16/1/11.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import "ZHOptionCell.h"
#import "TotalAPI.h"
#import "UIButton+WebCache.h"
#import "ZHCircleImageView.h"
@interface ZHOptionCell()
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;

@end
@implementation ZHOptionCell
{
    NSString *_titleLeft;
    NSString *_urlLeft;
    NSString *_titleRight;
    NSString *_urlRight;
}
+(instancetype)cellWithIndexPath:(NSIndexPath   *)indexPath
{
    return [[NSBundle mainBundle]loadNibNamed:@"ZHOptionCell" owner:nil options:nil][indexPath.section];
}
- (IBAction)game1Click:(id)sender {
    NSLog(@"game1Click");
    self.optionBlock(_titleLeft,_urlLeft);
}
- (IBAction)game2Click:(id)sender {
    self.optionBlock(_titleRight,_urlRight);
}

-(void)awakeFromNib
{
    //切换圆角 button
    self.btn1.layer.cornerRadius = 10;
    self.btn2.layer.cornerRadius = 10;
    self.btn2.layer.masksToBounds = YES;
    self.btn1.layer.masksToBounds = YES;
    [ZHHttpTool Get:ZHOptionGameURL parameters:nil acceptableContentTypes:@"application/json" success:^(id responseObject) {
        [self.btn1 sd_setImageWithURL:[NSURL URLWithString:responseObject[@"data"][@"game"][0][@"img"]] forState:UIControlStateNormal];
        _titleLeft = responseObject[@"data"][@"game"][0][@"title"];
        _urlLeft = responseObject[@"data"][@"game"][0][@"sharelink"];
        [self.btn2 sd_setImageWithURL:[NSURL URLWithString:responseObject[@"data"][@"game"][1][@"img"]] forState:UIControlStateNormal];
        _titleRight = responseObject[@"data"][@"game"][1][@"title"];
        _urlRight = responseObject[@"data"][@"game"][1][@"sharelink"];
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
- (IBAction)guessClick:(id)sender {
    self.optionBlock(@"竞猜榜单",nil);
}

@end

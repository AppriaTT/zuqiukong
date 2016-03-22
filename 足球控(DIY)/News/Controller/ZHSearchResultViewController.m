//
//  ZHSearchResultViewController.m
//  足球控(DIY)
//
//  Created by Aaron on 16/1/4.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import "ZHSearchResultViewController.h"

@interface ZHSearchResultViewController ()

@end

@implementation ZHSearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
}

-(void)willMoveToParentViewController:(UIViewController *)parent
{
    self.view.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64);
}
@end

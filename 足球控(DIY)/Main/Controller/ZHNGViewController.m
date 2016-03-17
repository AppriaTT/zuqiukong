//
//  ZHNGViewController.m
//  足球控(DIY)
//
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import "ZHNGViewController.h"
#import "UIImage+ZH.h"
#import "TotalAPI.h"
#import "ZHSkinTool.h"
@interface ZHNGViewController ()

@end

@implementation ZHNGViewController

//创建导航栏的单例对象
+(void)initialize
{
//    UINavigationBar *appearance = [UINavigationBar appearance];
//    [appearance setBackgroundImage:[UIImage colorfulPicture:[ZHSkinTool skinToolWithNorBGColor] withSize:CGSizeMake(375, 64)] forBarMetrics:UIBarMetricsDefault];
//    appearance.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self changeNGBarColor];
    UINavigationBar *appearance = [UINavigationBar appearance];
    appearance.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeNGBarColor) name:@"theme" object:nil];
}
- (void)changeNGBarColor
{
    UINavigationBar *appearance = [UINavigationBar appearance];
    [appearance setBackgroundImage:[UIImage colorfulPicture:[ZHSkinTool skinToolWithNorBGColor] withSize:CGSizeMake(375, 64)] forBarMetrics:UIBarMetricsDefault];
}

//重写push方法让push隐藏底部栏
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    static int pushTime = 0;
    pushTime++;
    if (pushTime > 5) {
        viewController.hidesBottomBarWhenPushed = YES;
//        viewController.
//        self.navigationBar.hidden = NO;
    }

    [super pushViewController:viewController animated:YES];
}
#pragma mark dealloc
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end

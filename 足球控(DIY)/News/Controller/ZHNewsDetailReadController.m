//
//  ZHNewsDetailReadController.m
//  足球控(DIY)
//
//  Created by Aaron on 16/1/10.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import "ZHNewsDetailReadController.h"
#import "UIBarButtonItem+Extension.h"
#import "ZHNews.h"
#import "UIView+Extension.h"
#import "MBProgressHUD+MJ.h"
@interface ZHNewsDetailReadController ()<UIWebViewDelegate,UIScrollViewDelegate>
@property (nonatomic,weak)UIWebView *webView;
@end

@implementation ZHNewsDetailReadController
{
    NSInteger _lastContentOffSetY;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self setupNVbar];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark setupUI
- (void)setupNVbar
{
    self.navigationItem.title = @"阅读新闻";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithNormalImageName:@"topbar_right_ic_share_default" highlitedImageName:@"topbar_right_ic_share_pressed" andTarget:self action:@selector(shareClick)];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithNormalImageName:@"topbar_left_ic_back_default" highlitedImageName:@"topbar_left_ic_back_pressed" imageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 20) andTarget:self action:@selector(backClick)];
}

- (void)shareClick
{
    NSLog(@"点击了分享");
}
-(void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)setupWebView
{
    UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    self.webView = webView;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.webView.height -=64;
    self.webView.delegate = self;
    [self.view addSubview:webView];
    webView.backgroundColor = [UIColor whiteColor];
//    NSURLRequest *request = [NSURLRequest requestWithURL:];
    self.webView.scrollView.delegate = self;
}
//传递数据进来时
-(void)setNews:(ZHNews *)news
{
    _news = news;
    [self setupWebView];
    //创建请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:news.appLink]];
    request.timeoutInterval = 15;
    //加载请求
    [self.webView loadRequest:request];

}
- (void)setShareLink:(NSString *)shareLink
{
    _shareLink = shareLink;
    ZHNews *game = [[ZHNews alloc]init];
    game.appLink = shareLink;
    //给数据
    self.news = game;
}

#pragma mark UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
//    [MBProgressHUD showMessage:@"正在玩命加载新闻噢亲~!"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [MBProgressHUD hideHUD];
    });
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
//    [MBProgressHUD showError:@"抱歉大哥网络太慢 加载失败了~~~"];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MBProgressHUD hideHUD];
    [self.webView removeFromSuperview];
}

- (void)scrollViewDidScroll:(UIScrollView*)scrollView{
    //_lastcontentoffset上一次滑动的距离
    if(scrollView.contentOffset.y>0) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        
        if(scrollView.contentOffset.y-_lastContentOffSetY<=0) {
                    [self.navigationController setNavigationBarHidden:NO animated:YES];
                }
    }
    _lastContentOffSetY=scrollView.contentOffset.y;
}

@end

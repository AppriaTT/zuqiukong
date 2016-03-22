//
//  ZHSearchViewController.m
//  足球控(DIY)
//
//  Created by Aaron on 16/1/7.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import "ZHSearchViewController.h"
#import "UIView+Extension.h"
#import "TotalAPI.h"
@interface ZHSearchViewController ()<UISearchControllerDelegate,UISearchResultsUpdating,UISearchBarDelegate>

@end

@implementation ZHSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}
- (void)setupSelf
{
    self.searchBar.size = CGSizeMake(self.view.frame.size.width - 10, 30);
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.dimsBackgroundDuringPresentation = YES;
//    self.delegate = self;
    self.searchBar.placeholder = @"搜索球员";
//    self.searchResultsUpdater = self;
//    self.searchBar.delegate =self;
    self.searchBar.frame = CGRectMake(0, 0, self.view.width , 40);
    UIView *view =self.searchBar.subviews[0];
    
    //改变搜索框的背景
    for (UIView *subview in view.subviews) {
        if ([NSStringFromClass(subview.class)  isEqualToString:@"UISearchBarBackground"]) {
            [subview removeFromSuperview];
            UIView *redView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 30)];
            view.backgroundColor = ArsenalSearchBarColor;
            [self.searchBar insertSubview:redView belowSubview:view.subviews[0]];
        }
        if ([NSStringFromClass(subview.class)  isEqualToString:@"UISearchBarTextField"]) {
            subview.backgroundColor = [UIColor whiteColor];
        }
    }
}
#pragma mark UISearchResultsUpdating 代理方法
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSLog(@"%s",__func__);
}
#pragma mark UISearchControllerDelegate

#pragma mark 搜索框的代理方法，搜索输入框获得焦点（聚焦）
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:NO];
    UIView *view = self.searchBar.subviews[0];
    
    // 修改UISearchBar右侧的取消按钮文字颜色及背景图片
    for (UIView *searchbuttons in [view subviews]){
        if ([searchbuttons isKindOfClass:[UIButton class]]) {
            UIButton *cancelButton = (UIButton*)searchbuttons;
            NSAttributedString *string = [[NSAttributedString alloc]initWithString:@"完成" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
            [cancelButton setAttributedTitle:string forState:UIControlStateNormal];
            // 修改文字颜色
            [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [cancelButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        }
    }
    return YES;
}
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    
    
}
-(void)willMoveToParentViewController:(UIViewController *)parent
{
    [self setupSelf];
}
@end



#import "ZHTabBarController.h"
#import "ZHTeamsViewController.h"
#import "ZHMatchesViewController.h"
#import "ZHNewsViewController.h"
#import "ZHScoutViewController.h"
#import "ZHOptionViewController.h"
#import "UIImage+ZH.h"
#import "ZHNGViewController.h"
#import "ZHSkinTool.h"
#import "ZHNGMainTool.h"
#define imgArray0 @[@"tabbar_ic_teams_default",@"tabbar_ic_competition_default",@"tabbar_ic_news_default",@"tabbar_ic_scuot_default",@"tabbar_ic_option_default"]

#define imgSelectedArray0  @[@"tabbar_ic_teams_selected",@"tabbar_ic_competition_selected",@"tabbar_ic_news_selected",@"tabbar_ic_scout_selected",@"tabbar_ic_option_selected"]

#define nameArray0 @[@"ZHTeamsViewController",@"ZHMatchesViewController",@"ZHNewsViewController",@"ZHScoutViewController",@"ZHOptionViewController"];
@interface ZHTabBarController ()

@end

@implementation ZHTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTabBarItems];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeTheme) name:@"theme" object:nil];
    
    [ZHNGMainTool sharedVCTool].mainTabVC = self;
    
}

//设置换肤
- (void)changeTheme
{
    [self setTeamTheme];
    //进行换肤设置
}
- (void)setupTabBarItems
{
    //另一种快速添加方法
    NSArray *array = @[@"球队",@"比赛",@"资讯",@"球探",@"设置"];
    NSArray *imgArray = imgArray0;
    NSArray *imgSelectedArray = imgSelectedArray0;
    NSArray *nameArray = nameArray0;
    for (int i = 0; i < array.count; i++) {
        [self addTabBarItemController:NSClassFromString(nameArray[i]) image:imgArray[i] selectedImage:imgSelectedArray[i] title:array[i]];
    }
}
- (void)addTabBarItemController:(Class)VCClass image:(NSString *)imageName selectedImage:(NSString *)selectedImageName title:(NSString *)title
{
    UIViewController *vc = [[VCClass alloc]init];
        ZHNGViewController *nvc = [[ZHNGViewController alloc]initWithRootViewController:vc];
        [self addChildViewController:nvc];
    [vc.tabBarItem setImage:[[ZHSkinTool skinToolWithThemeImg:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [vc.tabBarItem setSelectedImage:[[ZHSkinTool skinToolWithThemeImg:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    vc.title = title;
}

- (void)setTeamTheme
{
    NSArray *imgArray = imgArray0;
    NSArray *imgSelectedArray = imgSelectedArray0;
    
    for (int i = 0;i < imgArray.count;i++) {
        NSString *norImg = imgArray[i];
        NSString *selImg = imgSelectedArray[i];
        UIViewController *vc = self.childViewControllers[i];
        [vc.tabBarItem setImage:[[ZHSkinTool skinToolWithThemeImg:norImg] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
        [vc.tabBarItem setSelectedImage:[[ZHSkinTool skinToolWithThemeImg:selImg] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    }
}
#pragma mark dealloc
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end

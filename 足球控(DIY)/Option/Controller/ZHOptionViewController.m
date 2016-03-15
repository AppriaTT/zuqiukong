

#import "ZHOptionViewController.h"
#import "ZHSettingTopView.h"
#import "ZHSettingViewController.h"
#import "ZHRefreshGifFooter.h"
#import "ZHRefreshGifHeader.h"
#import "UIView+Extension.h"
#import "ZHOptionCell.h"
#import "ZHNewsDetailReadController.h"

#import <MobileCoreServices/MobileCoreServices.h>
@interface ZHOptionViewController ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
@property (nonatomic,weak)UITableView *tableView;
@end

@implementation ZHOptionViewController
{
    ZHSettingTopView *_topview;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTopView];
    [self setupTableView];
}
- (void)setupTopView
{
    ZHSettingTopView *topView = [ZHSettingTopView settingTopView];
    _topview = topView;
    [self.view addSubview:topView];
    __weak typeof (self) weakSelf = self;
    
    [topView setSettingBtnBlock:^{
        ZHSettingViewController *detailSettingVC = [[ZHSettingViewController alloc]init];
        //可能要自己写..
        [weakSelf.navigationController pushViewController:detailSettingVC animated:YES];
    }];
    // 此方法在iOS8.3后过时
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"选择你想要取照的方式" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", nil];
    [sheet addButtonWithTitle:@"相册"];
//    [sheet ]
    //换头像 按钮
    [_topview setIconBtnBlock:^{
        //弹出alertSheet
        [sheet showInView:weakSelf.view];
    }];
}

- (void)setupTableView
{
    //    UITableView *tv = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    UITableView *tv = [[UITableView alloc]init];
    self.tableView = tv;
    self.tableView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:tv];
    self.tableView.y = _topview.height;
    self.tableView.width = self.view.width;
    self.tableView.height = self.view.height - 64 - 49 - _topview.height;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //设置刷新控件
    //设置下拉 refreshing
    ZHRefreshGifHeader *header = [ZHRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    //闲置状态
    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    //拉紧状态
    [header setTitle:@"释放更新" forState:MJRefreshStatePulling];
    //刷新状态
    [header setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    self.tableView.mj_header = header;
    
    ZHRefreshGifFooter *footer = [ZHRefreshGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    //闲置状态
    [footer setTitle:@"下拉加载后七天赛程" forState:MJRefreshStateIdle];
    //拉紧状态
    [footer setTitle:@"释放加载后七天赛程" forState:MJRefreshStatePulling];
    //刷新状态
    [footer setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    
    self.tableView.mj_footer = footer;
}
#pragma mark UIActionSheet delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 2) {
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
            NSLog(@"%lu",buttonIndex);
            [self loadImageWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        }else{
            //弹出对话框提醒用户
            NSLog(@"无法访问相册");
        }
        
    }else
    {
        if (buttonIndex == 0){
            NSLog(@"%lu",buttonIndex);
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                [self loadImageWithSourceType:UIImagePickerControllerSourceTypeCamera];
            }else{
                //弹出对话框提醒用户
                NSLog(@"没有相机");
            }
         }
    }
}

-(void)loadImageWithSourceType:(UIImagePickerControllerSourceType)SourceType
{
    UIImagePickerController *pc=[[UIImagePickerController alloc]init];
    //pc.sourceType 上面的枚举
    pc.sourceType=SourceType;
    //设置代理方法
    pc.delegate=self;
    //设置选中图片之后，是否允许对图片操作
    pc.allowsEditing=YES;
    //一般系统的ViewController都是用模态化的方式呈现的
    [self presentViewController:pc animated:YES completion:^{
        
    }];
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

//点击完成之后，调用的方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
//    NSLog(@"%@",info);
    NSString *str=info[UIImagePickerControllerMediaType];
    if ([str isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *image=info[@"UIImagePickerControllerOriginalImage"];
        [_topview.iconBtn setBackgroundImage:image forState:UIControlStateNormal ];
        _topview.iconBtn.contentMode = UIViewContentModeScaleAspectFill;
        _topview.iconBtn.layer.masksToBounds = YES;
        _topview.iconBtn.layer.cornerRadius = _topview.iconBtn.width / 2;
//        _topview.iconBtn.layer
        [picker dismissViewControllerAnimated:YES completion:^{
            
        }];
        
    }
    
}

//下拉刷新
- (void)headerRefresh
{
    NSLog(@"headerRefresh");
    [self.tableView.mj_header endRefreshing];
}
//上拉刷新
-(void)footerRefresh
{
    NSLog(@"footerRefresh");
    [self.tableView.mj_footer endRefreshing];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return 92;
            break;
        case 1:
            return 68;
            break;
        case 2:
            return 120;
            break;
        default:return 0 ;
            break;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZHOptionCell *cell = [ZHOptionCell cellWithIndexPath:indexPath];

        [cell setOptionBlock:^(NSString *title, NSString *shareLink) {
            ZHNewsDetailReadController *vc = [[ZHNewsDetailReadController alloc]init];
            //加载webView控制器
            [self.navigationController pushViewController:vc animated:YES];
            vc.shareLink = shareLink;
            vc.navigationItem.title = title;
        }];

    return cell;
}
@end

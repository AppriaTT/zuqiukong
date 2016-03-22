//
//  ZHLeftView.m
//  足球控(DIY)
//
//  Created by Aaron on 15/12/30.
//  Copyright (c) 2015年 叶无道. All rights reserved.
//

#import "ZHLeftView.h"
#import "UIImageView+WebCache.h"
#import "ZHFavourite.h"
#import "ZHTools.h"
#import "ZHMyFavs.h"
#import "TotalAPI.h"
#import "ZHSkinTool.h"
@interface ZHLeftView ()
@property (weak, nonatomic) IBOutlet UIView *topView;

@end
@implementation ZHLeftView
//添加表头部的小图标
-(void)awakeFromNib
{
    UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"teams_choose_ic_mainteam"]];
    [self.myFavsTV addSubview:imgView];
    imgView.frame = CGRectMake(0, 0, 22, 22);
    [self changeTopViewColor];
    //收到通知就换皮肤
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeTopViewColor) name:@"theme" object:nil];

}

//收到通知就换皮肤
-(void)changeTopViewColor
{
    self.topView.backgroundColor = [ZHSkinTool skinToolWithNorBGColor];
}


- (IBAction)addClick:(id)sender {
    self.addClickBlock();
}

-(void)setFavsArray:(NSArray *)favsArray
{
    _favsArray = favsArray;
    [self.myFavsTV reloadData];
}

+(instancetype)leftView
{
    return [[[NSBundle mainBundle]loadNibNamed:@"ZHLeftView" owner:nil options:nil]lastObject];
}



//点击编辑后
- (IBAction)editClick:(UIButton *)sender {

    if ((sender.selected = !sender.selected)) {
        [UIView animateWithDuration:0.3 animations:^{
            self.myFavsTV.editing = YES;
            
        }];
        
    }
    else
    {
        [UIView animateWithDuration:0.3 animations:^{
        self.myFavsTV.editing = NO;
                }];
        //持久化
        
        [ZHTools archiveObjecjsInSandBox:self.favsArray withName:@"myFavs"];

    }
    
}

#pragma mark UITableView 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.favsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *favsID = @"favsCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:favsID];
    if (cell == nil) {
        UITableViewCell *newC = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:favsID];
        cell = newC;
    }
    ZHFavourite *fav = self.favsArray[indexPath.row];
    //设置图标
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:ZHTeamsIconURL(fav.logourl)] placeholderImage:[UIImage imageNamed:@"team_logo_default"]];
    cell.textLabel.text = fav.club_name;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return YES;
}
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//移动cell
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    //保存
    ZHFavourite *sourceFav = self.favsArray[sourceIndexPath.row];
    //删除
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.favsArray];
    [[ZHMyFavs myFavs]removeObjectAtIndex:sourceIndexPath.row];
    [array removeObjectAtIndex:sourceIndexPath.row];
    //添加
    [array insertObject:sourceFav atIndex:destinationIndexPath.row];
    [[ZHMyFavs myFavs] insertObject:sourceFav atIndex:destinationIndexPath.row];
    
    self.favsArray = array;
    //刷新
    [self.myFavsTV reloadData];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZHFavourite *fav = self.favsArray[indexPath.row];
    //从偏好设置里取消选中
    [ZHTools saveObject:@(0) forKeyInUserDefault:fav.club_name];
    //删除
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.favsArray];
    [array removeObjectAtIndex:indexPath.row];
    
    [[ZHMyFavs myFavs]removeObjectAtIndex:indexPath.row];
    self.favsArray = array;
    
    [self.myFavsTV reloadData];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //传递数据给block 
    self.cellClickHandler(self.favsArray[indexPath.row]);
    
}
#pragma mark dealloc
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end

//
//  ZHTeamsTableView.m
//  足球控(DIY)
//
//  Created by Aaron on 15/12/30.
//  Copyright (c) 2015年 叶无道. All rights reserved.
//

#import "ZHTeamsTableView.h"
#import "ZHStatusCell.h"
#import "ZHStatus.h"
@interface ZHTeamsTableView ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSArray *dataSourceArray;
@end
@implementation ZHTeamsTableView
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor blueColor];
    }
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZHStatusCell *cell = [ZHStatusCell cellWithTableView:tableView];
    //Configure the cell...
    
    //    设置数据
    
    ZHStatus *status = self.dataSourceArray[indexPath.section][indexPath.row];
    
    //    给cell传递模型数据
    cell.status = status;
    
    return cell;
}

@end


//
//  ZHSeaResultController.m
//  足球控(DIY)
//
//  Created by Aaron on 16/1/7.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import "ZHSeaResultController.h"

@interface ZHSeaResultController ()

@end

@implementation ZHSeaResultController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/
-(void)willMoveToParentViewController:(UIViewController *)parent
{
    self.view.frame = CGRectMake(0, 40, self.view.frame.size.width, self.view.frame.size.height);
}
@end

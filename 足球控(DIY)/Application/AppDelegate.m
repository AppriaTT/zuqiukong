//
//  AppDelegate.m
//  足球控(DIY)
//
//  Created by Aaron on 15/12/29.
//  Copyright (c) 2015年 叶无道. All rights reserved.
//

#import "AppDelegate.h"
#import "ZHTabBarController.h"
#import "UMSocial.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [UMSocialData setAppKey:@"569b815b67e58eca400007d1"];
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    ZHTabBarController   *vc = [[ZHTabBarController alloc]init];
    self.window.rootViewController = vc;
    return YES;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
//    　[_listTeams release];
    NSLog(@"%s",__func__); NSLog(@"%s",__func__); NSLog(@"%s",__func__); NSLog(@"%s",__func__); NSLog(@"%s",__func__); NSLog(@"%s",__func__); NSLog(@"%s",__func__); NSLog(@"%s",__func__); NSLog(@"%s",__func__); NSLog(@"%s",__func__); NSLog(@"%s",__func__); NSLog(@"%s",__func__); NSLog(@"%s",__func__);
}
@end

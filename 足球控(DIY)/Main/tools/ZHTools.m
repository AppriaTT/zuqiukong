//
//  ZHTool.m
//  UIFengzhuang
//
//  Created by Aaron on 15/11/19.
//  Copyright (c) 2015年 叶无道. All rights reserved.
//

#import "ZHTools.h"

@implementation ZHTools
+ (void)saveToSandBoxWithFileName :(NSString *)fileName andFile:(id)file
{
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
    NSString *filePath = [documentPath stringByAppendingPathComponent:fileName];
    //写进沙盒
    [file writeToFile:filePath atomically:YES];
}
+ (id)readFromSandBoxWithFileName :(NSString *)fileName andType:(ZHToolsFileType)type
{
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
    switch (type) {
        case 0:
            return [NSArray arrayWithContentsOfFile:[documentPath stringByAppendingPathComponent:fileName]];
            break;
        case 1:
            NSLog(@"%@",documentPath);
            return [NSDictionary dictionaryWithContentsOfFile:[documentPath stringByAppendingPathComponent:fileName]];
            break;
        default:
            break;
    }   
}
//读取
+ (id)objectForKeyInUserDefault:(NSString*)key
{
    NSUserDefaults *uf = [NSUserDefaults standardUserDefaults];

   return [uf objectForKey:key];

}

+ (void)saveObject:(id)object forKeyInUserDefault:(NSString*)key
{
    NSUserDefaults *uf = [NSUserDefaults standardUserDefaults];
    [uf setObject:object forKey:key];
    [uf synchronize];
}

+ (void)archiveObjecjsInSandBox:(id)object withName:(NSString *)name
{
    //此时保存一次我的关注 用归档 真机中沙盒要加个路径Documents
    NSString *path = [NSString stringWithFormat:@"%@/%@",[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"],name];
    [NSKeyedArchiver archiveRootObject:object toFile:path];
}

+ (void)archiveObjecjs:(id)object toFile:(NSString *)path
{
    [NSKeyedArchiver archiveRootObject:object toFile:path];
}

+(id)unarchiveObjectsWithFile:(NSString *)path
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}
@end

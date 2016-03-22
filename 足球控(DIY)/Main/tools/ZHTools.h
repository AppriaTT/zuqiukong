//
//  ZHTool.h
//  UIFengzhuang
//
//  Created by Aaron on 15/11/19.
//  Copyright (c) 2015年 叶无道. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum
{
    ZHToolsFileTypeNSArray,
    ZHToolsFileTypeNSDictionary
}ZHToolsFileType;

@interface ZHTools : NSObject
/**
 *  将数据存储进沙盒
 *
 *  @param fileName 文件的名字
 *  @param file     数据
 */
+ (void)saveToSandBoxWithFileName :(NSString *)fileName andFile:(id)file;

/**
 *  从沙盒中读取数据
 *
 *  @param fileName 文件名字
 *  @param type     要返回的数据类型
 */
+ (id)readFromSandBoxWithFileName :(NSString *)fileName andType:(ZHToolsFileType)type;
/**
 *  取出偏好数据中保存的数据
 *  @param key    标记
 */
+ (void)saveObject:(id)object forKeyInUserDefault:(NSString*)key;
/**
 *  存轻量数据在偏好设置中
 */
+ (id)objectForKeyInUserDefault:(NSString*)key;

/**
 *  归档在沙河中
 */
+ (void)archiveObjecjsInSandBox:(id)object withName:(NSString *)name;
/**
 *  归档在一个具体路径
 */
+ (void)archiveObjecjs:(id)object toFile:(NSString *)path;


+(id)unarchiveObjectsWithFile:(NSString *)path;
@end

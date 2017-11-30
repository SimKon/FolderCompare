//
//  GetFiles.m
//  FolderCompare
//
//  Created by shen_chao on 2017/11/8.
//  Copyright © 2017年 shen_chao. All rights reserved.
//

#import "GetFiles.h"
#import "CommonDefine.h"
@implementation GetFiles
#pragma mark ================ Interface =================

/**
 非递归,返回指定路径下的所有文件名
 @return Null：没有文件 NSArray：指定路径下的文件,由外部释放
 */
-(NSArray*)getSubFilesWithFolderName:(NSString*)folder andDepth:(int)depth error:(NSError**)error{
    NSArray* arrTemp = [self getSubFiles:folder NSError:error];
    NSMutableArray *arrNodes = [NSMutableArray new];
    for (int i = 0; i < arrTemp.count; i++) {
        FileNode *fileNode = [[FileNode alloc] initWithSimpleObject:[arrTemp objectAtIndex:i]  withDepth:depth];
        [arrNodes addObject:fileNode];
    }
    return arrNodes;
}

/**
 递归,返回指定路径下的所有文件名
depth 0:root文件夹 1:root文件夹下的文件 2:依次类推。作为对外接口调用的时候，应该设置为1，表示获取root文件夹下第一层文件的深度是1。
 @return Null：没有文件 NSArray：指定路径下的文件,由外部释放
 */
-(NSArray*)getAllSubFilesInFolder:(FileNode*)root error:(NSError**)error{
    if (root == nil || root.name == nil) {
        return nil;
    }
    // root下的所有文件
    NSArray *arrFiles = [self getSubFilesWithFolderName:root.fullPath andDepth:(root.depth+1) error:nil];
    for (int i = 0; i < arrFiles.count; i++) {
        FileNode *node = [arrFiles objectAtIndex:i];
        if (node.extension == FE_NOEXTENSION) {
            //-- 无后缀名的文件&文件夹 --//
            NSArray *arrChildrens = [self getAllSubFilesInFolder:node error:nil];
            node.subFiles = arrChildrens;
            node.subFilesCount = (unsigned short)arrChildrens.count;
        } else {
            //-- 有后缀名的文件 --//
            
        }
    }
    return arrFiles;
}


-(void)delResNode{}
#pragma mark ================ Private Funcs =================
-(NSArray*)getSubFiles:(NSString*)folder NSError:(NSError**)error{
    NSFileManager *manager = [NSFileManager defaultManager];
    NSArray *arrFiles = [manager contentsOfDirectoryAtPath:folder error:error];
    if (error != nil && [*error code] != 0) {
        return nil;
    }
    return arrFiles;
}

-(NSArray*)getAllSubFiles:(NSString*)folder NSError:(NSError**)error{
    return 0;
}

-(BOOL)isDirectory:(NSString*)filePath{
    BOOL isDirectory = NO;
    [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDirectory];
    return isDirectory;
}
//-(void)fetchFileInfo:(FileNode*)node withDepth:(int)depth {
//    
//}
@end

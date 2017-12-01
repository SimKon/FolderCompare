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
        NSString* fileName = [arrTemp objectAtIndex:i];
        // 特定文件跳过（一般是系统生成的隐藏文件）
        if ([SKIP_FILES containsObject:fileName]) {
            continue;
        }
        // Node生成
        FileNode *fileNode = [[FileNode alloc] initWithSimpleObject:[folder stringByAppendingPathComponent:fileName] withDepth:depth];
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
        NSLog(@"%s param error",__FUNCTION__);
        return nil;
    }
    
    if (root.type == FT_FILE) {
        // root为文件夹
        return nil;
    }
    
    // 获取root下的所有文件
    NSArray *arrFiles = [self getSubFilesWithFolderName:root.fullPath andDepth:(root.depth+1) error:nil];
    root.subFilesCount = arrFiles.count;
    
    for (int i = 0; i < arrFiles.count; i++) {
        FileNode *node = [arrFiles objectAtIndex:i];
        if (node.type == FT_FOLDER) {
            //-- 子文件为文件夹 --//
            NSArray *arrChildren = [self getAllSubFilesInFolder:node error:nil];
//            [arrChildren sortedArrayUsingSelector:@];
            node.subFiles = arrChildren;
            node.subFilesCount = (unsigned short)arrChildren.count;
        } else {
            //-- 子文件为文件 --//
        }
    }
    return arrFiles;
}

-(NSArray*)sortChildrenByName:(NSArray*)children{
    return children;
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
@end

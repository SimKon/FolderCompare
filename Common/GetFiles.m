//
//  GetFiles.m
//  FolderCompare
//
//  Created by shen_chao on 2017/11/8.
//  Copyright © 2017年 shen_chao. All rights reserved.
//

#import "GetFiles.h"
#import "CommonDefine.h"
#import "FileNode.h"
@implementation GetFiles
#pragma mark ================ Interface =================

/**
 非递归,返回指定路径下的所有文件名
 @return Null：没有文件 NSArray：指定路径下的文件,由外部释放
 */
-(NSArray*)getSubFilesInFolder:(NSString*)folder WithDepth:(int)depth NSError:(NSError**)error{
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
 @return Null：没有文件 NSArray：指定路径下的文件,由外部释放
 */
-(NSArray*)getAllSubFilesInFolder:(FileNode*)root NSError:(NSError**)error{
    if (root == nil || root.name == nil) {
        return nil;
    }
    NSMutableArray *arrFiles = [NSMutableArray new];
    NSArray *arrNodes = [self getSubFilesInFolder:root.name WithDepth:2 NSError:nil];
    return nil;
}

#pragma mark ================ Private Funcs =================
-(NSArray*)getSubFiles:(NSString*)folder NSError:(NSError**)error{
    NSFileManager *manager = [NSFileManager defaultManager];
    NSArray *arrFiles = [manager contentsOfDirectoryAtPath:folder error:error];
    if ([*error code] != 0) {
        return nil;
    }
    return arrFiles;
}

-(NSArray*)getAllSubFiles:(NSString*)folder NSError:(NSError**)error{
    return 0;
}

-(void)delResNode{}
/**
 
 
 @param node 叶结点
 @param depth 叶结点的深度
 */
//-(void)fetchFileInfo:(FileNode*)node withDepth:(int)depth {
//    
//}
@end

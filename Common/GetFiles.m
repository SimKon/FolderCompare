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
返回指定路径下的所有文件名
（非递归，返回值由外部释放）
 @param folder 指定路径
 @param error Error指针
 @return Null：没有文件 NSArray：指定路径下的文件
 */
-(NSArray*)getSubFilesInFolder:(NSString*)folder NSError:(NSError**)error{
    NSArray* arrTemp = [self getSubFiles:folder NSError:error];
    for (int i = 0; i < arrTemp.count; i++) {
        
    }
    return arrTemp;
}

/**
 返回指定路径下的所有文件名
 （递归，返回值由外部释放）
 @param folder 指定路径
 @param error Error指针
 @return Null：没有文件 NSArray：指定路径下的文件
 */
-(NSArray*)getAllSubFilesInFolder:(NSString*)folder NSError:(NSError**)error{
    return 0;
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

/**
 
 
 @param node 叶结点
 @param depth 叶结点的深度
 */
-(void)fetchFileInfo:(FileNode*)node withDepth:(int)depth {
    
}
@end

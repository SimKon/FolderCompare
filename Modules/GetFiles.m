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
 !!外部需要retain!!
 @return Null：没有文件 NSArray：指定路径下的文件
 */
-(NSArray*)getSubFilesWithFolderName:(NSString*)folder andDepth:(int)depth error:(NSError**)error{
    NSArray* arrTemp = [self getSubFiles:folder NSError:error];
    NSMutableArray *arrNodes = [[NSMutableArray alloc] init];
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
    
    NSMutableArray* result = [NSMutableArray array];
    NSMutableArray *arrFolders = [NSMutableArray array];
    NSMutableArray *arrFiles = [NSMutableArray array];
    NSMutableArray *arrUnknows = [NSMutableArray array];
    
    for (int i = 0; i < arrNodes.count; i++) {
        FileNode *node = [arrNodes objectAtIndex:i];
        if (node.type == FT_FILE) {
            [arrFiles addObject:node];
        } else if (node.type == FT_FOLDER){
            [arrFolders addObject:node];
        } else { // 一般不会走到这个分支，保留是因为想在txt文件中查看哪些文件出了问题
            [arrUnknows addObject:node];
        }
    }
    
    // 排序顺序 不明文件 -> 文件夹 -> 文件
    [result addObjectsFromArray:[self sortChildrenByName:arrUnknows]];
    [result addObjectsFromArray:[self sortChildrenByName:arrFolders]];
    [result addObjectsFromArray:[self sortChildrenByName:arrFiles]];
    
    // Memroy Release
    [arrNodes release];
    
    return result;
}

/**
 递归,返回指定路径下的所有文件名
 !!外部需要retain!!
 depth 0:root文件夹 1:root文件夹下的文件 2:依次类推。作为对外接口调用的时候，应该设置为1，表示获取root文件夹下第一层文件的深度是1。
 @return Null：没有文件 NSArray：指定路径下的文件,由外部释放
 */
-(NSArray*)getAllSubFilesInFolder:(FileNode*)root error:(NSError**)error{
    if (root == nil || root.name == nil) {
        NSLog(@"%s param error",__FUNCTION__);
        return nil;
    }
    
    if (root.type == FT_FILE) {
        // root为文件
        return nil;
    }
    
    // 获取root下的所有文件
    NSArray *arrFiles = [[[self getSubFilesWithFolderName:root.fullPath andDepth:(root.depth+1) error:nil] retain] autorelease]; // retian是因为调用的函数返回值需要retian，然后autorelease是因为希望在这个函数外部其他人retian，这样对象的管理者就是外面的人。所以这边加上autorelease
    root.subFilesCount = arrFiles.count;
    
    // 遍历root下的文件，是文件夹就递归获取更深层的文件信息
    for (int i = 0; i < arrFiles.count; i++) {
        FileNode *node = [arrFiles objectAtIndex:i];
        if (node.type == FT_FOLDER) {
            //-- 子文件为文件夹 --//
            NSArray *arrChildren = [[self getAllSubFilesInFolder:node error:nil] retain];
            node.subFiles = arrChildren;
            node.subFilesCount = (unsigned short)arrChildren.count;
        } else {
            //-- 子文件为文件 --//
        }
    }
    return arrFiles;
}

-(NSArray*)sortChildrenByName:(NSArray*)children{
    if (children.count < 2) {
        return children;
    }
     // 利用block进行排序
    NSArray *sortedChildren = [children sortedArrayUsingComparator:
                               ^NSComparisonResult(FileNode *obj1, FileNode *obj2) {
                                   NSComparisonResult result = [obj1.name compare:obj2.name];
                                   return result;
                               }];
    return sortedChildren;
}
-(void)delResNode{}
-(void)dealloc{
    self.fileManager = nil;
    [super dealloc];
}
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

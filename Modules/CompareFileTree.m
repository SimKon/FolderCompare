//
//  CompareFileTree.m
//  FolderCompare
//
//  Created by shen_chao on 2017/12/2.
//  Copyright © 2017年 shen_chao. All rights reserved.
//

#import "CompareFileTree.h"
#import "CommonDefine.h"
#import "CommonFunc.h"
@implementation CompareFileTree
-(BOOL)compareTree:(FileNode*)treeA with:(FileNode*)treeB{
    BOOL isDiff = YES;
    // 自身私有变量设定
    _treeA = treeA;
    _treeB = treeB;
    
    // 遍历
    
    // 创建本地文件(用于存储对比结果)
    [self createLocalFile];
//    [self exportDiffNode:[treeA.subFiles objectAtIndex:0] existInTree:FC_TreeA];
    
    return isDiff;
}

-(void)exportDiffNode:(FileNode*)expNode existInTree:(FCTree)tree{
    @autoreleasepool{
        @try {
            NSString* bs = nil;
            NSString* nodeFullPath = [CommonFunc getFullPath:expNode];
            if (tree == FC_TreeA) {
                bs = [NSString stringWithFormat:@"%@,%@\n",nodeFullPath,@""];
            } else {
                bs = [NSString stringWithFormat:@"%@,%@\n",@"",nodeFullPath];
            }
            NSData *buffer = [bs dataUsingEncoding:NSUTF8StringEncoding];
            [_fileHandler seekToEndOfFile];
            [_fileHandler writeData:buffer];
        }
        @catch(...)
        {
            
        }
    }
}
// **************
// * _fileHandler &_fileHandler在这个函数中赋值
// **************
-(void)createLocalFile{
    @autoreleasepool{
        NSString* exportName = [DIFF_PREFIX_NAME stringByAppendingString:DIFF_SUFFIX_NAME];
        _exportPath =  [[[NSSearchPathForDirectoriesInDomains(NSDesktopDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:exportName] retain];
        
        _exportPath = [self getExpPathWithTmpPath:_exportPath withCount:0];
        
        NSLog(@"FilePath = %@",_exportPath);
        NSFileManager* fileManager = [NSFileManager defaultManager];
        // 在本地创建文件
        if (![fileManager createFileAtPath:_exportPath contents:nil attributes:nil]) {
            NSLog(@"Create File Failed");
            return;
        }
        
        _fileHandler = [[NSFileHandle fileHandleForWritingAtPath:_exportPath] retain];
        _treeB.name = @"111";
        NSString* str = [NSString stringWithFormat:@"%@,%@\n",_treeA.name,_treeB.name];
        NSData *buffer = [str dataUsingEncoding:NSUTF8StringEncoding];
        [_fileHandler writeData:buffer];
    }
}

-(NSString*)getExpPathWithTmpPath:(NSString*)tmpPath withCount:(int)fileCount{
    NSFileManager* fileManager = [NSFileManager defaultManager];
    NSString* resPath = nil;
    
#warning 方便测试注释掉的代码
//    if ([fileManager fileExistsAtPath:tmpPath isDirectory:nil]) {
//        fileCount++;
//        NSString* exportName = [[DIFF_PREFIX_NAME stringByAppendingString:[NSString stringWithFormat:@"-%d",fileCount]] stringByAppendingString:DIFF_SUFFIX_NAME];
//        resPath = [[NSSearchPathForDirectoriesInDomains(NSDesktopDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:exportName];
//        resPath = [self getExpPathWithTmpPath:resPath withCount:fileCount];
//    } else {
        resPath = tmpPath;
//    }
    return resPath;
}

-(void)dealloc {
    [_fileHandler closeFile];
    [_fileHandler release];
    [super dealloc];
}
@end

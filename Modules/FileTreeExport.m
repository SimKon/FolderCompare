//
//  FileTreeExport.m
//  FolderCompare
//
//  Created by shen_chao on 2017/12/1.
//  Copyright © 2017年 shen_chao. All rights reserved.
//

#import "FileTreeExport.h"
#import "CommonDefine.h"
@implementation FileTreeExport
-(instancetype)init{
    if (self = [super init]) {
        self.fileCount = 1;
    }
    return self;
}

-(void)exportTree:(FileNode*)tree{
    NSLog(@"FilePath = %@",self.exportPath);
    NSFileManager* fileManager = [NSFileManager defaultManager];
    // 在本地创建文件
    if (![fileManager createFileAtPath:self.exportPath contents:nil attributes:nil]) {
        NSLog(@"Create File Failed");
        return;
    }
    
    // 获取创建好的文件句柄
    NSFileHandle  *fileHandle = [NSFileHandle fileHandleForWritingAtPath:self.exportPath];
    if(fileHandle == nil)
    {
        NSLog(@"Open of file for writing failed");
        return;
    }
    
    //找到并定位到outFile的末尾位置(在此后追加文件),这一步只是异常防止，实际上由于是新建的文件，文件末尾和文件头是同一个地方
    [fileHandle seekToEndOfFile];
    
    NSString *bs = [NSString stringWithFormat:@"Root Folder = \"%@\"\n\n",tree.fullPath];
    NSData *buffer = [bs dataUsingEncoding:NSUTF8StringEncoding];
    [fileHandle writeData:buffer];
    
    [self exportNode:tree Handle:fileHandle];
    
    //关闭读写文件
    [fileHandle closeFile];
}

// eg: "|------ |------ |------ ippac.h"
-(void)exportNode:(FileNode*)fileNode Handle:(NSFileHandle*)handle{
    @autoreleasepool {
        if (fileNode.subFilesCount != 0) {
            // 1.文件夹本身的信息写入文件
            NSString* expString = [self getExportStringFrom:fileNode];
            if (expString == nil) {
                return;
            }
            [handle seekToEndOfFile];
            NSData *buffer = [expString dataUsingEncoding:NSUTF8StringEncoding];
            [handle writeData:buffer];
            // 2.文件夹下的文件信息递归写入文件
            NSArray* children = fileNode.subFiles;
            for (int i = 0; i < fileNode.subFilesCount; i++) {
                FileNode* node = [children objectAtIndex:i];
                [self exportNode:node Handle:handle];
            }
        } else {
            // 将文件信息写入文件
            NSString* expString = [self getExportStringFrom:fileNode];
            [handle seekToEndOfFile];
            NSData *buffer = [expString dataUsingEncoding:NSUTF8StringEncoding];
            [handle writeData:buffer];
        }
    }
}

// eg: "/Users/shen_chao/Desktop/300To200/IPP_dlib_MiniDriver/Inc/ippcv.h"
-(void)exportNode2:(FileNode*)fileNode Handle:(NSFileHandle*)handle{
    @autoreleasepool {
        if (fileNode.subFilesCount != 0) {
            // 1.文件夹本身的信息写入文件
            [handle seekToEndOfFile];
            NSData *buffer = [[fileNode.fullPath stringByAppendingString:@"\n"] dataUsingEncoding:NSUTF8StringEncoding];
            [handle writeData:buffer];
            // 2.文件夹下的文件信息递归写入文件
            NSArray* children = fileNode.subFiles;
            for (int i = 0; i < fileNode.subFilesCount; i++) {
                FileNode* node = [children objectAtIndex:i];
                [self exportNode2:node Handle:handle];
            }
        } else {
            // 将文件信息写入文件
            [handle seekToEndOfFile];
            NSData *buffer = [[fileNode.fullPath stringByAppendingString:@"\n"] dataUsingEncoding:NSUTF8StringEncoding];
            [handle writeData:buffer];
        }
    }
}

-(NSString*)getExpPathWithTmpPath:(NSString*)tmpPath{
    NSFileManager* fileManager = [NSFileManager defaultManager];
    NSString* resPath = nil;
    if ([fileManager fileExistsAtPath:tmpPath isDirectory:nil]) {
        self.fileCount++;
        NSString* exportName = [[EXPORT_PREFIX_NAME stringByAppendingString:[NSString stringWithFormat:@"-%d",self.fileCount]] stringByAppendingString:EXPORT_SUFFIX_NAME];
        resPath = [[NSSearchPathForDirectoriesInDomains(NSDesktopDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:exportName];
        resPath = [self getExpPathWithTmpPath:resPath];
    } else {
        resPath = tmpPath;
    }
    return resPath;
}

-(NSString*)getExportStringFrom:(FileNode*)fileNode{
    // 参数检查
    if (fileNode == nil || fileNode.name == nil) {
        return nil;
    }
    NSString* strExp = @"";
    for (int i = 0; i < fileNode.depth; i++) {
        strExp = [strExp stringByAppendingString:EXPORT_DEPTH_MARK];
    }
    strExp = [[strExp stringByAppendingString:fileNode.name] stringByAppendingString:@"\n"];
    return strExp;
}

-(void)dealloc{
    self.exportPath = nil;//会自动释放内存
    [super dealloc];
}
#pragma mark ================ Get Set =================
-(NSString*)exportPath{
    if (_exportPath == nil) {
        NSString* exportName = [EXPORT_PREFIX_NAME stringByAppendingString:EXPORT_SUFFIX_NAME];
        _exportPath =  [[[NSSearchPathForDirectoriesInDomains(NSDesktopDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:exportName] retain];
    }
#warning 为了测试方便，暂时关闭文件名自动叠加功能
//    _exportPath = [self getExpPathWithTmpPath:_exportPath];
    return _exportPath;
}
@end

//
//  FileNode.h
//  FolderCompare
//
//  Created by shen_chao on 2017/11/29.
//  Copyright © 2017年 shen_chao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonDefine.h"
#import "CommonFunc.h"
typedef enum _FileExtension {
    FE_UNKNOW= 0,
    //1~9 Picture
    FE_JPEG  = 1,
    FE_RAW  = 2,
    FE_TIFF = 3,
    //11~19 Movie
    FE_MP4 = 11,
    FE_RMVB = 12,
    //20~40 Document
    FE_PDF = 20,
    FE_DOC = 21,
    //99
    FE_NOEXTENSION = 99
} FileExtension;

typedef enum _FileType {
    FT_UNKNOW, // 初始化||文件不存在的情况
    FT_FOLDER = 1,
    FT_FILE = 2
} FileType;

@interface FileNode : NSObject
@property(assign,nonatomic) int             fileID;
@property(assign,nonatomic) int             extension;
@property(assign,nonatomic) NSString*       name; // 文件名
//@property(retain,nonatomic) NSString*       fullPath; // 文件全路径
@property(assign,nonatomic) int             type;
@property(assign,nonatomic) USHORT          subFilesCount;
@property(retain,nonatomic) NSArray*        subFiles;
@property(assign,nonatomic) int             depth;
@property(retain,nonatomic) FileNode*       father; // 这个指针指向的内容并非深复制过来的，释放时只要释放指针本身就可以了
/* 等待追加
 @property(assign,nonatomic) int         size;
 */
/*
 扩展：camera、filmingTime、etc
 */
- (instancetype)initWithBlankObject;
- (instancetype)initWithFullPath:(NSString*)filePath;
- (instancetype)initWithSimpleObject:(NSString*)filePath withDepth:(int)depth;

- (void)setBlank;
- (void)addChildren:(NSArray*)children;
- (void)releaseNode;
@end

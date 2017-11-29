//
//  FileNode.h
//  FolderCompare
//
//  Created by shen_chao on 2017/11/29.
//  Copyright © 2017年 shen_chao. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum _FileType {
    UNKNOWTYPE = 0,
    //1~9 Picture
    JPEG  = 1,
    RAW  = 2,
    TIFF = 3,
    //11~19 Movie
    MP4 = 11,
    RMVB = 12,
    //20+ Document
    PDF = 20,
    Doc = 21
} FileType;

@interface FileNode : NSObject
@property(assign,nonatomic) int         fileID;
@property(retain,nonatomic) NSString*   name;
@property(retain,nonatomic) NSString*   ownFolder;
@property(retain,nonatomic) NSString*   filePath;
@property(assign,nonatomic) int         type;
@property(assign,nonatomic) int         subFilesCount;
@property(retain,nonatomic) NSArray*    subFiles;
@property(assign,nonatomic) int         depth;
/*
 NSString*   prefixName;
 int         suffixName;
 NSString*   fullPath;
 扩展：camera、filmingTime、etc
 */

- (id)initWithBlankObject;
@end

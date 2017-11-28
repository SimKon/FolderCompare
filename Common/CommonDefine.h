//
//  CommonDefine.h
//  FolderCompare
//
//  Created by shen_chao on 2017/11/8.
//  Copyright © 2017年 shen_chao. All rights reserved.
//

#ifndef CommonDefine_h
#define CommonDefine_h
typedef struct {
    int         fileID;
    NSString*   name;
    NSString*   ownFolder;
    NSString*   filePath;
    int         type;
    int         subFilesCount;
    NSArray*    subFiles;
    int         depth;
    /*
    NSString*   prefixName;
    int         suffixName;
    NSString*   fullPath;
    扩展：camera、filmingTime、etc
     */
} FileNode;

typedef enum _FileType {
    UNKNOW = 0,
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

typedef enum _FCError {
    FC_NOERROR = 0,
    FC_ERR = 1
} FCError;

#endif /* CommonDefine_h */

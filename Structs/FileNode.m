//
//  FileNode.m
//  FolderCompare
//
//  Created by shen_chao on 2017/11/29.
//  Copyright © 2017年 shen_chao. All rights reserved.
//

#import "FileNode.h"
#import "CommonDefine.h"
@implementation FileNode
#pragma mark ==================== Init Functions ======================
// 返回初始化后的对象
- (instancetype)initWithBlankObject {
    if ( self = [super init] ) {
        self.fileID             = 0;
        self.name               = nil;
        self.fullPath           = nil;
        self.type               = FT_UNKNOW;
        self.extension          = FE_UNKNOW;
        self.subFilesCount      = 0;
        self.subFiles           = nil;
        self.depth              = -1;
    }
    return self;
}

// 含有详细信息
// !! 1.depth会被设置为0   2.效率比initWithSimpleObject慢15000多倍
- (instancetype)initWithFullPath:(NSString*)filePath {
    NSDictionary *attributes = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
    if (attributes == nil) {
        // 文件不存在的时候，返回空对象
        NSLog(@"Error File Not Exist");
        return [self initWithBlankObject];
    }
    if ( self = [super init] ) {
        self.fileID             = 0;
        self.name               = [filePath lastPathComponent];
        self.fullPath           = filePath;
        if ([[attributes valueForKey:NSFileType] isEqualToString:NSFileTypeDirectory]) {
            self.type           = FT_FOLDER;
        } else {
            self.type           = FT_FILE;
        }
        self.extension          = [self getFileExtension:filePath];
        self.subFilesCount      = 0;
        self.subFiles           = nil;
        self.depth              = 0;
    }
    return self;
}

// 含有从文件路径上能直接获取的信息 + 文件类型(Folder／File)
- (instancetype)initWithSimpleObject:(NSString*)filePath withDepth:(int)depth{
    FileType type = [self getFileType:filePath];
    if (type == FT_UNKNOW) {
        // 文件不存在的时候，返回空对象
        NSLog(@"Error File Not Exitst");
        return [self initWithBlankObject];
    }
    if ( self = [super init] ) {
        self.fileID             = 0;
        self.name               = [filePath lastPathComponent];
        self.fullPath           = filePath;
        self.extension          = [self getFileExtension:filePath];
        self.type               = type;
        self.subFilesCount      = 0;
        self.subFiles           = nil;
        self.depth              = depth;
    }
    return self;
}
#pragma mark ==================== Public Functions ======================
-(void)addChildren:(NSArray*)children{
    self.subFiles = children;
    self.subFilesCount = (unsigned short)children.count;
}

#pragma mark ==================== Other Functions ======================
-(FileExtension)getFileExtension:(NSString*)fileName{
    NSString* fileExtension = [[fileName pathExtension] uppercaseString];
    //99
    if (fileExtension == nil || [fileExtension isEqualToString:@""] ) {
        return FE_NOEXTENSION;
    }
    //1~9 Picture
    if ([fileExtension isEqualToString:@"JPG"] ||
        [fileExtension isEqualToString:@"JPEG"]) {
        return FE_JPEG;
    }
    if ([fileExtension isEqualToString:@"NEF"] || // Nikon
        [fileExtension isEqualToString:@"RAF"] || // Fujifilm
        [fileExtension isEqualToString:@"RW2"] || // Panasonic
        [fileExtension isEqualToString:@"CR2"] || // Canon
        [fileExtension isEqualToString:@"X3F"] || // Sigma
        [fileExtension isEqualToString:@"PEF"] || // Pentax
        [fileExtension isEqualToString:@"ARW"] || // Sony
        [fileExtension isEqualToString:@"ORF"] || // Olympus
        [fileExtension isEqualToString:@"DNG"] || // Lecia&Ricoh
        [fileExtension isEqualToString:@"RAW"]) {
        return FE_RAW;
    }
    if ([fileExtension isEqualToString:@"TIFF"] ) {
        return FE_TIFF;
    }
    //11~19 Movie
    if ([fileExtension isEqualToString:@"MP4"] ) {
        return FE_MP4;
    }
    if ([fileExtension isEqualToString:@"RMVB"] ) {
        return FE_RMVB;
    }
    //20~40 Document
    if ([fileExtension isEqualToString:@"DOC"] ) {
        return FE_DOC;
    }
    if ([fileExtension isEqualToString:@"PDF"] ) {
        return FE_PDF;
    }
    return FE_UNKNOW;
}

-(FileType)getFileType:(NSString*)fullPath{
    BOOL isDirectory = NO;
    BOOL isExist = [self.fileManager fileExistsAtPath:fullPath isDirectory:&isDirectory];
    if (isExist) {
        if (isDirectory) {
            return FT_FOLDER;
        } else {
            return FT_FILE;
        }
    } else {
        return FT_UNKNOW;
    }
}
-(void)dealloc{
    self.subFiles = nil;
    self.name = nil;
    self.fullPath = nil;
    self.fileManager = nil;
    
    [super dealloc];
}
#pragma mark ================ Get Set =================
- (NSFileManager*)fileManager{
    if (_fileManager == nil) {
        _fileManager = [NSFileManager defaultManager];
    }
    return _fileManager;
}
@end

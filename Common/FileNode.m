//
//  FileNode.m
//  FolderCompare
//
//  Created by shen_chao on 2017/11/29.
//  Copyright © 2017年 shen_chao. All rights reserved.
//

#import "FileNode.h"

@implementation FileNode
#pragma mark ==================== Init Functions ======================
// 返回初始化后的对象
- (id)initWithBlankObject {
    if ( self = [super init] ) {
        self.fileID             = 0;
        self.name               = nil;
        self.ownFolder          = nil;
        self.filePath           = nil;
        self.type               = UNKNOWTYPE;
        self.subFilesCount      = 0;
        self.subFiles           = nil;
        self.depth              = 0;
    }
    return self;
}

- (id)initWithFileName:(NSString*)fileName {
    if ( self = [super init] ) {
        // 获取详细的信息
    }
    return self;
}

// 返回只含有文件名和文件类型的对象
- (id)initWithSimpleObject:(NSString*)fileName with:(int)depth{
    if ( self = [super init] ) {
        self.fileID             = 0;
        self.name               = fileName;
        self.ownFolder          = nil;
        self.filePath           = nil;
        self.type               = [self getFileType:fileName];
        self.subFilesCount      = 0;
        self.subFiles           = nil;
        self.depth              = depth;
    }
    return self;
}

#pragma mark ==================== Other Functions ======================
-(FileType)getFileType:(NSString*)fileName{
    NSString* fileExtension = [[fileName pathExtension] uppercaseString];
    //1~9 Picture
    if ([fileExtension isEqualToString:@"JPG"] ||
        [fileExtension isEqualToString:@"JPEG"]) {
        return JPEG;
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
        return RAW;
    }
    if ([fileExtension isEqualToString:@"TIFF"] ) {
        return TIFF;
    }
    //11~19 Movie
    if ([fileExtension isEqualToString:@"MP4"] ) {
        return MP4;
    }
    if ([fileExtension isEqualToString:@"RMVB"] ) {
        return RMVB;
    }
    //20+ Document
    if ([fileExtension isEqualToString:@"DOC"] ) {
        return Doc;
    }
    if ([fileExtension isEqualToString:@"PDF"] ) {
        return PDF;
    }
    return UNKNOWTYPE;
}
@end

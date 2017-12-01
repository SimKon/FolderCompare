//
//  FileTreeExport.m
//  FolderCompare
//
//  Created by shen_chao on 2017/12/1.
//  Copyright © 2017年 shen_chao. All rights reserved.
//

#import "FileTreeExport.h"

@implementation FileTreeExport
-(instancetype)init{
    if (self = [super init]) {
    }
    return self;
}

-(void)exportTree:(FileNode*)tree{
    NSFileManager* fileManager = [NSFileManager defaultManager];
    BOOL isDirectory = NO;
    [fileManager fileExistsAtPath:self.exportPath isDirectory:&isDirectory];
    // TODO
}

-(NSString*)exportPath{
    if (_exportPath == nil) {
        _exportPath =  [[NSSearchPathForDirectoriesInDomains(NSDesktopDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"FCResult.txt"];
    }
    return _exportPath;
}
@end

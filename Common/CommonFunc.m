//
//  CommonFunc.m
//  FolderCompare
//
//  Created by shen_chao on 2017/11/8.
//  Copyright © 2017年 shen_chao. All rights reserved.
//

#import "CommonFunc.h"
#import "CommonDefine.h"
#import "FileNode.h"
@implementation CommonFunc

NSString* Separator = @"/";
+ (NSString*)getFullPath:(FileNode*)node{
    NSString* fullPath = nil;
    if (node.father != nil) {
        fullPath = [self composePath:node.name WithNode:node.father];
    } else {
        fullPath = [Separator stringByAppendingPathComponent:node.name];
    }
    return fullPath;
}

#pragma mark ====================== Private ========================
// ..(father.name)../node.name/path
+ (NSString*)composePath:(NSString*)suffixPath WithNode:(FileNode*)node {
    suffixPath = [node.name stringByAppendingPathComponent:suffixPath];
    if (node.father != nil) {
        suffixPath = [self composePath:suffixPath WithNode:node.father];
    }
    return suffixPath;
}
@end

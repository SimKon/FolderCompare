//
//  CompareFileTree.h
//  FolderCompare
//
//  Created by shen_chao on 2017/12/2.
//  Copyright © 2017年 shen_chao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FileNode.h"
@interface CompareFileTree : NSObject {
    NSString *_exportPath;
    NSFileHandle *_fileHandler;
    FileNode *_treeA;
    FileNode *_treeB;
}
-(BOOL)compareTree:(FileNode*)treeA with:(FileNode*)treeB;
@end

//
//  FileTreeExport.h
//  FolderCompare
//
//  Created by shen_chao on 2017/12/1.
//  Copyright © 2017年 shen_chao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FileNode.h"
@interface FileTreeExport : NSObject
@property(nonatomic,retain) NSString* exportPath;

-(instancetype)init;
-(void)exportTree:(FileNode*)tree;
@end

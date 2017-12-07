//
//  CommonFunc.h
//  FolderCompare
//
//  Created by shen_chao on 2017/11/8.
//  Copyright © 2017年 shen_chao. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FileNode;
#warning 由Node release引发的NSString的释放问题
#warning 重新选择目录时候的内存释放和置空问题---》置空问题和error处理有关
@interface CommonFunc : NSObject
+(NSString*) getFullPath:(FileNode*)node;
@end

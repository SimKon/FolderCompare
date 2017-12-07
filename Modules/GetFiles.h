//
//  GetFiles.h
//  FolderCompare
//
//  Created by shen_chao on 2017/11/8.
//  Copyright © 2017年 shen_chao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FileNode.h"
@interface GetFiles : NSObject
@property(nonatomic,retain) NSFileManager* fileManager;
-(NSArray*)getAllSubFilesInFolder:(FileNode*)root PrefixPath:(NSString*)prePath error:(NSError**)error;

//-(NSArray*)getSubFiles:(NSString*)folder NSError:(NSError**)error;
//-(NSArray*)getAllSubFiles:(NSString*)folder NSError:(NSError**)error;
@end

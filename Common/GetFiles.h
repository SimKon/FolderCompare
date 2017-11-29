//
//  GetFiles.h
//  FolderCompare
//
//  Created by shen_chao on 2017/11/8.
//  Copyright © 2017年 shen_chao. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface GetFiles : NSObject
-(NSArray*)getSubFilesInFolder:(NSString*)folder WithDepth:(int)depth NSError:(NSError**)error;
-(NSArray*)getAllSubFilesInFolder:(FileNode*)root NSError:(NSError**)error;

//-(NSArray*)getSubFiles:(NSString*)folder NSError:(NSError**)error;
//-(NSArray*)getAllSubFiles:(NSString*)folder NSError:(NSError**)error;
@end

//
//  ViewController.m
//  FolderCompare
//
//  Created by shen_chao on 2017/11/8.
//  Copyright © 2017年 shen_chao. All rights reserved.
//

#import "ViewController.h"
#import "CommonFunc.h"
#import "GetFiles.h"
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString* path = @"/Users/shen_chao/Desktop/300To2001";//此节点设为根节点
//    [GetFiles getSubFiles:&array InFolder:path];
    FileNode *node = [[FileNode alloc] initWithFullPath:path];
    GetFiles* files = [GetFiles new];
    NSArray* arrFiles = [files getAllSubFilesInFolder:node error:nil];
    [node addChildren:arrFiles];
    NSLog(@"111");
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end

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
#import "FileTreeExport.h"
@implementation ViewController
- (void)viewWillAppear{
    [self.viewA.layer setBackgroundColor:[NSColor redColor].CGColor];
    [self.viewB.layer setBackgroundColor:[NSColor whiteColor].CGColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewA.wantsLayer = YES;
    self.viewB.wantsLayer = YES;
    NSString* path = @"/Users/shen_chao/Desktop/300To2001";//此节点设为根节点
    FileNode *node = [[FileNode alloc] initWithFullPath:path];
    GetFiles* files = [GetFiles new];
    NSArray* arrFiles = [[files getAllSubFilesInFolder:node error:nil] retain];
    [node addChildren:arrFiles];
    FileTreeExport *export = [[[FileTreeExport alloc] init] autorelease];
    [export exportTree:node];
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end

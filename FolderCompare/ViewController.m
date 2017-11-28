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
    NSString* path = @"/Users/shen_chao/Desktop/300To200";//此节点设为根节点
//    [GetFiles getSubFiles:&array InFolder:path];
    NSError *error = NULL;
    GetFiles *getFiles = [GetFiles new];
    NSArray* files = [[getFiles getSubFilesInFolder:path NSError:&error] retain];
    [getFiles release];
    NSLog(@"111");
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end

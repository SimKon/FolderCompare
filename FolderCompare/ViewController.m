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
    // ViewA and SubViews
    self.viewA.layer.backgroundColor = [NSColor whiteColor].CGColor;
    self.viewA.layer.borderWidth = 4;
    self.viewA.layer.borderColor = [NSColor blueColor].CGColor;
    self.txfPathA.layer.borderWidth = 2;
    self.txfPathA.layer.borderColor = [NSColor colorWithRed:0 green:0.75 blue:1 alpha:0.7].CGColor;
    // ViewB and SubViews
    self.viewB.layer.backgroundColor = [NSColor whiteColor].CGColor;
    self.viewB.layer.borderWidth = 4;
    self.viewB.layer.borderColor = [NSColor blueColor].CGColor;
    self.txfPathB.layer.borderWidth = 2;
    self.txfPathB.layer.borderColor = [NSColor colorWithRed:0 green:0.75 blue:1 alpha:0.7].CGColor;

    // Compare Button
    [[self.btnCompare cell] setImageScaling:NSImageScaleAxesIndependently];
    self.btnCompare.cell.bordered = YES;
    self.btnCompare.layer.borderWidth = 4;
    self.btnCompare.layer.borderColor = [NSColor blueColor].CGColor;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.treeA = nil;
    self.treeB = nil;
    
    NSString* path = @"/Users/shen_chao/Desktop/300To2001";//此节点设为根节点
    FileNode *node = [[FileNode alloc] initWithFullPath:path];
    GetFiles* files = [GetFiles new];
    NSArray* arrFiles = [[files getAllSubFilesInFolder:node error:nil] retain];
    [node addChildren:arrFiles];
    FileTreeExport *export = [[[FileTreeExport alloc] init] autorelease];
    [export exportTree:node];
}

#pragma mark ================ Button Click =================
- (IBAction)clickSelectA:(id)sender {
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    panel.canChooseDirectories = YES;
    panel.canChooseFiles = NO;
    panel.allowsMultipleSelection = NO;
#warning TODO 如果重新选择路径，则原来的node中的内容需要释放
    [panel beginSheetModalForWindow:self.view.window completionHandler:^(NSModalResponse result) {
        if (result == NSModalResponseOK) {
            // 获取和设定画面上的路径
            NSString* pathA = [[[panel URLs] objectAtIndex:0] path];
            self.txfPathA.stringValue = pathA;
        }
    }];
}
- (IBAction)clickExportA:(id)sender {
    // 获取根节点的FileNode对象
    self.treeA = [[FileNode alloc] initWithFullPath:self.txfPathA.stringValue];
    // 获取所有子节点
    GetFiles* files = [[GetFiles new] autorelease];
    NSArray* arrFiles = [[files getAllSubFilesInFolder:self.treeA error:nil] retain];
    // 在根节点上添加子节点
    [self.treeA addChildren:arrFiles];
    
    // 生成txt文件
    FileTreeExport *export = [[FileTreeExport new] autorelease];
    [export exportTree:self.treeA];
}

- (IBAction)clickSelectB:(id)sender {
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    panel.canChooseDirectories = YES;
    panel.canChooseFiles = NO;
    panel.allowsMultipleSelection = NO;
#warning TODO 如果重新选择路径，则原来的node中的内容需要释放
    [panel beginSheetModalForWindow:self.view.window completionHandler:^(NSModalResponse result) {
        if (result == NSModalResponseOK) {
            // 获取和设定画面上的路径
            NSString* pathB = [[[panel URLs] objectAtIndex:0] path];
            self.txfPathB.stringValue = pathB;
        }
    }];
}
- (IBAction)clickExportB:(id)sender {
    // 获取根节点的FileNode对象
    self.treeB = [[FileNode alloc] initWithFullPath:self.txfPathB.stringValue];
    // 获取所有子节点
    GetFiles* files = [[GetFiles new] autorelease];
    NSArray* arrFiles = [[files getAllSubFilesInFolder:self.treeB error:nil] retain];
    // 在根节点上添加子节点
    [self.treeB addChildren:arrFiles];
    
    // 生成txt文件
    FileTreeExport *export = [[FileTreeExport new] autorelease];
    [export exportTree:self.treeB];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end

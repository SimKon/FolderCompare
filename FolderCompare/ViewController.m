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

static NSString* prefixPathA = nil;
static NSString* prefixPathB = nil;
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
    self.txfPathA.stringValue = @"/Users/shen_chao/Desktop/300To2001";
}

#pragma mark ================ Button Click =================
- (IBAction)clickSelectA:(id)sender {
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    panel.canChooseDirectories = YES;
    panel.canChooseFiles = NO;
    panel.allowsMultipleSelection = NO;
    
    [panel beginSheetModalForWindow:self.view.window completionHandler:^(NSModalResponse result) {
        if (result == NSModalResponseOK) {
            // 获取和设定画面上的路径
            NSString* pathA = [[[panel URLs] objectAtIndex:0] path];
            // 选择路径变更
            if (![self.txfPathA.stringValue isEqualToString:pathA]) {
                self.txfPathA.stringValue = pathA;
                [self.treeA releaseNode];
                [self.treeA setBlank];
            }
        }
    }];
}
- (IBAction)clickExportA:(id)sender {
    NSString* pathA = self.txfPathA.stringValue;
    dispatch_queue_t queue = dispatch_queue_create("ExportTreeA", DISPATCH_QUEUE_PRIORITY_DEFAULT);
    dispatch_async(queue,^{
        // 获取根节点的FileNode对象
        self.treeA = [[FileNode alloc] initWithFullPath:pathA];
        // 获取所有子节点
        GetFiles* files = [[GetFiles new] autorelease];
        NSArray* arrFiles = [files getAllSubFilesInFolder:self.treeA PrefixPath:[pathA stringByDeletingLastPathComponent] error:nil];
        // 在根节点上添加子节点
        [self.treeA addChildren:arrFiles];
        
        // 静态变量记录根节点在硬盘上的路径
        prefixPathA = [pathA stringByDeletingLastPathComponent];
        
        // 生成txt文件
        FileTreeExport *export = [[FileTreeExport new] autorelease];
        [export exportTree:self.treeA];
        
        // 画面恢复响应
        dispatch_queue_t mainQueue = dispatch_get_main_queue();
        dispatch_sync(mainQueue, ^{
            self.btnSelectA.enabled = YES;
            self.btnExportA.enabled = YES;
            self.txfPathA.editable = YES;
        });
    });
    
    // 画面设置不响应
    self.btnSelectA.enabled = NO;
    self.btnExportA.enabled = NO;
    self.txfPathA.editable = NO;
}

- (IBAction)clickSelectB:(id)sender {
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    panel.canChooseDirectories = YES;
    panel.canChooseFiles = NO;
    panel.allowsMultipleSelection = NO;

    [panel beginSheetModalForWindow:self.view.window completionHandler:^(NSModalResponse result) {
        if (result == NSModalResponseOK) {
            // 获取和设定画面上的路径
            NSString* pathB = [[[panel URLs] objectAtIndex:0] path];
            self.txfPathB.stringValue = pathB;
            // 选择路径变更
            if (![self.txfPathB.stringValue isEqualToString:pathB]) {
                self.txfPathB.stringValue = pathB;
                [self.treeB releaseNode];
                [self.treeB setBlank];
            }
        }
    }];
}
- (IBAction)clickExportB:(id)sender {
    NSString *pathB = self.txfPathB.stringValue;
    dispatch_queue_t queue = dispatch_queue_create("ExportTreeB", DISPATCH_QUEUE_PRIORITY_DEFAULT);
    dispatch_async(queue,^{
        // 获取根节点的FileNode对象
        self.treeB = [[FileNode alloc] initWithFullPath:pathB];
        // 获取所有子节点
        GetFiles* files = [[[GetFiles alloc] init] autorelease];
        NSArray* arrFiles = [files getAllSubFilesInFolder:self.treeB PrefixPath:[pathB stringByDeletingLastPathComponent] error:nil];
        // 在根节点上添加子节点
        [self.treeB addChildren:arrFiles];
        
        // 静态变量记录根节点在硬盘上的路径
        prefixPathB = [pathB stringByDeletingLastPathComponent];
        
        // 生成txt文件
        FileTreeExport *export = [[FileTreeExport new] autorelease];
        [export exportTree:self.treeB];
        
        // 画面恢复响应
        dispatch_queue_t mainQueue = dispatch_get_main_queue();
        dispatch_sync(mainQueue, ^{
            self.btnSelectB.enabled = YES;
            self.btnExportB.enabled = YES;
            self.txfPathB.editable = YES;
        });
    });
    
    // 画面设置不响应
    self.btnSelectB.enabled = NO;
    self.btnExportB.enabled = NO;
    self.txfPathB.editable = NO;
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (void)dealloc{
    [self.treeA releaseNode];
    self.treeA = nil;
    [self.treeB releaseNode];
    self.treeB = nil;
    
    [super dealloc];
}
@end

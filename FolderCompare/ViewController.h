//
//  ViewController.h
//  FolderCompare
//
//  Created by shen_chao on 2017/11/8.
//  Copyright © 2017年 shen_chao. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "FileNode.h"
@interface ViewController : NSViewController

@property (assign) IBOutlet NSView *viewA;
@property (assign) IBOutlet NSView *viewB;
@property (assign) IBOutlet NSButton *btnSelectA;
@property (assign) IBOutlet NSButton *btnSelectB;
@property (assign) IBOutlet NSButton *btnExportA;
@property (assign) IBOutlet NSButton *btnExportB;
@property (assign) IBOutlet NSButton *btnCompare;
@property (assign) IBOutlet NSTextField *txfPathA;
@property (assign) IBOutlet NSTextField *txfPathB;

@property (retain,nonatomic) FileNode* treeA;
@property (retain,nonatomic) FileNode* treeB;

@end


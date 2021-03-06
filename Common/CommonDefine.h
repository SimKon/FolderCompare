//
//  CommonDefine.h
//  FolderCompare
//
//  Created by shen_chao on 2017/11/8.
//  Copyright © 2017年 shen_chao. All rights reserved.
//

#ifndef CommonDefine_h
#define CommonDefine_h
typedef enum _FCError {
    FC_NOERROR = 0,
    FC_ERR = 1
} FCError;

typedef enum _FCTree {
    FC_TreeA = 0,
    FC_TreeB = 1
} FCTree;

#define NSObjectReleaseToNil(a) \
do {                            \
if (a != nil) {             \
[a release];            \
a = nil;                \
}                           \
} while(false)

#define USHORT  unsigned short
#define WCHAR   wchar_t*

#define EXPORT_PREFIX_NAME @"FCResult"
#define EXPORT_SUFFIX_NAME @".txt"
#define EXPORT_DEPTH_MARK  @"|------ "
#define DIFF_PREFIX_NAME @"DiffResult"
#define DIFF_SUFFIX_NAME @".csv"

// ----------- Skip Files -------------
//#define SKIP_DS_Store = @".DS_Store"
#define SKIP_FILES [NSArray arrayWithObjects:@".DS_Store", nil]
#endif /* CommonDefine_h */

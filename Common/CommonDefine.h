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

// ----------- Skip Files -------------
//#define SKIP_DS_Store = @".DS_Store"
#define SKIP_FILES [NSArray arrayWithObjects:@".DS_Store", nil]
#endif /* CommonDefine_h */

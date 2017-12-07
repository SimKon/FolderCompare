//
//  Description.h
//  FolderCompare
//
//  Created by shen_chao on 2017/12/6.
//  Copyright © 2017年 shen_chao. All rights reserved.
//

#ifndef Description_h
#define Description_h
/****************************/
/* 此文件仅作功能的设计式样书使用 */
/****************************/

/***** 递归获取文件 *****/
//1.选中某个文件夹
//2.获取这个文件夹下的所有子文件（子文件还有过滤特定文件的处理）
//3.遍历每个子文件，如果是文件夹，递归

/***** 核心函数说明 *****/
//getAllSubFilesInFolder：递归获取文件夹下的所有文件（getSubFilesWithFolderName）,如果是文件夹的话调用自己递归获取获取子文件夹下的所有文件（getAllSubFilesInFolder）
//getSubFilesWithFolderName：仅仅是获取文件夹下的文件(一层)，获取的文件按“不明文件->文件夹->文件”的顺序作排序

/***** 递归中文件路径问题 *****/
#endif /* Description_h */

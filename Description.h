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
//prefixPathA and prefixPathB save the prefix Path of the root Folder(selected Folder)
//In the object of FileNode, only save the FileName. So if you want to get a node's full Path, you shoud call "getFullPath" function.
//当递归文件夹获取子文件的时候，路径的获取方法是当层路径的拼上子文件名。

/***** FileNode initWithSimpleObject 文件不存在的情况*****/
// 一般来说，使用OC函数取出来的文件夹下的所有文件名，然后对每个文件进行是否存在的判断的时候是不会报这个错的
// 但是以下情况会报出来：
// 文件为硬盘上某个文件的替身，而这个替身的原身已经被删除了。

/***** Bug *****/
//1. 选中路径以后，先点compare，分析一遍。然后再点一次export，又会分析一遍。修改方法是设置一个判断该根文件夹是否被分析过的标签。如果路径没变并且已经被分析过了，那么直接用内存中的。
//2. 点击export分析文件夹的时候，画面上还能乱点。
//3. 点击compare的时候，viewA和ViewB都不能响应点击事件
#endif /* Description_h */

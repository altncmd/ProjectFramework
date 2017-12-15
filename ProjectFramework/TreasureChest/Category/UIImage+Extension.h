//
//  UIImage+Extension.h
//  ProjectFramework
//
//  Created by Elroy on 23/03/2017.
//  Copyright © 2017 钟世明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)
/** 根据图片名自动加载适配iOS 6/7的图片 */
+ (UIImage *)imageWithName:(NSString *)name;
/** 根据图片名，返回一张能够自由拉伸的图片 */
+ (UIImage *)resizedImage:(NSString *)name;
/**
 *  创建只有一个像素点的透明图片
 *
 *  @return 透明图片的Image对象
 */
+ (instancetype)transparentImage;


/**
 *  创建指定大小的透明图片
 *
 *  @param size 透明图片的尺寸
 *
 *  @return 透明图片的Image对象
 */
+ (instancetype)transparentImageWithSize:(CGSize)size;

@end

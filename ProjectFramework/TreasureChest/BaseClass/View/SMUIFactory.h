//
//  SMUIFactory.h
//  ProjectFramework
//
//  Created by Elroy on 12/16/17.
//  Copyright © 2017 钟世明. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SMUIFactory : NSObject

/**
 Create an UIButton object

 @param title Title
 @param size Title size
 @param color Title color
 @return UIButton object
 */
+ (UIButton *)buttonWithTitle:(NSString *)title titleFontSize:(CGFloat)size titleColor:(UIColor *)color;

/**
 Create an UILabel object

 @param text Text
 @param size Text size
 @param color Text Color
 @param alignment Text alignment
 @return UILabel object
 */
+ (UILabel *)labelWithText:(NSString *)text textFontSize:(CGFloat)size textColor:(UIColor *)color textAlignment:(NSTextAlignment)alignment;

@end

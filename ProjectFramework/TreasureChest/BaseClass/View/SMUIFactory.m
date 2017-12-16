//
//  SMUIFactory.m
//  ProjectFramework
//
//  Created by Elroy on 12/16/17.
//  Copyright © 2017 钟世明. All rights reserved.
//

#import "SMUIFactory.h"

@implementation SMUIFactory

+ (UIButton *)buttonWithTitle:(NSString *)title titleFontSize:(CGFloat)size titleColor:(UIColor *)color {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor clearColor];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:size];
    return btn;
}

+ (UILabel *)labelWithText:(NSString *)text textFontSize:(CGFloat)size textColor:(UIColor *)color textAlignment:(NSTextAlignment)alignment {
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.textAlignment = alignment;
    label.font = [UIFont systemFontOfSize:size];
    label.textColor = color;
    return label;
}

@end

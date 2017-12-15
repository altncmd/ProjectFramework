//
//  SMAlertView.m
//  ProjectFramework
//
//  Created by Elroy on 10/13/17.
//  Copyright © 2017 钟世明. All rights reserved.
//

#import "SMAlertView.h"

@implementation SMAlertView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = RGBColor(0, 0, 0, 0.5);
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        self.userInteractionEnabled = YES;
        [self addTarget:self action:@selector(removeSelfFromSuperView) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGBColor(0, 0, 0, 0.5);
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        self.userInteractionEnabled = YES;
        [self addTarget:self action:@selector(removeSelfFromSuperView) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

#pragma mark - Auxiliary method
- (void)removeSelfFromSuperView {
    [self removeFromSuperview];
}

@end

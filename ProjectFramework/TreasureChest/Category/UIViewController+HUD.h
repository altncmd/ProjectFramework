//
//  UIViewController+HUD.h
//  ProjectFramework
//
//  Created by Elroy on 9/14/17.
//  Copyright © 2017 钟世明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (HUD)
/** HUD */
@property (nonatomic, weak, readonly) MBProgressHUD *HUD;
/**
 *  提示信息
 *
 *  @param view 显示在哪个view
 *  @param hint 提示
 */
- (void)showHudInView:(UIView *)view hint:(NSString *)hint;
- (void)showHudInView:(UIView *)view hint:(NSString *)hint yOffset:(float)yOffset;
/**
 *  隐藏
 */
- (void)hideHud;

/**
 *  提示信息 mode:MBProgressHUDModeText
 *
 *  @param hint 提示
 */
- (void)showHint:(NSString *)hint;
- (void)showHint:(NSString *)hint inView:(UIView *)view;

// 从默认(showHint:)显示的位置再往上(下)yOffset
- (void)showHint:(NSString *)hint yOffset:(float)yOffset;

- (void)showLoadingIndicator;


@end

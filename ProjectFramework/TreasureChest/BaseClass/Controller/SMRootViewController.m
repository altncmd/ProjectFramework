//
//  SMRootViewController.m
//  ProjectFramework
//
//  Created by Elroy on 12/13/17.
//  Copyright © 2017 钟世明. All rights reserved.
//

#import "SMRootViewController.h"
#import "SMBaseTabBarController.h"
#import "SMLaunchViewController.h"

@interface SMRootViewController ()
@property (nonatomic, strong) SMLaunchViewController *launchViewController;
@property (nonatomic, strong) SMBaseTabBarController *rootViewController;
@end

@implementation SMRootViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 1.加载引导页
    [self sm_addChildViewController:self.launchViewController];
    
    // 2.数秒后跳转到首页
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView beginAnimations:@"animation" context:nil];
        [UIView setAnimationDuration:0];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.view cache:NO];
        [self sm_removeChildViewController:self.launchViewController];
        [self sm_addChildViewController:self.rootViewController];
        [UIView commitAnimations];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)sm_addChildViewController:(UIViewController *)viewController {
    [self addChildViewController:viewController];
    [self.view addSubview:viewController.view];
    [viewController didMoveToParentViewController:self];
    // 设置要添加的viewController的frame跟self.view的frame一样大
    viewController.view.frame = self.view.frame;
}

- (void)sm_removeChildViewController:(UIViewController *)viewController {
    [viewController.view removeFromSuperview];
    [viewController willMoveToParentViewController:nil];
    [viewController removeFromParentViewController];
}




- (SMLaunchViewController *)launchViewController {
    if (!_launchViewController) {
        _launchViewController = [[SMLaunchViewController alloc] init];
    }
    return _launchViewController;
}

- (SMBaseTabBarController *)rootViewController {
    if (!_rootViewController) {
        _rootViewController = [[SMBaseTabBarController alloc] init];
    }
    return _rootViewController;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

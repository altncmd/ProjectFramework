//
//  SMBaseNavigationViewController.m
//  ProjectFramework
//
//  Created by Elroy on 10/31/17.
//  Copyright © 2017 钟世明. All rights reserved.
//

#import "SMBaseNavigationController.h"

@interface SMBaseNavigationController ()

@end

@implementation SMBaseNavigationController

+ (void)initialize
{
    /* 这个不能删，为正确设置
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBackgroundImage:[UIImage imageNamed:@"head"] forBarMetrics:UIBarMetricsDefault];
    [bar setTitleTextAttributes:@{NSForegroundColorAttributeName : HexColor(@"333333")}];
    [bar setShadowImage:[[UIImage alloc] init]];
     */
    
    UINavigationBar *bar = [UINavigationBar appearance];
    NSString *imageName = kScreenHeight == 812 ? @"nav_bar_Bg_for_iPhoneX" : @"nav_bar_Bg";
    UIImage *image = [UIImage resizedImage:imageName];
    [bar setBackgroundImage:image forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
    [bar setShadowImage:[[UIImage alloc] init]];
    [bar setTitleTextAttributes:@{NSForegroundColorAttributeName : HexColor(@"333333")}];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count) { // 隐藏TabBar
        viewController.hidesBottomBarWhenPushed = YES;
        
        // 自定义返回按钮
        UIButton *btn = [[UIButton alloc] init];
        [btn setImage:[UIImage imageNamed:@"back_28"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(0, 0, 44, 44);
//        [btn sizeToFit];
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, -35, 0, 0);
//        btn.backgroundColor = [UIColor redColor];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        
        // 如果自定义返回按钮后, 滑动返回可能失效, 需要添加下面的代码
        __weak typeof(viewController)Weakself = viewController;
        self.interactivePopGestureRecognizer.delegate = (id)Weakself;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    // 判断两种情况: push 和 present
    if ((self.presentedViewController || self.presentingViewController) && self.childViewControllers.count == 1) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else
        [self popViewControllerAnimated:YES];
}


















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

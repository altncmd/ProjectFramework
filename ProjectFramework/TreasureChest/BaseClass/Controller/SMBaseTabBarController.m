//
//  SMBaseTabBarViewController.m
//  ProjectFramework
//
//  Created by Elroy on 10/31/17.
//  Copyright © 2017 钟世明. All rights reserved.
//

#import "SMBaseTabBarController.h"
#import "SMBaseNavigationController.h"

@interface SMBaseTabBarController ()

@end

@implementation SMBaseTabBarController

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"pages" ofType:@"plist"];
        NSArray *objs = [NSArray arrayWithContentsOfFile:path];
        for (int i = 0; i < objs.count; i ++) {
            UIViewController *vc = [[NSClassFromString(objs[i][@"className"]) alloc] init];
            SMBaseNavigationController *nav = [[SMBaseNavigationController alloc] initWithRootViewController:vc];
            vc.navigationItem.title = objs[i][@"navigationItemTitle"];
            vc.tabBarItem.title = objs[i][@"tabBarItemTitle"];
            vc.tabBarItem.image = [[UIImage imageNamed:objs[i][@"tabBarItemNormalImageName"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            vc.tabBarItem.selectedImage = [[UIImage imageNamed:objs[i][@"tabBarItemSelectedImageName"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            
            // 设置图片居中, 这儿需要注意top和bottom必须绝对值一样大
//            vc.tabBarItem.imageInsets = UIEdgeInsetsMake(4, 0, -4, 0);
            [self addChildViewController:nav];
            
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
    
    NSString *imageName = kScreenHeight == 812 ? @"tab_bar_Bg_for_iPhoneX" : @"tab_bar_Bg";
    UIImage *image = [UIImage resizedImage:imageName];
    [[UITabBar appearance] setBackgroundImage:image];
    [UITabBar appearance].clipsToBounds = YES;
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    return YES;
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

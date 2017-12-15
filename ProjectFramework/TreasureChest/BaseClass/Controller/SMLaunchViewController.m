//
//  SMLaunchViewController.m
//  ProjectFramework
//
//  Created by Elroy on 12/13/17.
//  Copyright © 2017 钟世明. All rights reserved.
//

#import "SMLaunchViewController.h"

@interface SMLaunchViewController ()

@end

@implementation SMLaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView *launchImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    NSString *imageName = IS_IPHONEX ? @"launch_for_iphonex" : @"launch";
    launchImageView.image = kImage(imageName);
    [self.view addSubview:launchImageView];
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

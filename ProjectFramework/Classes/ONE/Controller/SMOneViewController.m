//
//  SMOneViewController.m
//  ProjectFramework
//
//  Created by Elroy on 12/15/17.
//  Copyright © 2017 钟世明. All rights reserved.
//

#import "SMOneViewController.h"
#import "SMTestViewController.h"

@interface SMOneViewController ()

@end

@implementation SMOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor blueColor];
    button.center = self.view.center;
    [button setTitle:@"TEST" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
        make.width.height.equalTo(@100);
    }];
    [self.view layoutIfNeeded];
}

- (void)test {
    SMTestViewController *test = [[SMTestViewController alloc] init];
    [self.navigationController pushViewController:test animated:YES];
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

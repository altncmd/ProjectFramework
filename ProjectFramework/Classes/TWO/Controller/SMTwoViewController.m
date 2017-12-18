//
//  SMTwoViewController.m
//  ProjectFramework
//
//  Created by Elroy on 12/15/17.
//  Copyright © 2017 钟世明. All rights reserved.
//

#import "SMTwoViewController.h"

@interface SMTwoViewController ()

@end

@implementation SMTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *btn = [SMUIFactory buttonWithTitle:@"Show hint" titleFontSize:16 titleColor:[UIColor redColor]];
    btn.backgroundColor = [UIColor greenColor];
    [btn addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
        make.width.height.equalTo(@100);
    }];
    [self.view layoutIfNeeded];
    
}

- (void)test {
    [self showHint:@"This is hint!"];
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

//
//  SMBaseViewController.m
//  ProjectFramework
//
//  Created by Elroy on 10/31/17.
//  Copyright © 2017 钟世明. All rights reserved.
//

#import "SMBaseViewController.h"

@interface SMBaseViewController ()

@end

@implementation SMBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor];//HexColor(@"F5F5F5");
    
    self.layoutReferenceView = [[UIView alloc] init];
    self.layoutReferenceView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.layoutReferenceView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.layoutReferenceView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.edges.equalTo(self.view).with.insets(self.view.safeAreaInsets);
        } else {
            make.edges.equalTo(self.view).with.offset(0);
        }
    }];
    [self.view layoutIfNeeded];
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
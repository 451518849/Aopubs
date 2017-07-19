//
//  ButtonEventController.m
//  Aopubs
//
//  Created by 小发工作室 on 2017/7/19.
//  Copyright © 2017年 wangxiaofa. All rights reserved.
//

#import "ButtonEventController.h"

@interface ButtonEventController ()

@property (nonatomic, strong) UIButton *button;

@end

@implementation ButtonEventController

- (UIButton *)button {
    if (_button == nil) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = CGRectMake(0, 0, 100, 40);
        [_button setTitle:@"点击我" forState:UIControlStateNormal];
        [_button setBackgroundColor:[UIColor greenColor]];
        [_button addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.button.center = self.view.center;
    
    [self.view addSubview:self.button];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clickButton {
    NSLog(@"button clicked");
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

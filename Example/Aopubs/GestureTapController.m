//
//  GestureTapController.m
//  Aopubs
//
//  Created by 小发工作室 on 2017/7/19.
//  Copyright © 2017年 wangxiaofa. All rights reserved.
//

#import "GestureTapController.h"

@interface GestureTapController ()

@property (nonatomic, strong) UILabel *gestureTapLabel;
@end

@implementation GestureTapController

- (UILabel *)gestureTapLabel {
    if (_gestureTapLabel == nil) {
        _gestureTapLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
        _gestureTapLabel.text = @"点击我";
        _gestureTapLabel.backgroundColor = [UIColor redColor];
        _gestureTapLabel.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap)];
        [_gestureTapLabel addGestureRecognizer:tap];
    }
    
    return _gestureTapLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.gestureTapLabel.center = self.view.center;
    
    [self.view addSubview:self.gestureTapLabel];
    // Do any additional setup after loading the view.
}

- (void)singleTap {
    NSLog(@"single tap");
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

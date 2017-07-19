//
//  ViewController.m
//  Aopubs
//
//  Created by 小发工作室 on 2017/7/18.
//  Copyright © 2017年 wangxiaofa. All rights reserved.
//

#import "ViewController.h"
#import "GestureTapController.h"
#import "ButtonEventController.h"

static NSString *cellIdentifier = @"cell";

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray     *dataSource;

@end

@implementation ViewController

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.delegate   = self;
        _tableView.dataSource = self;
        
    }
    return _tableView;
}

- (NSArray *)dataSource {
    if (_dataSource == nil) {
        
        _dataSource = [NSArray arrayWithObjects:@"controller ubs 已开启",
                       @"Cell 点击事件（已开启）",
                       @"手势单击事件",
                       @"Button 点击事件",nil];
    }
    return _dataSource;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.tableView];
    NSLog(@"%@",NSHomeDirectory());
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark -UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [self.dataSource objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 2) {
        
        [self performSegueWithIdentifier:@"tapsegue" sender:self];
    }
    else if (indexPath.row == 3) {
        
        [self performSegueWithIdentifier:@"buttonsegue" sender:self];

    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

//
//  MainViewController.m
//  WConfirmViewDemo
//
//  Created by snow on 15/9/9.
//  Copyright (c) 2015年 yojianzhi. All rights reserved.
//

#import "MainViewController.h"
#import "WConfirmView/WConfirmView.h"
#import "WBackView.h"

@interface MainViewController () <WConfirmViewDelegate>

@end

@implementation MainViewController
- (IBAction)showConfirmView:(UIButton *)sender {
	switch (sender.tag) {
  		case 1:
			[WConfirmView showConfirmViewWithTitle:@"温馨提示" andContent:@"您的女朋友到货了，请您去前台签收" andCancelStr:@"我不要了" andOtherBtn:nil andDelegate:self];
			break;
  		case 2:
			[WConfirmView showConfirmViewWithTitle:@"温馨提示" andContent:@"您的女朋友到货了，请您去前台签收" andCancelStr:@"我不要了" andOtherBtn:@[@"快拿来"] andDelegate:self];
			break;
		case 3:
			[WConfirmView showConfirmViewWithTitle:nil andContent:nil andCancelStr:@"我不要了" andOtherBtn:@[@"快拿来", @"给隔壁老王"] andDelegate:self];
			break;
			
		default:
			break;
	}
	
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)wconfirmView:(WConfirmView *)confirmView didClickedButtonAtIndex:(NSInteger)index {
	NSLog(@"the index of tap button is %d", (int)index);
	if (index == 2) {
		[WBackView hideView];
	}
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

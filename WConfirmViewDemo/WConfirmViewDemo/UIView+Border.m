//
//  UIView+Border.m
//  WConfirmViewDemo
//
//  Created by snow on 15/9/9.
//  Copyright (c) 2015年 yojianzhi. All rights reserved.
//

#import "UIView+Border.h"
#import "Masonry.h"

@implementation UIView (Border)

- (void)drawLineWithColor:(UIColor *)color locate:(NSInteger)locate andPedding:(NSInteger)pedding{
	if (!color) {
		color = WColorLightGray;
	}
	UIView *lineView = [[UIView alloc] init];
	lineView.backgroundColor = color;
	[self addSubview:lineView];
	[lineView mas_makeConstraints:^(MASConstraintMaker *make) {
		if (locate == 0 || locate == 2) {
			make.right.equalTo(@0);
			make.left.equalTo(@(pedding));
			make.height.equalTo(@0.5);
			if (locate == 0) {
				make.top.equalTo(@0);
			}else {
				make.bottom.equalTo(@0);
			}
		}else {
			make.bottom.equalTo(@0);
			make.top.equalTo(@(pedding));
			make.width.equalTo(@0.5);
			if (locate == 1) {
				make.left.equalTo(@0);
			}else {
				make.right.equalTo(@0);
			}
		}
	}];
}
- (void)drawLineWithColor:(UIColor *)color andFrame:(CGRect)frame{
	if (!color) {
		color = WColorMain;
	}
	UIView *lineView = [[UIView alloc] initWithFrame:frame];
	lineView.backgroundColor = color;
	[self addSubview:lineView];
}

@end

//
//  UIView+Border.h
//  WConfirmViewDemo
//
//  Created by snow on 15/9/9.
//  Copyright (c) 2015年 yojianzhi. All rights reserved.
//

#import <UIKit/UIKit.h>

// 颜色
#define WColorRGB(r, g, b) WColorRGBA(r, g, b, 1.000f)
#define WColorRGBA(r, g, b, a) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:(a)]

/**
 *  主要颜色(绿)
 */
#define WColorMain WColorRGB(38, 204, 92)
/**
 *  标题文字颜色
 */
#define WColorFontTitle WColorRGB(38, 38, 38)
/**
 *  内容文字颜色
 */
#define WColorFontContent WColorRGB(115, 115, 115)
/**
 *  细节文字颜色
 */
#define WColorFontDetail WColorRGB(166, 166, 166)
/**
 *  浅灰色 透明度
 */
#define WColorLightGray WColorRGB(242, 242, 242)
/**
 *  辅助颜色(橙)
 */
#define WColorAssist WColorRGB(255, 180, 0)
/**
 *  提醒颜色(红)
 */
#define WColorAlert WColorRGB(234, 86, 66)

@interface UIView (Border)

/**
 *  在 View 上画一条横线
 *	1234 上左下右
 */
- (void)drawLineWithColor:(UIColor *)color locate:(NSInteger)locate andPedding:(NSInteger)pedding;
/**
 *  在 View 上画一条横线
 */
- (void)drawLineWithColor:(UIColor *)color andFrame:(CGRect)frame;

@end

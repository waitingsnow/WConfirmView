//
//  WBackView.h
//  jianzhiweishi
//
//  Created by snow on 15/6/12.
//  Copyright (c) 2015年 yojianzhi. All rights reserved.
//

#import "FXBlurView.h"
#define MAS_SHORTHAND_GLOBALS

// 动态获取屏幕宽高
#define WScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define WScreenWidth ([UIScreen mainScreen].bounds.size.width)

// 弹出框距左右边距
#define WPeddingWidth 25
// 普通视图左右边距
#define WPedding 16
// 默认按钮高度
#define WButtonHeight 48

@interface WBackView : FXBlurView
+ (void)exchangeTopViewWith:(UIView *)newView isTouchHide:(BOOL)isTouchHidden;
+ (void)presentTopViewWith:(UIView *)view isTouchHide:(BOOL)isTouchHidden;
+ (void)hideView;

@end

//
//  WConfirmView.h
//  jianzhiweishi
//
//  Created by snow on 15/6/12.
//  Copyright (c) 2015年 yojianzhi. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol WConfirmViewDelegate;

@interface WConfirmView : UIView
@property (nonatomic, assign) id<WConfirmViewDelegate> delegate;

- (instancetype)initWithTitle:(NSString *)title andContent:(NSString *)content andCancelStr:(NSString *)cancel andOtherBtn:(NSArray *)otherBtns;
- (void)show;

+ (void)showConfirmViewWithTitle:(NSString *)title andContent:(NSString *)content andCancelStr:(NSString *)cancel andOtherBtn:(NSArray *)otherBtns andDelegate:(id<WConfirmViewDelegate>)delegate;
+ (void)showConfirmViewWithImage:(NSString *)image andContent:(NSString *)content andCancelStr:(NSString *)cancel andOtherBtn:(NSArray *)otherBtns andDelegate:(id<WConfirmViewDelegate>)delegate;

@end

@protocol WConfirmViewDelegate <NSObject>

@optional
- (void)wconfirmView:(WConfirmView *)confirmView didClickedButtonAtIndex:(NSInteger)index;
- (void)didClickedCancelButtonWithWconfirmView:(WConfirmView *)confirmView;

@end

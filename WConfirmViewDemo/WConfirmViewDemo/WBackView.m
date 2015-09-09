//
//  WBackView.m
//  jianzhiweishi
//
//  Created by snow on 15/6/12.
//  Copyright (c) 2015年 yojianzhi. All rights reserved.
//

#import "WBackView.h"
#import "Masonry.h"
#import "AppDelegate.h"
#import "FrameAccessor.h"

// application
#define WApplication [UIApplication sharedApplication]
// appDelegate
#define WAppDelegate ((AppDelegate *)WApplication.delegate)

static WBackView *_defaultBackgroundView = nil;
typedef enum : NSUInteger {
	PopViewAnimationBounceCenter,
	PopViewAnimationBottom,
	PopViewAnimationDefault = PopViewAnimationBounceCenter
} PopViewAnimationType;

@interface WBackView () <UIGestureRecognizerDelegate>
@property (assign, nonatomic) PopViewAnimationType popViewAnimationType;
@property (assign, nonatomic) BOOL isPopping;
@property (assign, nonatomic) BOOL isTouchHidden;
@property (strong, nonatomic) UIView *topView;

@end

@implementation WBackView

+ (instancetype)defaultBackgroundView{
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		_defaultBackgroundView = [[super allocWithZone:NULL] initWithFrame:CGRectMake(0, 0, WScreenWidth, WScreenHeight)];
		[_defaultBackgroundView preConfig];
		[_defaultBackgroundView configBlur];
//		[_defaultBackgroundView configUnderView];
	});
	_defaultBackgroundView.frame = CGRectMake(0, 0, WScreenWidth, WScreenHeight);
	return _defaultBackgroundView;
}

- (void)preConfig{
	self.isTouchHidden = YES;
	self.popViewAnimationType = PopViewAnimationBounceCenter;
	
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:[self class] action:@selector(clickBackgroundView:)];
	[tap setDelegate:self];
	[self addGestureRecognizer:tap];
}

- (void)configBlur{
	self.dynamic = NO;
	self.blurEnabled = YES;
	self.blurRadius = 5.f;
	self.tintColor = [UIColor colorWithWhite:0.000 alpha:0.670];
//	self.layer.backgroundColor = [UIColor blackColor].CGColor;
}

- (void)configUnderView{
	UIView *underView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WScreenWidth, WScreenHeight)];
	underView.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.670];
//	[self addSubview:underView];
	self.underlyingView = underView;
//	[underView mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.edges.equalTo(self);
//	}];
}

+ (void)popView{
	[[self defaultBackgroundView] popView];
}

- (void)popView{
	self.isPopping = YES;
	[WAppDelegate.window endEditing:NO];
	[WAppDelegate.window addSubview:self];
	[self popTopView];
}

+ (void)exchangeTopViewWith:(UIView *)newView isTouchHide:(BOOL)isTouchHidden{
	[[self defaultBackgroundView] setIsTouchHidden:isTouchHidden];
	[self exchangeTopViewWith:newView];
}

+ (void)exchangeTopViewWith:(UIView *)newView{
	[[self defaultBackgroundView] exchangeTopViewWith:newView];
}

- (void)exchangeTopViewWith:(UIView *)newView{
	[self removeTopView:^{
		self.topView = newView;
		newView.center = CGPointMake(WScreenWidth / 2, WScreenHeight / 2);
		[self popTopView];
	}];
}

- (void)popTopView{
	if (!self.isPopping) {
		[self popView];
	}
	[self endEditing:YES];
	self.topView.layer.cornerRadius = 4.f;
	self.topView.layer.masksToBounds = YES;
	_topView.alpha = 1.0f;
	[self addSubview:self.topView];
	[self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
		if (self.popViewAnimationType == PopViewAnimationBottom) {
			make.left.right.equalTo(@0);
		}else {
			make.center.equalTo(@0);
			make.left.equalTo(@(WPeddingWidth));
		}
	}];
	[self layoutIfNeeded];
	__block BOOL canTouch = NO;
	[_topView.subviews enumerateObjectsUsingBlock:^(UIView *subView, NSUInteger idx, BOOL *stop) {
		if ([subView isKindOfClass:[UITableView class]]) {
			canTouch = YES;
			*stop = YES;
		}
	}];
	if (!canTouch) {
		UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:[self class] action:@selector(tapTopView:)];
		[tap setDelegate:self];
		[_topView addGestureRecognizer:tap];
	}
	
	if (self.popViewAnimationType == PopViewAnimationDefault) {
		_topView.transform = CGAffineTransformMakeScale(0.5, 0.5);
		[UIView animateWithDuration:0.25f delay:0.0 usingSpringWithDamping:0.75 initialSpringVelocity:1.0 options:UIViewAnimationOptionTransitionNone animations:^{
			_topView.transform = CGAffineTransformIdentity;
		} completion:^(BOOL finished) {
			
		}];
	}else {
		self.topView.centerY = WScreenHeight + self.topView.height / 2;
		[UIView animateWithDuration:0.25f animations:^{
			self.topView.centerY = WScreenHeight - self.topView.height / 2;
		}];
	}
}

+ (void)hideView{
	[_defaultBackgroundView removeFromSuperview];
}

- (void)removeTopView:(void (^)(void))complete{
	if (self.topView) {
		if (self.popViewAnimationType == PopViewAnimationBottom) {
			[UIView animateWithDuration:0.25f animations:^{
				self.topView.centerY = WScreenHeight + self.topView.height / 2;
			} completion:^(BOOL finished) {
				[self.topView removeFromSuperview];
				if (complete) {
					complete();
				}
			}];
		}else {
			//			_topView.transform = CGAffineTransformScale(_topView.transform, 0.5, 0.5);
			//			[UIView animateWithDuration:WAnimationTime animations:^{
			//				_topView.transform = CGAffineTransformMakeScale(0.001, 0.001);
			//				_topView.alpha = 0.5f;
			//			} completion:^(BOOL finished) {
			[self.topView removeFromSuperview];
			if (complete) {
				complete();
			}
			//			}];
		}
	}else {
		if (complete) {
			complete();
		}
	}
}

- (void)removeFromSuperview{
	[self removeTopView:^{
		self.isPopping = NO;
		[_topView.gestureRecognizers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
			[_topView removeGestureRecognizer:obj];
		}];
		self.topView = nil;
		self.popViewAnimationType = PopViewAnimationBounceCenter;
		[super removeFromSuperview];
	}];
}

+ (void)clickBackgroundView:(UITapGestureRecognizer *)tap{
	if (_defaultBackgroundView.isTouchHidden == YES) {
		[self hideView];
	}
}

+ (void)tapTopView:(UITapGestureRecognizer *)tap{
	[WAppDelegate.window endEditing:YES];
}

+ (void)presentTopViewWith:(UIView *)view isTouchHide:(BOOL)isTouchHidden{
	[[self defaultBackgroundView] presentTopViewWith:view isTouchHide:isTouchHidden];
}

- (void)presentTopViewWith:(UIView *)view isTouchHide:(BOOL)isTouchHidden{
	[self removeTopView:^{
		self.isTouchHidden = isTouchHidden;
		self.topView = view;
		self.popViewAnimationType = PopViewAnimationBottom;
		[self popTopView];
	}];
}

@end

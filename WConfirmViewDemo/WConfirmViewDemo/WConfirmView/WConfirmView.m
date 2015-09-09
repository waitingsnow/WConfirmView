//
//  WConfirmView.m
//  jianzhiweishi
//
//  Created by snow on 15/6/12.
//  Copyright (c) 2015年 yojianzhi. All rights reserved.
//

#import "WConfirmView.h"
#import "UIImage+Color.h"
#import "UIView+Border.h"
#import "WBackView.h"
#import "Masonry.h"

@interface WConfirmView ()
@property (nonatomic, strong) NSArray *buttonTitles;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *bottomView;

@end

@implementation WConfirmView

- (instancetype)initWithTitle:(NSString *)title andContent:(NSString *)content andCancelStr:(NSString *)cancel andOtherBtn:(NSArray *)otherBtns{
	if (self = [super init]) {
		self.backgroundColor = [UIColor whiteColor];
		UIView *lastView;
		if (title) {
			lastView = [self createTitle:title];
		}
		if (content) {
			lastView = [self createContent:content and:lastView];
		}
		self.buttonTitles = otherBtns;
		
		if (otherBtns.count == 1) {
			lastView = [self createButton:otherBtns[0] with:lastView andTag:1];
		}else if (otherBtns.count > 1) {
			for (int i = 0; i < otherBtns.count; ++i) {
				lastView = [self createButton:otherBtns[i] with:lastView andTag:i + 1];
			}
		}
		
		if (cancel) {
			[self createCancelBtn:cancel and:lastView];
		}
		
	}
	return self;
}

- (instancetype)initWithImage:(NSString *)image andContent:(NSString *)content andCancelStr:(NSString *)cancel andOtherBtn:(NSArray *)otherBtns{
	if (self = [super init]) {
		self.backgroundColor = [UIColor whiteColor];
		UIView *lastView;
		if (image) {
			lastView = [self createImage:image];
		}
		if (content) {
			lastView = [self createContent:content and:lastView];
		}
		self.buttonTitles = otherBtns;
		
		if (otherBtns.count == 1) {
			lastView = [self createButton:otherBtns[0] with:lastView andTag:1];
		}else if (otherBtns.count > 1) {
			for (int i = 0; i < otherBtns.count; ++i) {
				lastView = [self createButton:otherBtns[i] with:lastView andTag:i + 1];
			}
		}
		
		if (cancel) {
			[self createCancelBtn:cancel and:lastView];
		}
		
	}
	return self;
}

- (UIView *)createTitle:(NSString *)title{
	UIView *titleView = [[UIView alloc] init];
	[self addSubview:titleView];
	
	UILabel *titleLabel = [[UILabel alloc] init];
	[titleLabel setText:title];
	[titleLabel setFont:[UIFont systemFontOfSize:16]];
	[titleLabel setTextAlignment:NSTextAlignmentLeft];
	[titleLabel setTextColor:WColorFontContent];
	[titleLabel sizeToFit];
	[titleView addSubview:titleLabel];
	[titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(@(WPeddingWidth));
		make.left.equalTo(@(WPeddingWidth));
		make.centerX.equalTo(titleView);
	}];
	
	[titleView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.right.and.top.equalTo(0);
		make.bottom.equalTo(titleLabel.mas_bottom).offset(WPeddingWidth);
	}];
//	[WGWHelp drawLineOnView:titleView withColor:WColorLightGray locate:2 andPedding:0];
	self.topView = titleView;
	return titleView;
}

- (UIView *)createImage:(NSString *)image{
	UIView *titleView = [[UIView alloc] init];
	titleView.backgroundColor = [UIColor whiteColor];
	[self addSubview:titleView];
	
	UIImageView *titleImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:image]];
	[titleView addSubview:titleImage];
	[titleImage mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.equalTo(titleView);
		make.top.equalTo(0);
	}];
	
	[titleView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.right.top.equalTo(0);
		make.bottom.equalTo(titleImage.mas_bottom);
	}];
//	[WGWHelp drawLineOnView:titleView withColor:WColorLightGray locate:2 andPedding:0];
	self.topView = titleView;
	return titleView;
}

- (UIView *)createContent:(NSString *)content and:(UIView *)lastView{
	UIView *contentView = [[UIView alloc] init];
	[self addSubview:contentView];
	
	UILabel *contentLabel = [[UILabel alloc] init];
	[contentLabel setText:content];
	[contentLabel setFont:[UIFont systemFontOfSize:14]];
	[contentLabel setTextAlignment:NSTextAlignmentLeft];
	[contentLabel setTextColor:WColorFontTitle];
	[contentLabel sizeToFit];
	[contentLabel setNumberOfLines:0];
	[contentView addSubview:contentLabel];
	
	[contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(@(0));
		make.left.equalTo(@(WPeddingWidth));
		make.centerX.equalTo(contentView);
	}];
	
	[contentView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.right.equalTo(0);
		make.top.equalTo(lastView ? lastView.mas_bottom : @(WPeddingWidth * 2));
		make.bottom.equalTo(contentLabel.mas_bottom).offset(WPeddingWidth);
	}];
	
	[contentView drawLineWithColor:WColorLightGray locate:2 andPedding:0];
	if (!self.topView) {
		self.topView = contentView;
	}
	return contentView;
}

- (void)createCancelBtn:(NSString *)cancel and:(UIView *)lastView{
	UIButton *cancelButton = [[UIButton alloc] init];
	[cancelButton setTitle:cancel forState:UIControlStateNormal];
	cancelButton.tag = 0;
	[cancelButton setBackgroundImage:[UIImage imageWithColor:WColorFontDetail] forState:UIControlStateHighlighted];
	[cancelButton titleLabel].font = [UIFont systemFontOfSize:14];
	[self addSubview:cancelButton];
	if (self.buttonTitles.count == 0) {
		[cancelButton setTitleColor:WColorMain forState:UIControlStateNormal];
	}else if (self.buttonTitles.count == 1) {
		[cancelButton setTitleColor:WColorFontContent forState:UIControlStateNormal];
		[cancelButton drawLineWithColor:WColorLightGray locate:3 andPedding:0];
	}else {
		[cancelButton setTitleColor:WColorAlert forState:UIControlStateNormal];
	}
	[cancelButton addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
	
	[cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(@0);
		make.top.equalTo(self.buttonTitles.count == 1 ? lastView.mas_top : lastView.mas_bottom);
		make.right.equalTo(self.buttonTitles.count == 1 ? lastView.mas_left : @0);
		make.height.equalTo(@(WButtonHeight));
		if (self.buttonTitles.count == 1) {
			make.width.equalTo(lastView);
		}
	}];
	self.bottomView = cancelButton;
}

- (UIView *)createButton:(NSString *)buttonTitle with:(UIView *)lastView andTag:(NSInteger)tag{
	UIButton *confirmBtn = [[UIButton alloc] init];
	[confirmBtn setTitle:buttonTitle forState:UIControlStateNormal];
	[confirmBtn setBackgroundImage:[UIImage imageWithColor:WColorFontDetail] forState:UIControlStateHighlighted];
	confirmBtn.tag = tag;
	[confirmBtn titleLabel].font = [UIFont systemFontOfSize:14];
	[confirmBtn addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
	[confirmBtn drawLineWithColor:WColorLightGray locate:2 andPedding:0];
	[self addSubview:confirmBtn];
	if (self.buttonTitles.count == 1) {
		[confirmBtn setTitleColor:WColorMain forState:UIControlStateNormal];
		[confirmBtn drawLineWithColor:WColorLightGray locate:2 andPedding:0];
	}else {
		[confirmBtn setTitleColor:WColorFontContent forState:UIControlStateNormal];
	}
	
	[confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
		make.right.equalTo(@0);
		make.top.equalTo(lastView ? lastView.mas_bottom : @0);
		if (self.buttonTitles.count != 1) {
			make.left.equalTo(@0);
		}else {
			make.width.equalTo(self).dividedBy(2);
		}
		make.height.equalTo(@(WButtonHeight));
	}];
	
	if (!self.topView) {
		self.topView = confirmBtn;
	}
	return confirmBtn;
}

- (void)show{
//	self.frame = (CGRect){WPeddingWidth, 100, WScreenWidth - WPeddingWidth * 2, self.height};
	[self mas_makeConstraints:^(MASConstraintMaker *make) {
		make.bottom.equalTo(self.bottomView.mas_bottom);
	}];
	[WBackView exchangeTopViewWith:self isTouchHide:NO];
}

- (void)tapButton:(UIButton *)button{
	if (button.tag == 0) {
		if (self.delegate && [self.delegate respondsToSelector:@selector(didClickedCancelButtonWithWconfirmView:)]) {
			[self.delegate didClickedCancelButtonWithWconfirmView:self];
		}else {
			[WBackView hideView];
		}
	}else {
		if (self.delegate && [self.delegate respondsToSelector:@selector(wconfirmView:didClickedButtonAtIndex:)]) {
			[self.delegate wconfirmView:self didClickedButtonAtIndex:button.tag];
		}else {
			[WBackView hideView];
		}
	}
}

+ (void)showConfirmViewWithTitle:(NSString *)title andContent:(NSString *)content andCancelStr:(NSString *)cancel andOtherBtn:(NSArray *)otherBtns andDelegate:(id<WConfirmViewDelegate>)delegate{
	WConfirmView *confirmView = [[self alloc] initWithTitle:title andContent:content andCancelStr:cancel andOtherBtn:otherBtns];
	confirmView.delegate = delegate;
	[confirmView show];
}
+ (void)showConfirmViewWithImage:(NSString *)image andContent:(NSString *)content andCancelStr:(NSString *)cancel andOtherBtn:(NSArray *)otherBtns andDelegate:(id<WConfirmViewDelegate>)delegate{
	WConfirmView *confirmView = [[self alloc] initWithImage:image andContent:content andCancelStr:cancel andOtherBtn:otherBtns];
	confirmView.delegate = delegate;
	[confirmView show];
}

@end

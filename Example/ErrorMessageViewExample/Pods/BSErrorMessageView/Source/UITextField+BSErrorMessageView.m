//
//  UITextField+BSErrorMessageView.m
//
//  Created by Beniamin Sarkisyan on 05.07.15.
//  Copyright (c) 2015 Cleverpumpkin, Ltd. All rights reserved.
//

#import "UITextField+BSErrorMessageView.h"

@implementation UITextField (BSErrorMessageView)

- (BSErrorMessageView *)errorMessageView
{
    return [self.rightView isKindOfClass:[BSErrorMessageView class]] ? (BSErrorMessageView *)self.rightView : nil;
}

- (void)bs_setupErrorMessageViewWithMessage:(NSString *)message
{
	self.rightView = [BSErrorMessageView errorMessageViewWithMessage:message];
}

- (void)bs_setupErrorMessageViewWithView:(BSErrorMessageView *)errorMessageView
{
    self.rightView = errorMessageView;
}

- (void)bs_showError
{
    self.rightViewMode = UITextFieldViewModeAlways;
}

- (void)bs_hideError
{
	self.rightViewMode = UITextFieldViewModeNever;
}

@end

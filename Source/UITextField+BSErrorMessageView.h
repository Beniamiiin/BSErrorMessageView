//
//  UITextField+BSErrorMessageView.h
//
//  Created by Beniamin Sarkisyan on 05.07.15.
//  Copyright (c) 2015 Cleverpumpkin, Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BSErrorMessageView.h"

@interface UITextField (BSErrorMessageView)

@property (nonatomic, readonly, weak) BSErrorMessageView *errorMessageView;

- (void)bs_setupErrorMessageViewWithMessage:(NSString *)message;
- (void)bs_setupErrorMessageViewWithView:(BSErrorMessageView *)errorMessageView;

- (void)bs_showError;
- (void)bs_hideError;

@end

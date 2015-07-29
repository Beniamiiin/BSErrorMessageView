//
//  UITextField+BSErrorMessageView.h
//
//  Created by Beniamin Sarkisyan on 05.07.15.
//

#import <UIKit/UIKit.h>

#import "BSErrorMessageView.h"

@interface UITextField (BSErrorMessageView)

- (void)bs_setupErrorMessageViewWithMessage:(NSString *)message;
- (void)bs_setupErrorMessageViewWithView:(BSErrorMessageView *)errorMessageView;

- (void)bs_showError;
- (void)bs_hideError;

@end

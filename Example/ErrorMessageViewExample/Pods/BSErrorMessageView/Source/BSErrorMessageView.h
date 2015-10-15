//
//  BSErrorMessageView.h
//
//  Created by Beniamin Sarkisyan on 05.07.15.
//  Copyright (c) 2015 Cleverpumpkin, Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BSErrorMessageView;

@protocol BSErrorMessageViewDelegate <NSObject>

@optional

- (void)bs_messageWillShow:(BSErrorMessageView *)errorMessageView;
- (void)bs_messageDidShow:(BSErrorMessageView *)errorMessageView;

- (void)bs_messageWillHide:(BSErrorMessageView *)errorMessageView;
- (void)bs_messageDidHide:(BSErrorMessageView *)errorMessageView;

@end

@interface BSErrorMessageView : UIView

@property (nonatomic, weak) id<BSErrorMessageViewDelegate> delegate;

@property (nonatomic, copy) NSString *message;

@property (nonatomic, copy) NSString *confirmationButtonText;

/**
 *  Error message container and error icon background color
 *  If messageContainerTint and iconTint colors is not equal, then mainTintColor nil
 *  But if is equal, then mainTintColor equal messageContainerTintColor
 *  Default [UIColor redColor]
 */
@property (nonatomic, strong) UIColor *mainTintColor;

/**
 *  Error message container background color
 *  Default [UIColor redColor]
 */
@property (nonatomic, strong) UIColor *messageContainerTintColor;

/**
 *  Error icon background color
 *  Default [UIColor redColor]
 */
@property (nonatomic, strong) UIColor *iconTintColor;

/**
 *  Error message text color
 *  Default [UIColor whiteColor]
 */
@property (nonatomic, strong) UIColor *textColor;

/**
 *  Error message text font
 *  Default [UIFont systemFontOfSize:11.f]
 */
@property (nonatomic, strong) UIFont *textFont;

/**
 *  Padding from the error icon to the superview
 *  Defualt 7px
 */
@property (nonatomic, assign) CGFloat rightPadding;

/**
 *  Instance view height
 *  Default 25px
 */
@property (nonatomic, assign) CGFloat containerHeight;

/**
 *  Message container fade animation duration
 *  Default 0.3
 */
@property (nonatomic, assign) NSTimeInterval showMessageAnimationDuration;

/**
 *  Message container state
 *  If messageAlwaysShowing equal NO, then error icon button clickable
 *  and if click error icon button message view show/hide
 *  Default NO
 */
@property (nonatomic, assign) BOOL messageAlwaysShowing;

/**
 *  Message container default state
 *  If messageDefaultHidden equal YES, then when error message view showing,
 *  showen only error icon, but if messageDefaultHidden equal NO, then
 *  showen and message container, and error icon
 *  Default YES
 */
@property (nonatomic, assign) BOOL messageDefaultHidden;

+ (instancetype)errorMessageViewWithMessage:(NSString *)message;
- (instancetype)initErrorMessageViewWithMessage:(NSString *)message;

@end

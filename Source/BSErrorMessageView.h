//
//  BSErrorMessageView.h
//
//  Created by Beniamin Sarkisyan on 05.07.15.
//

#import <UIKit/UIKit.h>

@interface BSErrorMessageView : UIView

@property (nonatomic, copy) NSString *message;

/**
 *  Error message container and error icon background color
 *  Default [UIColor redColor]
 */
@property (nonatomic, strong) UIColor *tintColor;

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

+ (instancetype)errorMessageViewWithMessage:(NSString *)message;
- (instancetype)initErrorMessageViewWithMessage:(NSString *)message;

@end

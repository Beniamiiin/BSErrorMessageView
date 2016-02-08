//
//  BSErrorMessageView.m
//
//  Created by Beniamin Sarkisyan on 05.07.15.
//  Copyright (c) 2015 Cleverpumpkin, Ltd. All rights reserved.
//

#import "BSErrorMessageView.h"

static const UILayoutPriority BSLayoutPriorityAlmostRequired = UILayoutPriorityRequired-1;

static CGFloat const kBSMessageLabelLeadingConstant  = 10.f;
static CGFloat const kBSMessageLabelTrailingConstant = -13.5f;

@interface BSErrorMessageView ()
{
    UIColor *_messageContainerTintColor;
    UIColor *_iconTintColor;
    UIColor *_textColor;
    UIFont *_textFont;
    CGFloat _rightPadding;
    CGFloat _containerHeight;
    NSTimeInterval _showMessageAnimationDuration;
    BOOL _messageAlwaysShowing;
    BOOL _messageDefaultHidden;
}

@property (nonatomic, weak) UIImageView *errorBGImageView;
@property (nonatomic, weak) UILabel *messageLabel;
@property (nonatomic, weak) UIButton *errorIconButton;

@property (nonatomic, strong) NSLayoutConstraint *errorBGImageViewWidthConstraint;
@property (nonatomic, strong) NSLayoutConstraint *messageLabelLeadingConstraint;
@property (nonatomic, strong) NSLayoutConstraint *messageLabelTrailingConstraint;
@property (nonatomic, strong) NSLayoutConstraint *errorIconTrailingConstraint;

@end

@implementation BSErrorMessageView

@dynamic message, mainTintColor, messageContainerTintColor, iconTintColor, textColor, textFont, rightPadding, containerHeight, showMessageAnimationDuration, messageAlwaysShowing, messageDefaultHidden;

+ (instancetype)errorMessageViewWithMessage:(NSString *)message
{
    return [[self alloc] initErrorMessageViewWithMessage:message];
}

- (instancetype)initErrorMessageViewWithMessage:(NSString *)message
{
    self = [super initWithFrame:CGRectZero];
    
    if ( self )
    {
        [self setup];
        
        self.message = message;
    }
    
    return self;
}

#pragma mark - Public methods
- (NSString *)message
{
    return self.messageLabel.text;
}

- (void)setMessage:(NSString *)message
{
    self.messageLabel.text = message;
    
    [self reloadWith];
}

- (UIColor *)mainTintColor
{
    return CGColorEqualToColor(self.messageContainerTintColor.CGColor, self.iconTintColor.CGColor) ? self.messageContainerTintColor : nil;
}

- (void)setMainTintColor:(UIColor *)mainTintColor
{
    self.messageContainerTintColor = mainTintColor;
    self.iconTintColor = mainTintColor;
}

- (UIColor *)messageContainerTintColor
{
    return _messageContainerTintColor;
}

- (void)setMessageContainerTintColor:(UIColor *)messageContainerTintColor
{
    _messageContainerTintColor = messageContainerTintColor;
    
    self.errorBGImageView.tintColor = _messageContainerTintColor;
}

- (UIColor *)iconTintColor
{
    return _iconTintColor;
}

- (void)setIconTintColor:(UIColor *)iconTintColor
{
    _iconTintColor = iconTintColor;
    
    self.errorIconButton.imageView.tintColor = _iconTintColor;
}

- (UIColor *)textColor
{
    return _textColor;
}

- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    
    self.messageLabel.textColor = _textColor;
}

- (UIFont *)textFont
{
    return _textFont;
}

- (void)setTextFont:(UIFont *)textFont
{
    _textFont = textFont;
    
    self.messageLabel.font = _textFont;
    
    [self reloadWith];
}

- (CGFloat)rightPadding
{
    return _rightPadding;
}

- (void)setRightPadding:(CGFloat)rightPadding
{
    _rightPadding = rightPadding;
    
    self.errorIconTrailingConstraint.constant = -_rightPadding;
}

- (CGFloat)containerHeight
{
    return _containerHeight;
}

- (void)setContainerHeight:(CGFloat)containerHeight
{
    _containerHeight = containerHeight;
    
    CGRect frame = self.frame;
    frame.size.height = _containerHeight;
    self.frame = frame;
}

- (NSTimeInterval)showMessageAnimationDuration
{
    return _showMessageAnimationDuration;
}

- (void)setShowMessageAnimationDuration:(NSTimeInterval)showMessageAnimationDuration
{
    _showMessageAnimationDuration = showMessageAnimationDuration;
}

- (BOOL)messageAlwaysShowing
{
    return _messageAlwaysShowing;
}

- (void)setMessageAlwaysShowing:(BOOL)messageAlwaysShowing
{
    _messageAlwaysShowing = messageAlwaysShowing;
    
    if ( _messageAlwaysShowing )
    {
        [self setupAlwaysShowingMessageView];
    }
    else
    {
        [self setupNonAlwaysShowingMessageView];
    }
}

- (BOOL)messageDefaultHidden
{
    return _messageDefaultHidden;
}

- (void)setMessageDefaultHidden:(BOOL)messageDefaultHidden
{
    _messageDefaultHidden = messageDefaultHidden;
    
    if ( _messageDefaultHidden )
    {
        [self hideMessageContainer];
    }
    else
    {
        [self showMessageContainer];
    }
}

#pragma mark - Setup methods
- (void)setup
{
    [self setupDefaultSettings];
    [self setupViews];
    [self setupConstraints];
}

- (void)setupDefaultSettings
{
    UIColor *tintColor = [UIColor redColor];
    
    _messageContainerTintColor = tintColor;
    _iconTintColor = tintColor;
    _textColor = [UIColor whiteColor];
    _textFont = [UIFont systemFontOfSize:11.f];
    _rightPadding = 0.f;
    _containerHeight = 25.f;
    _showMessageAnimationDuration = 0.3f;
    _messageAlwaysShowing = NO;
    _messageDefaultHidden = YES;
}

- (void)setupViews
{
    self.backgroundColor = [UIColor clearColor];
    
    CGRect frame = self.frame;
    frame.size.height = self.containerHeight;
    self.frame = frame;
    
    // error bg image
    {
        NSString *errorBGImagePath = [[[self class] resourcesBundle] pathForResource:@"bs_errorBG" ofType:@"png"];
        UIImage *errorBGImage = [[UIImage alloc] initWithContentsOfFile:errorBGImagePath];
        errorBGImage = [errorBGImage resizableImageWithCapInsets:UIEdgeInsetsMake(0.f, 6.f, 0.f, 10.f)];
        errorBGImage = [errorBGImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        UIImageView *errorBGImageView = [[UIImageView alloc] initWithImage:errorBGImage];
        errorBGImageView.translatesAutoresizingMaskIntoConstraints = NO;
        errorBGImageView.tintColor = self.mainTintColor;
        errorBGImageView.alpha = 0.f;
        
        [self addSubview:errorBGImageView];
        self.errorBGImageView = errorBGImageView;
    }
    
    // error icon image
    {
        NSString *errorIconImagePath = [[[self class] resourcesBundle] pathForResource:@"bs_errorIcon" ofType:@"png"];
        UIImage *errorIconImage = [[UIImage alloc] initWithContentsOfFile:errorIconImagePath];
        errorIconImage = [errorIconImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        UIButton *errorIconButton = [UIButton new];
        errorIconButton.translatesAutoresizingMaskIntoConstraints = NO;
        errorIconButton.tintColor = self.mainTintColor;
        [errorIconButton setImage:errorIconImage forState:UIControlStateNormal];
        [errorIconButton addTarget:self action:@selector(errorIconButtonAction) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:errorIconButton];
        self.errorIconButton = errorIconButton;
    }
    
    // error message label
    {
        UILabel *messageLabel = [UILabel new];
        messageLabel.translatesAutoresizingMaskIntoConstraints = NO;
        messageLabel.font = self.textFont;
        messageLabel.textColor = self.textColor;
        
        [self.errorBGImageView addSubview:messageLabel];
        self.messageLabel = messageLabel;
    }
}

- (void)setupConstraints
{
    NSDictionary *views = @{
                            @"errorBG"   : self.errorBGImageView,
                            @"message"   : self.messageLabel,
                            @"errorIcon" : self.errorIconButton
                            };
    // vertical
    {
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(0)-[errorBG]-(0)-|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(0)-[message]-(0)-|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[errorIcon(30)]"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:views]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.errorIconButton
                                                         attribute:NSLayoutAttributeCenterY
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.errorBGImageView
                                                         attribute:NSLayoutAttributeCenterY
                                                        multiplier:1.f
                                                          constant:0.f]];
    }
    
    // horizontal
    {
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(0)-[errorBG]"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[errorIcon(30)]"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:views]];
        
        NSLayoutConstraint *errorBGImageViewTrailingConstraint = [NSLayoutConstraint constraintWithItem:self.errorBGImageView
                                                                                              attribute:NSLayoutAttributeTrailing
                                                                                              relatedBy:NSLayoutRelationEqual
                                                                                                 toItem:self.errorIconButton
                                                                                              attribute:NSLayoutAttributeLeading
                                                                                             multiplier:1.f
                                                                                               constant:0.f];
        errorBGImageViewTrailingConstraint.priority = UILayoutPriorityDefaultHigh;
        [self addConstraint:errorBGImageViewTrailingConstraint];
        
        NSLayoutConstraint *messageLabelLeadingConstraint = [NSLayoutConstraint constraintWithItem:self.messageLabel
                                                                                         attribute:NSLayoutAttributeLeading
                                                                                         relatedBy:NSLayoutRelationEqual
                                                                                            toItem:self.errorBGImageView
                                                                                         attribute:NSLayoutAttributeLeading
                                                                                        multiplier:1.f
                                                                                          constant:0.f];
        self.messageLabelLeadingConstraint = messageLabelLeadingConstraint;
        [self addConstraint:messageLabelLeadingConstraint];
        
        NSLayoutConstraint *messageLabelTrailingConstraint = [NSLayoutConstraint constraintWithItem:self.messageLabel
                                                                                          attribute:NSLayoutAttributeTrailing
                                                                                          relatedBy:NSLayoutRelationEqual
                                                                                             toItem:self.errorBGImageView
                                                                                          attribute:NSLayoutAttributeTrailing
                                                                                         multiplier:1.f
                                                                                           constant:0.f];
        self.messageLabelTrailingConstraint = messageLabelTrailingConstraint;
        [self addConstraint:messageLabelTrailingConstraint];
        
        NSLayoutConstraint *errorIconTrailingConstraint = [NSLayoutConstraint constraintWithItem:self.errorIconButton
                                                                                       attribute:NSLayoutAttributeTrailing
                                                                                       relatedBy:NSLayoutRelationEqual
                                                                                          toItem:self
                                                                                       attribute:NSLayoutAttributeTrailing
                                                                                      multiplier:1.f
                                                                                        constant:-self.rightPadding];
        [self addConstraint:errorIconTrailingConstraint];
        self.errorIconTrailingConstraint = errorIconTrailingConstraint;
        
        NSLayoutConstraint *errorBGImageViewWidthConstraint = [NSLayoutConstraint constraintWithItem:self.errorBGImageView
                                                                                           attribute:NSLayoutAttributeWidth
                                                                                           relatedBy:NSLayoutRelationEqual
                                                                                              toItem:nil
                                                                                           attribute:NSLayoutAttributeNotAnAttribute
                                                                                          multiplier:0.f
                                                                                            constant:0.f];
        errorBGImageViewWidthConstraint.priority = BSLayoutPriorityAlmostRequired;
        [self addConstraint:errorBGImageViewWidthConstraint];
        self.errorBGImageViewWidthConstraint = errorBGImageViewWidthConstraint;
    }
}

#pragma mark - Handlers
- (void)errorIconButtonAction
{
    CGSize size = [self.messageLabel.text sizeWithAttributes:@{NSFontAttributeName:self.messageLabel.font}];
    if ((size.width > self.superview.bounds.size.width)) {
        [[[UIAlertView alloc] initWithTitle:@"" message:self.messageLabel.text delegate:nil cancelButtonTitle:self.confirmationButtonText?:@"OK" otherButtonTitles: nil] show];
        return;
    }
    
    self.errorIconButton.userInteractionEnabled = NO;
    
    if ( self.errorBGImageViewWidthConstraint.priority == BSLayoutPriorityAlmostRequired )
    {
        if ( [self.delegate respondsToSelector:@selector(bs_messageWillShow:)] )
        {
            [self.delegate bs_messageWillShow:self];
        }
        
        [self showMessage];
        [self reloadWith];
        
        if ( [self.superview isKindOfClass:[UITextField class]] )
        {
            UITextField *textField = (UITextField *)self.superview;
            textField.rightView = nil;
            textField.rightView = self;
        }
        
        [UIView animateWithDuration:self.showMessageAnimationDuration
                              delay:0.f
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.errorBGImageView.alpha = 1.f;
                         } completion:^(BOOL finished) {
                             self.errorIconButton.userInteractionEnabled = YES;
                             
                             if ( [self.delegate respondsToSelector:@selector(bs_messageDidShow:)] )
                             {
                                 [self.delegate bs_messageDidShow:self];
                             }
                         }];
    }
    else
    {
        if ( [self.delegate respondsToSelector:@selector(bs_messageWillShow:)] )
        {
            [self.delegate bs_messageWillHide:self];
        }
        
        [UIView animateWithDuration:self.showMessageAnimationDuration
                              delay:0.f
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.errorBGImageView.alpha = 0.f;
                         } completion:^(BOOL finished) {
                             [self hideMessage];
                             [self reloadWith];
                             
                             self.errorIconButton.userInteractionEnabled = YES;
                             
                             if ( [self.delegate respondsToSelector:@selector(bs_messageDidHide:)] )
                             {
                                 [self.delegate bs_messageDidHide:self];
                             }
                             
                             if ( [self.superview isKindOfClass:[UITextField class]] )
                             {
                                 UITextField *textField = (UITextField *)self.superview;
                                 textField.rightView = nil;
                                 textField.rightView = self;
                             }
                         }];
    }
}

#pragma mark - Helpers
- (void)reloadWith
{
    CGRect frame = self.frame;
    frame.size.width = ceilf([self systemLayoutSizeFittingSize:UILayoutFittingExpandedSize].width);
    self.frame = frame;
}

+ (NSBundle *)resourcesBundle
{
    static dispatch_once_t onceToken;
    static NSBundle *resourcesBundle = nil;
    
    dispatch_once(&onceToken, ^{
        NSString *fileName = @"BSResources";
        NSString *ext = @"bundle";
        NSURL *url = [[NSBundle mainBundle] URLForResource:fileName withExtension:ext];
        
        if ( !url )
        {
            url = [[NSBundle bundleForClass:[self class]] URLForResource:fileName withExtension:ext];
        }
        
        if ( url )
        {
            resourcesBundle = [NSBundle bundleWithURL:url];
        }
    });
    
    return resourcesBundle;
}

- (void)showMessage
{
    self.messageLabelLeadingConstraint.constant = kBSMessageLabelLeadingConstant;
    self.messageLabelTrailingConstraint.constant = kBSMessageLabelTrailingConstant;
    self.errorBGImageViewWidthConstraint.priority = UILayoutPriorityDefaultLow;
}

- (void)hideMessage
{
    self.messageLabelLeadingConstraint.constant = 0.f;
    self.messageLabelTrailingConstraint.constant = 0.f;
    self.errorBGImageViewWidthConstraint.priority = BSLayoutPriorityAlmostRequired;
}

- (void)showMessageContainer
{
    [self showMessage];
    self.errorBGImageView.alpha = 1.f;
    
    [self reloadWith];
}

- (void)hideMessageContainer
{
    [self hideMessage];
    self.errorBGImageView.alpha = 0.f;
    
    [self reloadWith];
}

- (void)setupAlwaysShowingMessageView
{
    self.errorIconButton.userInteractionEnabled = NO;

    [self showMessageContainer];
}

- (void)setupNonAlwaysShowingMessageView
{
    self.errorIconButton.userInteractionEnabled = YES;
    
    [self hideMessageContainer];
}

@end

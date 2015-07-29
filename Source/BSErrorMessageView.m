//
//  BSErrorMessageView.m
//
//  Created by Beniamin Sarkisyan on 05.07.15.
//

#import "BSErrorMessageView.h"

@interface BSErrorMessageView ()
{
    UIColor *_tintColor;
    UIColor *_textColor;
    UIFont *_textFont;
    CGFloat _rightPadding;
    CGFloat _containerHeight;
}

@property (nonatomic, weak) UIImageView *errorBGImageView;
@property (nonatomic, weak) UILabel *messageLabel;
@property (nonatomic, weak) UIImageView *errorIconImageView;

@property (nonatomic, strong) NSLayoutConstraint *errorIconTrailingConstraint;

@end

@implementation BSErrorMessageView

@dynamic message, tintColor, textColor, textFont, rightPadding, containerHeight;

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

- (UIColor *)tintColor
{
    return _tintColor;
}

- (void)setTintColor:(UIColor *)tintColor
{
    _tintColor = tintColor;
    
    self.errorBGImageView.tintColor = _tintColor;
    self.errorIconImageView.tintColor = _tintColor;
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

#pragma mark - Setup methods
- (void)setup
{
    [self setupDefaultSettings];
    [self setupViews];
    [self setupConstraints];
}

- (void)setupDefaultSettings
{
    _tintColor = [UIColor redColor];
    _textColor = [UIColor whiteColor];
    _textFont = [UIFont systemFontOfSize:11.f];
    _rightPadding = 7.f;
    _containerHeight = 25.f;
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
        errorBGImageView.tintColor = self.tintColor;
        
        [self addSubview:errorBGImageView];
        self.errorBGImageView = errorBGImageView;
    }
    
    // error icon image
    {
        NSString *errorIconImagePath = [[[self class] resourcesBundle] pathForResource:@"bs_errorIcon" ofType:@"png"];
        UIImage *errorIconImage = [[UIImage alloc] initWithContentsOfFile:errorIconImagePath];
        errorIconImage = [errorIconImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        UIImageView *errorIconImageView = [[UIImageView alloc] initWithImage:errorIconImage];
        errorIconImageView.translatesAutoresizingMaskIntoConstraints = NO;
        errorIconImageView.tintColor = self.tintColor;
        
        [self addSubview:errorIconImageView];
        self.errorIconImageView = errorIconImageView;
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
                            @"errorIcon" : self.errorIconImageView
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
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[errorIcon(20)]"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:views]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.errorIconImageView
                                                         attribute:NSLayoutAttributeCenterY
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.errorBGImageView
                                                         attribute:NSLayoutAttributeCenterY
                                                        multiplier:1.f
                                                          constant:0.f]];
    }
    
    // horizontal
    {
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(0)-[errorBG]-(3)-[errorIcon(20)]"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(10)-[message]-(14)-|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:views]];
        
        NSLayoutConstraint *errorIconTrailingConstraint = [NSLayoutConstraint constraintWithItem:self.errorIconImageView
                                                                                       attribute:NSLayoutAttributeTrailing
                                                                                       relatedBy:NSLayoutRelationEqual
                                                                                          toItem:self
                                                                                       attribute:NSLayoutAttributeTrailing
                                                                                      multiplier:1.f
                                                                                        constant:-self.rightPadding];
        [self addConstraint:errorIconTrailingConstraint];
        self.errorIconTrailingConstraint = errorIconTrailingConstraint;
    }
}

#pragma mark - Helpers
- (void)reloadWith
{
    CGRect frame = self.frame;
    frame.size.width = [self systemLayoutSizeFittingSize:UILayoutFittingExpandedSize].width;
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
        if (!url) {
            url = [[NSBundle bundleForClass:[self class]] URLForResource:fileName withExtension:ext];
        }
        if (url) {
            resourcesBundle = [NSBundle bundleWithURL:url];
        }
    });
    
    return resourcesBundle;
}

@end

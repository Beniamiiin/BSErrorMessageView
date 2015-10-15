//
//  ViewController.m
//  ErrorMessageViewExample
//
//  Created by Beniamin Sarkisyan on 09.08.15.
//  Copyright (c) 2015 Beniamin. All rights reserved.
//

#import "ViewController.h"

#import <BSErrorMessageView.h>
#import <UITextField+BSErrorMessageView.h>

@interface ViewController () <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITextField *loginTextField;
@property (nonatomic, weak) IBOutlet UITextField *passTextField;
@property (nonatomic, weak) IBOutlet UITextField *longMessageTextField;

- (IBAction)enterButtonAction;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupLoginTextField];
    [self setupPassTextField];
    [self setupLongTextField];
}

#pragma mark - Setup methods
- (void)setupLoginTextField
{
    [self defaultSetupTextField:self.loginTextField];
    
    [self.loginTextField bs_setupErrorMessageViewWithMessage:@"Minimum 6 characters"];
}

- (void)setupLongTextField
{
    [self defaultSetupTextField:self.longMessageTextField];
    
    [self.longMessageTextField bs_setupErrorMessageViewWithMessage:@"The error message was too long to show in the text box hence it will come up as an alert avoiding clipping of messages!, you can customize the alert button text as well!"];
}

- (void)setupPassTextField
{
    [self defaultSetupTextField:self.passTextField];
    
    BSErrorMessageView *errorMessageView = [BSErrorMessageView errorMessageViewWithMessage:@"Minimum 6 characters"];
    errorMessageView.mainTintColor = [UIColor greenColor];
    errorMessageView.textFont = [UIFont systemFontOfSize:14.f];
    errorMessageView.messageAlwaysShowing = YES;
    
    [self.passTextField bs_setupErrorMessageViewWithView:errorMessageView];
}

- (IBAction)enterButtonAction
{
    if ( self.loginTextField.text.length < 6 )
    {
        [self.loginTextField bs_showError];
    }
    
    if ( self.passTextField.text.length < 6 )
    {
        [self.passTextField bs_showError];
    }
    
    [self.longMessageTextField bs_showError];
}

#pragma mark - Helpers
- (void)defaultSetupTextField:(UITextField *)textField
{
    textField.layer.borderColor = [[[UIColor lightGrayColor] colorWithAlphaComponent:0.5f] CGColor];
    textField.layer.borderWidth = 0.5f;
    textField.layer.cornerRadius = 5.f;
    
    UIView *paddingView = [UIView new];
    paddingView.frame = (CGRect){0.f, 0.f, 10.f, 10.f};
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.leftView = paddingView;
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textField bs_hideError];
}

@end

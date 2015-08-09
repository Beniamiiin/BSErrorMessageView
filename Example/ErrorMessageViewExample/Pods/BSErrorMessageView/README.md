# BSErrorMessageView
Error message view for text field

### Install
`pod 'BSErrorMessageView',  :git => 'https://github.com/BenjaminSarkisyan/BSErrorMessageView.git'`

### Usage
Setup message view with default settings
```
[self.loginTextField bs_setupErrorMessageViewWithMessage:@"Minimum 3 characters"];
[self.emailTextField bs_setupErrorMessageViewWithMessage:@"Incorrect email format"];
```
Or if you want setup message view, then
</br>
```
BSErrorMessageView *errorMessageView = [BSErrorMessageView errorMessageViewWithMessage:@"Minimum 3 characters"];
errorMessageView.tintColor = [UIColor greenColor];
errorMessageView.textFont = [UIFont systemFontOfSize:16.f];

[self.loginTextField bs_setupErrorMessageViewWithView:errorMessageView];
```
Show/hide methods
```
[self.loginTextField bs_showError];
[self.emailTextField bs_hideError];
```

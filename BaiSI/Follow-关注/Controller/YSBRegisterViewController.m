//
//  YSBRegisterViewController.m
//  Yuansubei
//
//  Created by Mac on 17/3/28.
//  Copyright © 2017年 HJQ. All rights reserved.
//

#import "YSBRegisterViewController.h"
#import "UIButton+countDown.h"

@interface YSBRegisterViewController ()<UITextFieldDelegate>
@property (nonatomic,strong)MBProgressHUD *HUD;
@property (weak, nonatomic) IBOutlet UIButton *choiceBut;
//用户手机号
@property (weak, nonatomic) IBOutlet UITextField *numberField;
//密码
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
//确认密码
@property (weak, nonatomic) IBOutlet UITextField *sureField;
//推荐
@property (weak, nonatomic) IBOutlet UITextField *recommendField;
//验证码
@property (weak, nonatomic) IBOutlet UITextField *sureCodeField;
//协议书按钮
@property (weak, nonatomic) IBOutlet UIButton *agreementBut;
/** 任务管理者 */
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@end

@implementation YSBRegisterViewController
- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager];
    keyboardManager.shouldResignOnTouchOutside = YES;
    keyboardManager.keyboardDistanceFromTextField = 120;
    [self createLoveGroup];

}
- (IBAction)codeBut:(id)sender {
    UIButton *btn = sender;
    [btn startWithTime:30 title:@"获取验证码" countDownTitle:@"s" mainColor:[UIColor colorWithRed:156/255.0 green:170/255.0 blue:170/255.0 alpha:1.0f] countColor:[UIColor lightGrayColor]];

    //验证码
    if ([self validateMobile:self.numberField.text] == YES) {
        if ( (_passwordField.text.length >=6 && _passwordField.text.length <= 20)&&(_sureField.text.length >=6 && _sureField.text.length <= 20)&&([self.passwordField.text isEqualToString: self.sureField.text])) {//判断两次密码是否相等
            if (self.recommendField.text) {
                //有推荐人  请求验证码
                

            }else{
                //无推荐人  请求验证码
            }
            
        }else if(_passwordField.text.length == 0 || _sureField.text.length == 0){
            self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            self.HUD.label.text = @"密码不能为空!";
            [self.HUD hideAnimated:YES afterDelay:.8];
        }else if(!(_passwordField.text.length >=6 && _passwordField.text.length <= 20) || !(_sureField.text.length >=6 && _sureField.text.length <= 20)){
            self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            self.HUD.label.text = @"密码格式不正确!";
            [self.HUD hideAnimated:YES afterDelay:.8];
        }else if (![self.passwordField.text isEqualToString: self.sureField.text]){
            self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            self.HUD.label.text = @"两次输入密码不匹配!";
            [self.HUD hideAnimated:YES afterDelay:.8];
        }
        
    }else if ([self validateMobile:self.numberField.text] == NO){
        self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.HUD.label.text = @"请输入正确手机号";
        [self.HUD hideAnimated:YES afterDelay:.8];
    }
}
- (IBAction)registerBut:(id)sender {
    //注册
    NSString *username = self.numberField.text;
    NSString *password = self.passwordField.text;
    NSString *code = self.sureCodeField.text;
    NSString *referee_username  = self.recommendField.text;
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"username"] = username;
    parameters[@"password"] = password;
    parameters[@"code"] = code;
    parameters[@"referee_username"] = referee_username;
    if ([self validateMobile:self.numberField.text] == YES) {
        if ( (_passwordField.text.length >=6 && _passwordField.text.length <= 20)&&(_sureField.text.length >=6 && _sureField.text.length <= 20)&&([self.passwordField.text isEqualToString: self.sureField.text])) {//判断两次密码是否相等
            if (self.recommendField.text) {
                //有推荐人
                
                    if (self.loveGroup.checkedCheckBoxes.count > 0) {
                        NSLog(@"已同意协议");
                        
                    }else if (self.loveGroup.uncheckedCheckBoxes.count > 0){
                        NSLog(@"请同意用户协议");
                        self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                        self.HUD.label.text = @"请同意用户协议";
                        [self.HUD hideAnimated:YES afterDelay:.8];
                    }
                
            }else{
                //验证码的判断
                if (code) {
                    //协议判断
                    if (self.loveGroup.checkedCheckBoxes.count > 0) {
                        NSLog(@"已同意协议");
                        
                        
                    }else if (self.loveGroup.uncheckedCheckBoxes.count > 0){
                        NSLog(@"请同意用户协议");
                        self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                        self.HUD.label.text = @"请同意用户协议";
                        [self.HUD hideAnimated:YES afterDelay:.8];
                    }
                }else{
                    //验证码不对
                }
            }
        
        }else if(_passwordField.text.length == 0 || _sureField.text.length == 0){
            self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            self.HUD.label.text = @"密码不能为空!";
            [self.HUD hideAnimated:YES afterDelay:.8];
        }else if(!(_passwordField.text.length >=6 && _passwordField.text.length <= 20) || !(_sureField.text.length >=6 && _sureField.text.length <= 20)){
            self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            self.HUD.label.text = @"密码格式不正确!";
            [self.HUD hideAnimated:YES afterDelay:.8];
        }else if (![self.passwordField.text isEqualToString: self.sureField.text]){
            self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            self.HUD.label.text = @"两次输入密码不匹配!";
            [self.HUD hideAnimated:YES afterDelay:.8];
        }
        
    }else if ([self validateMobile:self.numberField.text] == NO){
        self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.HUD.label.text = @"请输入正确手机号";
        [self.HUD hideAnimated:YES afterDelay:.8];
    }

}
- (IBAction)agreementBut:(id)sender {
    //协议书
}
- (IBAction)close:(id)sender {
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark 判断是否是手机号
- (BOOL)validateMobile:(NSString *)mobile
{
    // 130-139  150-153,155-159  180-189  145,147  170,171,173,176,177,178
    NSString *phoneRegex = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0678])\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}
- (void)createLoveGroup {
    
    TNImageCheckBoxData *manData = [[TNImageCheckBoxData alloc] init];
    //manData.identifier = @"man";
    //manData.labelText = @"Man";
    manData.checkedImage = [UIImage imageNamed:@"形状-1"];
    manData.uncheckedImage = [UIImage imageNamed:@"未标题-2"];
    
    self.loveGroup = [[TNCheckBoxGroup alloc] initWithCheckBoxData:@[manData] style:TNCheckBoxLayoutVertical];
    [self.loveGroup create];
    
    self.loveGroup.position = CGPointMake(self.choiceBut.width/2,self.choiceBut.height/7);
    
    [self.choiceBut addSubview:self.loveGroup];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loveGroupChanged:) name:GROUP_CHANGED object:self.loveGroup];
}
- (void)loveGroupChanged:(NSNotification *)notification {
    
    NSLog(@"Checked checkboxes %@", self.loveGroup.checkedCheckBoxes);
    NSLog(@"Unchecked checkboxes %@", self.loveGroup.uncheckedCheckBoxes);
    
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:GROUP_CHANGED object:self.loveGroup];
}
//- (void)textViewDidBeginEditing:(UITextField *)textView{
//    CGRect frame = textView.frame;
//    int offset = frame.origin.y + 120 - (self.view.frame.size.height - 216.0);//键盘高度216
//    NSTimeInterval animationDuration = 0.30f;
//    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
//    [UIView setAnimationDuration:animationDuration];
//    float width = self.view.frame.size.width;
//    float height = self.view.frame.size.height;
//    if(offset > 0) {
//        CGRect rect = CGRectMake(0.0f, -offset,width,height);
//        self.view.frame = rect; } [UIView commitAnimations];
//}
//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    //  退出键盘
//    [self.view endEditing:YES];
//    
//}
#pragma mark UITextFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    //当开始点击textField会调用的方法
    NSLog(@"正在输入 %@",textField);
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    //当textField编辑结束时调用的方法
    
    NSLog(@"编辑结束 %@",textField);
}

//按下Done按钮的调用方法，我们让键盘消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
}

@end

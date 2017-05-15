//
//  YSBLoginViewController.m
//  Yuansubei
//
//  Created by Mac on 17/3/28.
//  Copyright © 2017年 HJQ. All rights reserved.
//

#import "YSBLoginViewController.h"
#import "YSBRegisterViewController.h"
#import "ForgetViewController.h"

@interface YSBLoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userF;
@property (weak, nonatomic) IBOutlet UITextField *passwordF;
@property (nonatomic,strong)MBProgressHUD *HUD;
/** 任务管理者 */
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@end

@implementation YSBLoginViewController
- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTextF];
}
- (void)setupTextF{

//    _shoujihaoF.delegate = self;
//    self.shoujihaoF.tag = 1000;
//    
//    _PasswordF.delegate = self;
//    self.PasswordF.tag = 1001;

}

- (IBAction)close:(id)sender {
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 登录/注册/忘记密码 按钮点击
- (IBAction)LoginBut:(id)sender {
    NSString *username = self.userF.text;
    NSString *password = self.passwordF.text;
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"username"] = username;
    parameters[@"password"] = password;
    if (username.length == 0 || password.length == 0 ) {
        self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.HUD.label.text = @"请输入账户密码!";
        [self.HUD hideAnimated:YES afterDelay:.8];
    }else{
    
        if ([self validateMobile:self.userF.text] == YES) {//判断是否为手机号码
            NSLog(@"是手机号码");
            if ( password.length >=6 && password.length <= 20) {
                NSLog(@"正在登录");
                [self.manager POST:@"http://192.168.1.250/login" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
                    [responseObject writeToFile:@"/Users/mac/Desktop/YSB.plist" atomically:YES];
                    NSLog(@"%@",responseObject[@"status"]);
                    if ([responseObject[@"status"] isEqualToString:@"true"]) {
                        NSLog(@"登入中");
                    }else{
                        NSLog(@"用户不存在/用户名密码错误！");
                    }

                } failure:^(NSURLSessionDataTask *task, NSError *error) {
                    
                }];

            }else{
                self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                self.HUD.label.text = @"请输入6至20位的服务密码";
                [self.HUD hideAnimated:YES afterDelay:.8];
            }
        }else if ([self validateMobile:self.userF.text] == NO){
            
            NSLog(@"不是合法号码");
            self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            self.HUD.label.text = @"请输入正确的手机号";
            [self.HUD hideAnimated:YES afterDelay:.8];
            
        }
        
    }
    
}
#pragma mark 判断是否是手机号
- (BOOL)validateMobile:(NSString *)mobile
{
    // 130-139  150-153,155-159  180-189  145,147  170,171,173,176,177,178
    NSString *phoneRegex = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0678])\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

- (IBAction)RegisterBut:(id)sender {
    YSBRegisterViewController *RVC = [[YSBRegisterViewController alloc]init];
    [self presentViewController:RVC animated:YES completion:nil];
}
- (IBAction)ForgetBut:(id)sender {
    ForgetViewController *ForgetVC = [[ForgetViewController alloc]init];
    [self presentViewController:ForgetVC animated:YES completion:nil];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //  退出键盘
    [self.view endEditing:YES];
    
}
#pragma mark UITextFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    //当开始点击textField会调用的方法
    NSLog(@"正在输入");
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    //当textField编辑结束时调用的方法
    UITextField *TF = (UITextField *)[self.view viewWithTag:1000];
    
    if (textField.tag == 1000) {
        //self.shoujihaoF.text = textField.text;
        NSLog(@"账户编辑结束 %@--%ld",TF.text,textField.tag);
    }else if (textField.tag == 1001){
        //self.PasswordF.text = textField.text;
        NSLog(@"密码编辑结束 %@--%ld",self.passwordF.text,textField.tag);
    }else{
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    //获取点击键盘按钮的值
    NSLog(@"%@", NSStringFromRange(range));
    NSLog(@"%@", string);
    //NSLog(@"---%@", textField.text);
    return YES;
    
}
//按下Done按钮的调用方法，我们让键盘消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
}

@end

//
//  HSRegisterViewController.m
//  tngouHealth
//
//  Created by hou on 16/4/20.
//  Copyright © 2016年 houshuai. All rights reserved.
//

#import "HSRegisterViewController.h"
//MOB短信验证
#import <SMS_SDK/SMSSDK.h>
//环信注册
#import "EMClient.h"
#import "UMComBarButtonItem.h"
#import "NSString+HSString.h"

@interface HSRegisterViewController ()
/** 用户名*/
@property (weak, nonatomic) IBOutlet UITextField *userNameField;
/** 用户密码*/
@property (weak, nonatomic) IBOutlet UITextField *uesrPasswordField;
/** 用户输入的验证码*/
@property (weak, nonatomic) IBOutlet UITextField *codeField;
/** 获取验证码按钮*/
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;


@end

@implementation HSRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *leftButtonItem = [[UMComBarButtonItem alloc] initWithNormalImageName:@"Backx" target:self action:@selector(onClickClose)];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    self.navigationItem.title = @"注册";
}
- (void)onClickClose
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//获取验证码
- (IBAction)clickGetCodeBtn:(id)sender {
    
    
    if (![NSString isPhone:self.userNameField.text]) {
        [MBProgressHUD showError:@"输入正确手机号"];
        return;
    }
    
    
    
    /**
     *  @from                    v1.1.1
     *  @brief                   获取验证码(Get verification code)
     *
     *  @param method            获取验证码的方法(The method of getting verificationCode)
     *  @param phoneNumber       电话号码(The phone number)
     *  @param zone              区域号，不要加"+"号(Area code)
     *  @param customIdentifier  自定义短信模板标识 该标识需从官网http://www.mob.com上申请，审核通过后获得。(Custom model of SMS.  The identifier can get it  from http://www.mob.com  when the application had approved)
     *  @param result            请求结果回调(Results of the request)
     */
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.userNameField.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
        if (error) {
            DLog(@"验证码获取失败,%@",error);
            [MBProgressHUD showError:@"验证码获取失败"];
        }else{
            DLog(@"验证码已发送");
            [MBProgressHUD showSuccess:@"验证码已发送"];
        }
    }];
    
}
//注册按钮
- (IBAction)clickRegisterBtn:(id)sender {
    if (self.uesrPasswordField.text.length < 1) {
        [MBProgressHUD showError:@"请设置密码"];
        return;
    }
    if (self.codeField.text.length < 1) {
        [MBProgressHUD showError:@"请输入验证码"];
    }
    
    
    //先进行验证码验证
    [SMSSDK commitVerificationCode:self.codeField.text phoneNumber:self.userNameField.text zone:@"86" result:^(NSError *error) {
        if (!error) {
            DLog(@"验证码验证成功");
        }
        else
        {
            DLog(@"错误信息:%@",error);
            [MBProgressHUD showError:@"验证码错误"];
            return;
        }
    }];

    //再进行环信注册
    EMError *error = [[EMClient sharedClient] registerWithUsername:self.userNameField.text password:self.uesrPasswordField.text];
    if (error == nil) {
        DLog(@"环信注册成功");
        [MBProgressHUD showSuccess:@"注册成功"];
        [self.navigationController popViewControllerAnimated:YES];
        
    }else{
        DLog(@"%@",error);
        [MBProgressHUD showSuccess:@"网络错误"];
    }
    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:NO];
}


@end

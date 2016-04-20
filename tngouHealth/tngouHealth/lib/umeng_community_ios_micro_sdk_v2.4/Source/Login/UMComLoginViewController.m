//
//  UMComLoginViewController.m
//  UMCommunity
//
//  Created by Gavin Ye on 8/25/14.
//  Copyright (c) 2014 Umeng. All rights reserved.
//

#import "UMComLoginViewController.h"
#import "UMSocial.h"
#import "UMComHttpClient.h"
#import "UMComSession.h"
#import "UMComHttpManager.h"
#import "UMComShowToast.h"
#import "UMComBarButtonItem.h"
#import "WXApi.h"
#import "UIViewController+UMComAddition.h"
//注册界面
#import "HSRegisterViewController.h"
//环信登录
#import "EMClient.h"
//um社区登录
#import "UMComLoginManager.h"
#import "UMComPushRequest.h"
@interface UMComLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *userPasswordTextField;

@end

@implementation UMComLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.sinaLoginButton.tag = UMSocialSnsTypeSina;
//    self.qqLoginButton.tag = UMSocialSnsTypeMobileQQ;
//    self.wechatLoginButton.tag = UMSocialSnsTypeWechatSession;
//    
//    if ([UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ]) {
//        [self.qqLoginButton setImage:UMComImageWithImageName(@"tencentx") forState:UIControlStateNormal];
//    }
//    if ([UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession]) {
//        [self.wechatLoginButton setImage:UMComImageWithImageName(@"wechatx") forState:UIControlStateNormal];
//    }
    
    [self.sinaLoginButton addTarget:self action:@selector(onClickLogin:) forControlEvents:UIControlEventTouchUpInside];
//    [self.qqLoginButton addTarget:self action:@selector(onClickLogin:) forControlEvents:UIControlEventTouchUpInside];
//    [self.wechatLoginButton addTarget:self action:@selector(onClickLogin:) forControlEvents:UIControlEventTouchUpInside];
//    [self.closeButton addTarget:self action:@selector(onClickClose) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftButtonItem = [[UMComBarButtonItem alloc] initWithNormalImageName:@"Backx" target:self action:@selector(onClickClose)];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    [self setTitleViewWithTitle:UMComLocalizedString(@"Login_Title", @"登录")];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:NO];
}
- (void)onClickClose
{
//    [UIView setAnimationsEnabled:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  登录按钮
 *
 *  @param sender 实现逻辑,先验证环信账号是否正确,正确再进行UM社区登录
 */
- (IBAction)clickLoginBtn:(id)sender {
    
    if (self.userNameTextField.text.length < 1) {
        [MBProgressHUD showError:@"请输入用户名"];
        return;
    }
    if (self.userPasswordTextField.text.length < 1) {
        [MBProgressHUD showError:@"请输入密码"];
        return;
    }
    EMError *error = [[EMClient sharedClient] loginWithUsername:self.userNameTextField.text password:self.userPasswordTextField.text];
    if (error == nil) {
        DLog(@"环信登录成功");
        [self UMLogin];
    }else{
        DLog(@"%@",error);
        [MBProgressHUD showError:@"用户名或密码错误"];
    }

}
//UM社区登录
-(void)UMLogin
{
    //使用UMComSnsTypeSelfAccount代表自定义登录，该枚举类型必须和安卓SDK保持一致，否则会出现不能对应同一用户的问题
    UMComUserAccount *userAccount = [[UMComUserAccount alloc] initWithSnsType:UMComSnsTypeSelfAccount];
    userAccount.usid = self.userNameTextField.text;
    userAccount.name = self.userNameTextField.text;
    userAccount.iconImage = [UIImage imageNamed:@"userIcon"];
    //登录之前先设置登录前的viewController，方便登录逻辑完成之后，跳转回来
    [UMComPushRequest loginWithUser:userAccount completion:^(id responseObject, NSError *error) {
        if(!error){
            //登录成功
            DLog(@"UM社区自动登录成功");
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
            
        }else{
            DLog(@"UM社区自动登录失败,%@",error);
        }
    }];
    
}
//注册按钮
- (IBAction)clickRegisterBtn:(id)sender {
    HSRegisterViewController *vc = [HSRegisterViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}





- (void)onClickLogin:(UIButton *)button
{
    NSString *snsName = nil;
    switch (button.tag) {
        case UMSocialSnsTypeSina:
            snsName = UMShareToSina;
            break;
        case UMSocialSnsTypeMobileQQ:
            snsName = UMShareToQQ;
            break;
        case UMSocialSnsTypeWechatSession:
            snsName = UMShareToWechatSession;
            break;
        default:
            break;
    }
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:snsName];
    if (!snsPlatform) {
        [UMComShowToast notSupportPlatform];
    } else if ([snsName isEqualToString:UMShareToWechatSession] && ![WXApi isWXAppInstalled]){
        [UMComShowToast showNotInstall];
    } else {
        snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity * response){

            if (response.responseCode == UMSResponseCodeSuccess) {
                [[UMSocialDataService defaultDataService] requestSnsInformation:snsPlatform.platformName completion:^(UMSocialResponseEntity *userInfoResponse) {
                    UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:snsPlatform.platformName];
                    UMComSnsType snsType = UMComSnsTypeOther;
                    if ([snsPlatform.platformName isEqualToString:UMShareToSina]) {
                        snsType = UMComSnsTypeSina;
                    } else if ([snsPlatform.platformName isEqualToString:UMShareToWechatSession]){
                        snsType = UMComSnsTypeWechat;
                    } else if ([snsPlatform.platformName isEqualToString:UMShareToQQ]){
                        snsType = UMComSnsTypeQQ;
                    }
                    UMComUserAccount *account = [[UMComUserAccount alloc] initWithSnsType:snsType];
                    account.usid = snsAccount.usid;
                    account.custom = @"这是一个自定义字段，可以改成自己需要的数据";
                    if (response.responseCode == UMSResponseCodeSuccess) {
                        if ([userInfoResponse.data valueForKey:@"screen_name"]) {
                            account.name = [userInfoResponse.data valueForKey:@"screen_name"];
                        }
                        if ([userInfoResponse.data valueForKey:@"profile_image_url"]) {
                            account.icon_url = [userInfoResponse.data valueForKey:@"profile_image_url"];
                        }
                        if ([userInfoResponse.data valueForKey:@"gender"]) {
                            account.gender = [userInfoResponse.data valueForKey:@"gender"] ;
                        }
                    }
                    [UMComLoginManager loginWithLoginViewController:self userAccount:account loginCompletion:^(id responseObject, NSError *error) {
                        [self dismissViewControllerAnimated:YES completion:nil];
                    }];
                }];
                
            } else {
                    [UMComLoginManager loginWithLoginViewController:self userAccount:nil loginCompletion:^(id responseObject, NSError *error) {
                        [self dismissViewControllerAnimated:YES completion:nil];
                    }];
            }
        });
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

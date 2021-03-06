//
//  LoginViewController.m
//  waiter
//
//  Created by sjlh on 2017/4/13.
//  Copyright © 2017年 liuchao. All rights reserved.
//

#import "LoginViewController.h"
#import "AlterViewController.h"
#import "PDKeyChain.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) DBWaiterInfo * user;
@property (weak, nonatomic) IBOutlet UITextField *userIDField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.loginButton.layer.cornerRadius = 5.0f;
    
    self.userIDField.text = @"";
    self.pwdField.text = @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 2;
    }
    else
    {
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 56;
}

- (IBAction)loginPressed:(id)sender
{
    DBDeviceInfo *deviceInfo = [[DataBaseManager defaultInstance] getDeviceInfo];
    if (deviceInfo.deviceId && [deviceInfo.deviceId rangeOfString:@":"].location != NSNotFound)
    {
        [self login];
    }else
    {
        [[FMDHCPNetService shareDHCPNetService] localMacAddress:^(NSString *macAddr)
        {
            if (macAddr)
            {
                deviceInfo.deviceId = macAddr;
                [[DataBaseManager defaultInstance] saveContext];
            }else
            {
                NSString * deviceId = @"";
                if (![PDKeyChain keyChainLoad])
                {
                    deviceId = [Util getUUID];
                    [PDKeyChain keyChainSave:deviceId];
                }else
                {
                    deviceId = [PDKeyChain keyChainLoad];
                }
                deviceInfo.deviceId = deviceId;
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self login];
            });
            
        }];
    }
}
- (void)login
{
    if ([self.userIDField.text isEqualToString:@""] || [self.pwdField.text isEqualToString:@""])
    {
        [self.userIDField resignFirstResponder];
        [self.pwdField resignFirstResponder];
        [MySingleton systemAlterViewOwner:self WithMessage:@"账号或密码不能为空!"];
        return;
    }
    if (self.pwdField.text.length < 6 || self.pwdField.text.length > 18) {
        [MySingleton systemAlterViewOwner:self WithMessage:@"密码不能小于6位或者大于18位！"];
    }
    
    DBDeviceInfo * deviceInfo = [[DataBaseManager defaultInstance] getDeviceInfo];
    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
    [params setObject:self.userIDField.text forKey:@"empNo"];
    [params setObject:self.pwdField.text forKey:@"password"];
    [params setObject:deviceInfo.deviceId forKey:@"deviceId"];
    [params setObject:deviceInfo.deviceToken forKey:@"deviceToken"];
    [params setObject:@"2" forKey:@"deviceType"];
    
    [[NetworkRequestManager defaultManager] POST_Url:URI_WAITER_Login Params:params withByUser:YES Success:^(NSURLSessionTask *task, id dataSource, NSString *message, NSString *url) {
        
        _user = dataSource;
        [[DataBaseManager defaultInstance] saveContext];
        if ([_user.resetPwdDiv isEqualToString:@"0"])
        {
            [self performSegueWithIdentifier:@"goChangePassword" sender:nil];
        }
        else
        {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        
    } Failure:^(NSURLSessionTask *task, NSString *message, NSString *status, NSString *url) {
        NSLog(@"message --- %@",message);
        [self.userIDField resignFirstResponder];
        [self.pwdField resignFirstResponder];
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
        
    }];

}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

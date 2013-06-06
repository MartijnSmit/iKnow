//
//  LoginViewController.h
//  iKnow
//
//  Created by Martijn Smit on 23-05-13.
//  Copyright (c) 2013 WeMa IT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IKEmployee.h"

@class ViewController;

@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) ViewController *parentView;

- (IBAction)recoveryPassword:(id)sender;
- (IBAction)login:(id)sender;
@end

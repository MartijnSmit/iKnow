//
//  ProfileViewController.h
//  iKnow
//
//  Created by Martijn Smit on 04-06-13.
//  Copyright (c) 2013 WeMa IT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "IKEmployee.h"
#import "IKSkill.h"

@interface ProfileViewController : UIViewController <MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *twitterLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *skillLabel;
@property (weak, nonatomic) IBOutlet UILabel *skillPercentage;
@property (weak, nonatomic) IBOutlet UITextView *skillDescription;
@property (weak, nonatomic) IBOutlet UIButton *emailButton;
- (IBAction)openEmail:(id)sender;

@end

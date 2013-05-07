//
//  TwitterItemViewController.h
//  AriensZorgpalet
//
//  Created by Martijn Smit on 11-09-12.
//  Copyright (c) 2012 WeMa IT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TwitterItemViewController : UIViewController {
    IBOutlet UIImageView *profileImage;
    IBOutlet UILabel *nameLabel;
    IBOutlet UITextView *twitterTextbox;
}

@property (strong, nonatomic) id detailItem;

@property (strong, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end

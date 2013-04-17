//
//  ViewController.h
//  iKnow
//
//  Created by Martijn Smit on 17-04-13.
//  Copyright (c) 2013 WeMa IT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *btn_1;
@property (weak, nonatomic) IBOutlet UIButton *btn_2;
- (IBAction)openList:(id)sender;
- (IBAction)closeList:(id)sender;

@end

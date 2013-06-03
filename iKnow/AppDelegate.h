//
//  AppDelegate.h
//  iKnow
//
//  Created by Martijn Smit on 17-04-13.
//  Copyright (c) 2013 WeMa IT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IKEmployee.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) IKEmployee *sessionEmployee;

+ (AppDelegate*)sharedAppDelegate;

@end

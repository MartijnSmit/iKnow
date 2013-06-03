//
//  Encryption.h
//  iKnow
//
//  Created by Martijn Smit on 23-05-13.
//  Copyright (c) 2013 WeMa IT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Encryption : NSObject

+ (NSString *) encrypt:(NSString *)text;
+ (NSString *) decrypt:(NSString *)text;

@end

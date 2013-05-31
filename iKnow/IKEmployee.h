//
//  IKEmployee.h
//  Taglist
//
//  Created by Mark ter Luun on 29-05-13.
//  Copyright (c) 2013 Vestech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IKEmployee : NSObject

@property (nonatomic, assign, readonly) NSInteger ID;
@property (nonatomic, strong, readonly) NSString *firstName;
@property (nonatomic, strong, readonly) NSString *lastName;
@property (nonatomic, strong, readonly) NSString *email;
@property (nonatomic, strong, readonly) UIImage *photo;
@property (nonatomic, strong, readonly) NSArray *skills;

+ (NSArray*)employeesFromService;
+ (BOOL)login:(NSString*)email password:(NSString*)password;

- (id)initWithValuesFromDictionary:(NSDictionary*)dictionary;
- (BOOL)login:(NSString*)password;

@end

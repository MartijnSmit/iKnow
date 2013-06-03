//
//  IKSkill.m
//  iKnow
//
//  Created by Mark ter Luun on 03-06-13.
//  Copyright (c) 2013 WeMa IT. All rights reserved.
//

#import "IKSkill.h"
#import "IKTag.h"
#import "IKEmployee.h"

@implementation IKSkill

- (NSString*)description
{
    return [NSString stringWithFormat:@"%@, %d", _tag, _rating];
}

- (id)initWithEmployee:(IKEmployee *)employee tag:(IKTag *)tag rating:(NSInteger)rating
{
    _employee = employee;
    _tag = tag;
    _rating = rating;
    
    return [self init];
}

- (id)initWithValuesFromDictionary:(NSDictionary *)dictionary forEmployee:(IKEmployee*)employee
{
    _employee = employee;
    _tag = [[IKTag alloc] initWithValuesFromDictionary:[dictionary objectForKey:@"Key"]];
    _rating = [[dictionary objectForKey:@"Value"] integerValue];
    
    return [self init];
}

@end

//
//  IKSearchResult.m
//  iKnow
//
//  Created by Mark ter Luun on 06-06-13.
//  Copyright (c) 2013 WeMa IT. All rights reserved.
//

#import "IKSearchResult.h"

@implementation IKSearchResult

- (NSString*)description
{
    return [NSString stringWithFormat:@"%@ %@ - %d%%", [_employee firstName], [_employee lastName], _relevance];
}

- (id)initWithEmployee:(IKEmployee *)employee relevance:(NSInteger)relevance
{
    _employee = employee;
    _relevance = relevance;
    return [self init];
}

- (id)initWithValuesFromDictionary:(NSDictionary *)dictionary
{
    _employee = [[IKEmployee alloc] initWithValuesFromDictionary:[dictionary objectForKey:@"Key"]];
    _relevance = [[NSString stringWithFormat:@"%@", [dictionary objectForKey:@"Value"]] integerValue];
    return [self init];
}

@end

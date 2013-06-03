//
//  IKSkill.h
//  iKnow
//
//  Created by Mark ter Luun on 03-06-13.
//  Copyright (c) 2013 WeMa IT. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IKTag;
@class IKEmployee;

@interface IKSkill : NSObject

@property (strong, nonatomic) IKEmployee *employee;
@property (strong, nonatomic) IKTag *tag;
@property (assign, nonatomic) NSInteger rating;

- (id)initWithEmployee:(IKEmployee*)employee tag:(IKTag*)tag rating:(NSInteger)rating;
- (id)initWithValuesFromDictionary:(NSDictionary*)dictionary forEmployee:(IKEmployee*)employee;

@end

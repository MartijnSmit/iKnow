//
//  IKSearchResult.h
//  iKnow
//
//  Created by Mark ter Luun on 06-06-13.
//  Copyright (c) 2013 WeMa IT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IKEmployee.h"

@interface IKSearchResult : NSObject

@property (nonatomic, strong) IKEmployee *employee;
@property (nonatomic, assign) NSInteger relevance;

- (id)initWithEmployee:(IKEmployee*)employee relevance:(NSInteger)relevance;
- (id)initWithValuesFromDictionary:(NSDictionary*)dictionary;

@end

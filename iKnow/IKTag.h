//
//  IKTag.h
//  Taglist
//
//  Created by Mark ter Luun on 21-05-13.
//  Copyright (c) 2013 Vestech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IKTag : NSObject

@property (nonatomic, assign, readonly) NSInteger ID;
@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong) NSString *tagDescription;

- (id)initWithValuesFromDictionary:(NSDictionary*)dictionary;
- (id)initWithID:(NSInteger)tagID
            name:(NSString*)name;
+ (NSArray*)tagsFromService;

@end

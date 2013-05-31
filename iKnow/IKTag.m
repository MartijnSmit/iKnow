//
//  IKTag.m
//  Taglist
//
//  Created by Mark ter Luun on 21-05-13.
//  Copyright (c) 2013 Vestech. All rights reserved.
//

#import "IKTag.h"

@implementation IKTag

- (id)initWithValuesFromDictionary:(NSDictionary *)dictionary
{
    _ID = (NSInteger)[dictionary objectForKey:@"ID"];
    _name = [dictionary objectForKey:@"TagName"];
    _tagDescription = [dictionary objectForKey:@"Description"];
    
    return [self init];
}

- (id)initWithID:(NSInteger)tagID
            name:(NSString *)name
{
    _ID = tagID;
    _name = name;
    
    return [self init];
}

- (NSString*)description
{
    return [NSString stringWithFormat:@"%d\t%@\n%@\n\n", _ID, _name, _tagDescription];
}

+ (NSArray*)tagsFromService
{
    // Load the tags from the service
    NSURL *url = [NSURL URLWithString:@"http://92.70.42.51:8000/IknowService.svc/tags"];
    NSData *response = [NSData dataWithContentsOfURL:url];
    
    // Projecess the response
    NSError *error;
    NSDictionary *jsonRoot = [NSJSONSerialization JSONObjectWithData:response
                                                             options:kNilOptions
                                                               error:&error];
    NSArray *jsonTags = [jsonRoot objectForKey:@"result"];
    
    // Compose the return value
    NSMutableArray *tags = [[NSMutableArray alloc] init];
    for (NSDictionary *tagDict in jsonTags)
    {
        IKTag *tag = [[IKTag alloc] initWithValuesFromDictionary:tagDict];
        [tags addObject:tag];
    }
    
    return tags;
}

@end

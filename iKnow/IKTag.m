//
//  IKTag.m
//  Taglist
//
//  Created by Mark ter Luun on 21-05-13.
//  Copyright (c) 2013 Vestech. All rights reserved.
//

#import "IKTag.h"

@implementation IKTag

- (NSString*)description
{
    return _name;
}

- (id)initWithValuesFromDictionary:(NSDictionary *)dictionary
{
    _ID = [[dictionary objectForKey:@"ID"] integerValue];
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
    for (NSDictionary *tagDict in jsonTags) {
        IKTag *tag = [[IKTag alloc] initWithValuesFromDictionary:tagDict];
        [tags addObject:tag];
    }
    
    return tags;
}

+ (NSArray*)searchEmployeesByTags:(NSArray *)tags
{
    // Compose the search string
    NSMutableString *query = [[NSMutableString alloc] init];
    for (IKTag *tag in tags) {
        // Escape the tag name
        NSString *escaptedTagName = (NSString*)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (__bridge CFStringRef)[tag name], NULL, CFSTR("!*'();:@&=+$,/?%#[]"), kCFStringEncodingUTF8));
        
        // Append the tag name
        if ([query length] > 0) {
            [query appendString:@","];
        }
        [query appendString:escaptedTagName];
    }
    NSLog(@"%@", query);
    
    // Load the search results from the service
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://92.70.42.51:8000/IknowService.svc/search/%@", query]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    // Process the response
    NSError *error;
    NSDictionary *jsonRoot = [NSJSONSerialization JSONObjectWithData:data
                                                            options:kNilOptions
                                                              error:&error];
    NSArray *searchResults = [jsonRoot objectForKey:@"result"];
    NSLog(@"%@", searchResults);
    
    // Compose the return value
    NSMutableArray *results = [[NSMutableArray alloc] init];
    for (NSDictionary *resultDict in searchResults) {
        IKSearchResult *result = [[IKSearchResult alloc] initWithValuesFromDictionary:resultDict];
        [results addObject:result];
    }
    return results;
}

@end

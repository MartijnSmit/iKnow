//
//  IKEmployee.m
//  Taglist
//
//  Created by Mark ter Luun on 29-05-13.
//  Copyright (c) 2013 Vestech. All rights reserved.
//
// Mark

#import "IKEmployee.h"

@implementation IKEmployee {
    NSInteger token;
}

- (NSString*)description
{
    return [NSString stringWithFormat:@"ID: %d\nName: %@\nE-Mail: %@\nSkills: %@",
            _ID,
            [NSString stringWithFormat:@"%@, %@",
             _lastName,
             _firstName],
            _email,
            _skills];
}

- (id)initWithValuesFromDictionary:(NSDictionary *)dictionary
{
    // Simple values
    _ID = (NSInteger)[dictionary objectForKey:@"ID"];
    _firstName = [dictionary objectForKey:@"FirstName"];
    _lastName = [dictionary objectForKey:@"LastName"];
    _email = [dictionary objectForKey:@"Email"];
    
    // Photo
    NSString *photoName = [dictionary objectForKey:@"Photo"];
    NSURL *photoURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://92.70.42.51:8000/IknowService.svc/getimage/%@", photoName]];
    NSData *photoData = [NSData dataWithContentsOfURL:photoURL];
    _photo = [UIImage imageWithData:photoData];
    
    // Skills
    // nog te implemeteren
    
    // Return the object
    return [self init];
}

+ (NSArray*)employeesFromService
{
    // Load the tags from the service
    NSURL *url = [NSURL URLWithString:@"http://92.70.42.51:8000/IknowService.svc/employees"];
    NSData *response = [NSData dataWithContentsOfURL:url];
    
    // Process the response
    NSError *error;
    NSDictionary *jsonRoot = [NSJSONSerialization JSONObjectWithData:response
                                                             options:kNilOptions
                                                               error:&error];
    NSArray *jsonEmployees = [jsonRoot objectForKey:@"result"];
    
    // Compose the return value
    NSMutableArray *employees = [[NSMutableArray alloc] init];
    for (NSDictionary *employeeDict in jsonEmployees) {
        IKEmployee *employee = [[IKEmployee alloc] initWithValuesFromDictionary:employeeDict];
        [employees addObject:employee];
    }
    
    return employees;
}

- (BOOL)login:(NSString*)password
{
    // Send the request
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://92.70.42.51:8000/IknowService.svc/login?email=%@&password=%@", _email, password]];
    NSData *data = [NSData dataWithContentsOfURL:url];

    // Parse the result
    NSError *error;
    NSDictionary *jsonRoot = [[[NSJSONSerialization JSONObjectWithData:data
                                                             options:kNilOptions
                                                                 error:&error] objectForKey:@"result"] objectForKey:@"value"];
    IKEmployee *employee = [[IKEmployee alloc] initWithValuesFromDictionary:jsonRoot];
    
    NSLog(@"%@", employee);
    return NO;
}

+ (BOOL)login:(NSString *)email password:(NSString *)password
{
    // Send the request
    return NO;
}

@end

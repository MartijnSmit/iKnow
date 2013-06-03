//
//  Encryption.h
//  ClientV2
//

#import <Foundation/Foundation.h>

@interface Encryption : NSObject

+ (NSString *) encrypt:(NSString *)text;
+ (NSString *) decrypt:(NSString *)text;

@end

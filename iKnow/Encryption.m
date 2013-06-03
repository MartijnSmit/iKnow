//
//  Encryption.m
//  ClientV2
//

#import "Encryption.h"
#import <CommonCrypto/CommonCryptor.h>
#import "NSData+Base64.h"

// Private Methods and Variables
@interface Encryption()
+(NSData *) performAction:(NSData *)input action:(CCOperation)action;
@end

@implementation Encryption
/*
 (Public) ENCRYPT
 
 This method does:
 - Convert input to an NSString format
 - Encrypt input
 - Convert encrypted data in an base64 format
 
 Input:
 NSString text: data that has to be encrypted
 
 Return:
 NSString: a string containing the encrypted data
 */
+ (NSString *) encrypt:(NSString *)text {
    // Convert input to NSData
    NSData * input = [text dataUsingEncoding:NSASCIIStringEncoding];
    
    // Encrypt input
    NSData * raw = [self performAction:input action:kCCEncrypt];
    
    // Convert encrpyted data to base64
    NSString * output = [raw base64EncodingWithLineLength:0];
	
    return output;
}

/*
 (Public) DECRYPT
 
 This method does:
 - Convert input into required format
 - Decrypt input
 - Convert decrypted data into an NSString
 
 Input:
 NSString text: data that has to be decrypted
 
 Return:
 NSString: a string containing the decrypted data
 */
+ (NSString *) decrypt:(NSString *)text {
    // Convert input into required format
    NSData * input = [NSData dataWithBase64EncodedString:text];
    
    // Decrypt input
    NSData * raw = [self performAction:input action:kCCDecrypt];
    
    // Convert encrypted data into NSString
    NSString *output = [[NSString alloc] initWithData:raw encoding:NSUTF8StringEncoding];
    
    return output;
}

/*
 (Private) PERFORMACTION
 
 This method does:
 - Constructing Cryptor
 - Setting up buffer
 - Performing encryption / decryption
 - Writting encrypted/decrypted data to buffer
 - Writting buffer to NSData
 
 Input:
 NSdata input: The data that has to be encrypted or decrypted
 CCOperation action: The action that has to be performed(kCCEncrypt or kCCDecrypt)
 
 Return:
 NSData: The encrypted or decrypted information
 */
+ (NSData *) performAction:(NSData *)input action:(CCOperation)action {
    // keys
    NSData *key = [@"12345678911234561234567891123456" dataUsingEncoding:NSASCIIStringEncoding];
    NSData *iv = [@"1234567891123456" dataUsingEncoding:NSASCIIStringEncoding];
    
    CCCryptorRef thisEncipher = NULL;
    size_t movedBytes = 0;
    size_t totalBytesWritten = 0;
	
    CCCryptorStatus status = CCCryptorCreate(action, kCCAlgorithmAES128, kCCOptionPKCS7Padding, (const void *)[key bytes], kCCKeySizeAES256, (const void *)[iv bytes], &thisEncipher);
    
    size_t bufferPtrSize = CCCryptorGetOutputLength(thisEncipher, [input length], true);
	
    // Allocate buffer.
    uint8_t * bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t) );
	
    // Initialize some necessary book keeping.
    uint8_t * ptr = bufferPtr;
	
    // Set up initial size.
    size_t remainingBytes = bufferPtrSize;
	
    // Actually perform the encryption or decryption.
    status = CCCryptorUpdate(thisEncipher, (const void *) [input bytes], [input length], ptr, remainingBytes, &movedBytes);
    
    // Handle book keeping.
    ptr += movedBytes;
    remainingBytes -= movedBytes;
    totalBytesWritten += movedBytes;
    
    // Finalize everything to the output buffer.
    status = CCCryptorFinal(thisEncipher, ptr, remainingBytes, &movedBytes);	
    totalBytesWritten += movedBytes;
    
    // Output   
    NSData * output = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)totalBytesWritten];    
    
    return output;
}
@end
//
//  AbstractCipher.m
//  Cipher Sender
//
//  Created by Julian Tigler on 6/19/12.
//  Copyright (c) 2012 Duke. All rights reserved.
//

#import "AbstractCipher.h"

@interface AbstractCipher()
@property (strong, nonatomic) NSString *myKey;
@end

@implementation AbstractCipher
@synthesize myKey;

- (NSString *)encrypt:(NSString *)plaintext{
    return [[self encryptionMethodForPlaintext:[[Text alloc] initWithString:plaintext] withKey:self.myKey] description];
}

- (NSString *)decrpyt:(NSString *)ciphertext{
    return [[self decryptionMethodForCiphertext:[[Text alloc] initWithString:ciphertext] withKey:self.myKey] description];
}

- (BOOL)setKey:(NSString *)key{
    if([self isAcceptableKey:key]){
        self.myKey = key;
        return YES;
    }
    return NO;
}

- (BOOL)isAcceptablePlaintext:(NSString *)plaintext{
    const char *badLetters = [[self getUnacceptablePlainLetters] UTF8String];
    for (int i = 0; i < [[self getUnacceptablePlainLetters] length]; i++) {
        if ([self string:plaintext ContainsChar:badLetters[i]]) {
            return NO;
        }
    }
    return YES;
}

- (BOOL)isAcceptableCiphertext:(NSString *)ciphertext{
    const char *badLetters = [[self getUnacceptableCipherLetters] UTF8String];
    for (int i = 0; i < [[self getUnacceptableCipherLetters] length]; i++){
        if ([self string:ciphertext ContainsChar:badLetters[i]]){
            return NO;
        }
    }
    return YES;
}
            
- (BOOL) string: (NSString *)string ContainsChar:(char)target{
    const char *letters = [string UTF8String];
    for (int i = 0; i < [string length]; i++) {
        if (letters[i] == target) {
            return YES;
        }
    }
    return NO;
}

- (NSString *)getUnacceptablePlainLetters{
    return @"";
}

- (NSString *)getUnacceptableCipherLetters{
    return @"";
}


//Pseudo abstract methods
- (BOOL) needsKey{return NO;}
- (NSString *) keyPrompt{return nil;}
- (Text *) encryptionMethodForPlaintext:(Text *) plaintext withKey: (NSString *)key{return nil;}
- (Text *) decryptionMethodForCiphertext:(Text *) ciphertext withKey: (NSString *)key{return nil;}
- (BOOL) isAcceptableKey:(NSString *)key{return NO;}

@end
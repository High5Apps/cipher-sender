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

- (NSString *)decrypt:(NSString *)ciphertext{
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
    NSRange unacceptableRange = [plaintext rangeOfCharacterFromSet:[self getUnacceptablePlaintextCharacterSet]];
    return unacceptableRange.location == NSNotFound;
}

- (BOOL)isAcceptableCiphertext:(NSString *)ciphertext{
    NSRange unacceptableRange = [ciphertext rangeOfCharacterFromSet:[self getUnacceptableCiphertextCharacterSet]];
    return unacceptableRange.location == NSNotFound;
}

- (NSString *)getUnacceptableAsciiPlainLetters{
    return @"";
}

- (NSString *)getUnacceptableAsciiCipherLetters{
    return @"";
}

- (NSString *)getAcceptableNonAsciiPlainLetters{
    return @"“”‘’";
}

- (NSString *)getAcceptableNonAsciiCipherLetters{
    return @"“”‘’";
}

- (NSCharacterSet *)getUnacceptablePlaintextCharacterSet{
    // Only allow ascii characters plus getAcceptableNonAsciiPlainLetters minus getUnacceptableAsciiPlainLetters
    NSMutableCharacterSet *acceptableSet = [NSMutableCharacterSet characterSetWithRange:NSMakeRange(0, 128)];
    [acceptableSet addCharactersInString:[self getAcceptableNonAsciiPlainLetters]];
    [acceptableSet removeCharactersInString:[self getUnacceptableAsciiPlainLetters]];
    return [acceptableSet invertedSet];
}

- (NSCharacterSet *)getUnacceptableCiphertextCharacterSet{
    // Only allow ascii characters plus getAcceptableNonAsciiCipherLetters minus getUnacceptableAsciiCipherLetters
    NSMutableCharacterSet *acceptableSet = [NSMutableCharacterSet characterSetWithRange:NSMakeRange(0, 128)];
    [acceptableSet addCharactersInString:[self getAcceptableNonAsciiCipherLetters]];
    [acceptableSet removeCharactersInString:[self getUnacceptableAsciiCipherLetters]];
    return [acceptableSet invertedSet];
}

//Pseudo abstract methods
- (BOOL) needsKey{return NO;}
- (NSString *) keyPrompt{return nil;}
- (Text *) encryptionMethodForPlaintext:(Text *) plaintext withKey: (NSString *)key{return nil;}
- (Text *) decryptionMethodForCiphertext:(Text *) ciphertext withKey: (NSString *)key{return nil;}
- (BOOL) isAcceptableKey:(NSString *)key{return NO;}
- (NSString *) name{return @"Cipher Name";}

@end

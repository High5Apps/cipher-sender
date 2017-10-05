//
//  AbstractCipher.h
//  Cipher Sender
//
//  Created by Julian Tigler on 6/19/12.
//  Copyright (c) 2012 Duke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Text.h"
#import "Alphabet.h"

@interface AbstractCipher : NSObject{
    @private NSString *myKey;
}

//- (BOOL) string: (NSString *)string ContainsChar:(char)target; //remove later

- (NSString *)encrypt:(NSString *)plaintext;
- (NSString *)decrpyt:(NSString *)ciphertext;
- (BOOL)setKey:(NSString *)key;
- (BOOL)isAcceptablePlaintext:(NSString *)plaintext;
- (BOOL)isAcceptableCiphertext:(NSString *)ciphertext;
- (NSString *)getUnacceptablePlainLetters;
- (NSString *)getUnacceptableCipherLetters;
- (BOOL)needsKey;
- (NSString *)keyPrompt;

//- (Text *)encryptionMethodForPlaintext:(Text *)plaintext withKey:(NSString *)key;
//- (Text *)decryptionMethodForCiphertext:(Text *)ciphertext withKey:(NSString *)key;
//- (BOOL)isAcceptableKey:(NSString *)key;


@end

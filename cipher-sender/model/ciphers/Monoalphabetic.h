//
//  Monoalphabetic.h
//  Cipher Sender
//
//  Created by Julian Tigler on 6/24/12.
//  Copyright (c) 2012 Duke. All rights reserved.
//

#import "KeyedCipher.h"

@interface Monoalphabetic : KeyedCipher

- (Text *)encryptionMethodForPlaintext:(Text *)plaintext withKey:(NSString *)key;
- (Text *)decryptionMethodForCiphertext:(Text *)ciphertext withKey:(NSString *)key;
- (BOOL)isAcceptableKey:(NSString *)key;
- (NSString *)keyPrompt;

@end

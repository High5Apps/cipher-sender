//
//  KeyboardCode.h
//  Cipher Sender
//
//  Created by Julian Tigler on 6/23/12.
//  Copyright (c) 2012 Duke. All rights reserved.
//

#import "KeylessCipher.h"

@interface KeyboardCode : KeylessCipher

- (Text *) encryptionMethodForPlaintext:(Text *) plaintext withKey: (NSString *)key;
- (Text *) decryptionMethodForCiphertext:(Text *) ciphertext withKey: (NSString *)key;
- (NSString *)getUnacceptableAsciiPlainLetters;
- (NSString *)getUnacceptableAsciiCipherLetters;

@end

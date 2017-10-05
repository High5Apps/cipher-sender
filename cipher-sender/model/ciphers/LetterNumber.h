//
//  LetterNumber.h
//  Cipher Sender
//
//  Created by Julian Tigler on 6/23/12.
//  Copyright (c) 2012 Duke. All rights reserved.
//

#import "KeylessCipher.h"

@interface LetterNumber : KeylessCipher

- (Text *) encryptionMethodForPlaintext:(Text *) plaintext withKey: (NSString *)key;
- (Text *) decryptionMethodForCiphertext:(Text *) ciphertext withKey: (NSString *)key;
- (NSString *)getUnacceptablePlainLetters;
- (NSString *)getUnacceptableCipherLetters;

@end

//
//  Atbash.h
//  Cipher Sender
//
//  Created by Julian Tigler on 6/21/12.
//  Copyright (c) 2012 Duke. All rights reserved.
//

#import "KeylessCipher.h"

@interface Atbash : KeylessCipher

- (Text *) encryptionMethodForPlaintext:(Text *) plaintext withKey: (NSString *)key;
- (Text *) decryptionMethodForCiphertext:(Text *) ciphertext withKey: (NSString *)key;

@end

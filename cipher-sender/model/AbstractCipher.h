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

- (NSString *)encrypt:(NSString *)plaintext;
- (NSString *)decrypt:(NSString *)ciphertext;
- (BOOL)setKey:(NSString *)key;
- (BOOL)isAcceptablePlaintext:(NSString *)plaintext;
- (BOOL)isAcceptableCiphertext:(NSString *)ciphertext;
- (NSString *)getUnacceptablePlainLetters;
- (NSString *)getUnacceptableCipherLetters;
- (BOOL)needsKey;
- (NSString *)keyPrompt;

@end

//
//  ROT13.m
//  Cipher Sender
//
//  Created by Julian Tigler on 6/23/12.
//  Copyright (c) 2012 Duke. All rights reserved.
//

#import "ROT13.h"

@implementation ROT13

static NSString * const NAME = @"ROT13 Cipher";
static NSString * const INFO = @"The ROT13 Cipher is a speciallized case of the Caesar Shift Cipher with a shift value of 13. The ROT13 Cipher has gained popularity, especially in online communities, because enciphering and deciphering can be performed using the same simple process.";

- (Text *)encryptionMethodForPlaintext:(Text *)plaintext withKey:(NSString *)key{
    return [self rotate:plaintext];
}

- (Text *)decryptionMethodForCiphertext:(Text *)ciphertext withKey:(NSString *)key{
    return [self rotate:ciphertext];
}
            
- (Text *)rotate: (Text *) t{
    NSMutableArray *replacements = [[NSMutableArray alloc] initWithCapacity:[Alphabet NUM_LETTERS]]; 
    for (NSString *letter in [t getLoweredLetters]) {
        int i = [Alphabet getIndex:letter];
        i = (i + 13) % [Alphabet NUM_LETTERS];
        [replacements addObject:[Alphabet getLetter:i]];
    }
    return [t replaceLettersWith:replacements];
}

- (NSString *)name {
    return NAME;
}

- (NSString *)info {
    return INFO;
}

@end

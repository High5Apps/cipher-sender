//
//  KeyboardCode.m
//  Cipher Sender
//
//  Created by Julian Tigler on 6/23/12.
//  Copyright (c) 2012 Duke. All rights reserved.
//

#import "KeyboardCode.h"

@implementation KeyboardCode

- (Text *) encryptionMethodForPlaintext:(Text *) plaintext withKey: (NSString *)key{
    NSMutableArray *replacements = [[NSMutableArray alloc] initWithCapacity:[Alphabet NUM_LETTERS]];
    for (NSString *letter in [plaintext getLoweredLetters]) {
        int index = [Alphabet getIndex:letter];
        char c = [self.myShiftLetters characterAtIndex:index];
        [replacements addObject:[NSString stringWithFormat:@"%c",c]];
    }
    return [plaintext replaceLettersWith:replacements];
}

- (Text *) decryptionMethodForCiphertext:(Text *) ciphertext withKey: (NSString *)key{
    NSMutableArray *replacements = [[NSMutableArray alloc] initWithCapacity:[Alphabet NUM_LETTERS]];
    for (NSString *letter in [ciphertext getLoweredLettersPlus:self.getUnacceptablePlainLetters]) {
        int index = [self.myShiftLetters rangeOfString:letter].location;
        [replacements addObject:[Alphabet getLetter:index]];
    }
    return [ciphertext replaceLettersWith:replacements plus:self.getUnacceptablePlainLetters];
}

- (NSString *)myShiftLetters{
    return @"snvfrghjokl;,mp[wtdyibecux";
}

- (NSString *)getUnacceptablePlainLetters{
    return @"[;,";
}

- (NSString *)getUnacceptableCipherLetters{
    return @"qaz";
}

@end

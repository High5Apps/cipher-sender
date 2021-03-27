//
//  KeyboardCode.m
//  Cipher Sender
//
//  Created by Julian Tigler on 6/23/12.
//  Copyright (c) 2012 Duke. All rights reserved.
//

#import "KeyboardCode.h"

@implementation KeyboardCode

static NSString * const NAME = @"Keyboard Code";

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
    for (NSString *letter in [ciphertext getLoweredLettersPlus:[self getUnacceptableAsciiPlainLetters]]) {
        int index = (int)[self.myShiftLetters rangeOfString:letter].location;
        [replacements addObject:[Alphabet getLetter:index]];
    }
    return [ciphertext replaceLettersWith:replacements plus:[self getUnacceptableAsciiPlainLetters]];
}

- (NSString *)myShiftLetters{
    return @"snvfrghjokl;,mp[wtdyibecux";
}

- (NSString *)getUnacceptableAsciiPlainLetters{
    return [[super getUnacceptableAsciiPlainLetters] stringByAppendingString: @"[;,"];
}

- (NSString *)getUnacceptableAsciiCipherLetters{
    return [[super getUnacceptableAsciiCipherLetters] stringByAppendingString: @"aqz"];
}

- (NSString *)name {
    return NAME;
}

@end

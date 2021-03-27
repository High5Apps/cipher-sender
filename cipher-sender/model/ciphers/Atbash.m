//
//  Atbash.m
//  Cipher Sender
//
//  Created by Julian Tigler on 6/21/12.
//  Copyright (c) 2012 Duke. All rights reserved.
//

#import "Atbash.h"

@implementation Atbash

static NSString * const NAME = @"Atbash Cipher";
static NSString * const INFO = @"The Atbash Cipher simply flips the letters of the alphabet. 'a' swaps with 'z', 'b' with 'y', 'c' with 'x', and so on.";

- (Text *) encryptionMethodForPlaintext:(Text *) plaintext withKey: (NSString *)key{
    return [self flip:plaintext];
}

- (Text *) decryptionMethodForCiphertext:(Text *) ciphertext withKey: (NSString *)key{
    return [self flip:ciphertext];
}

- (Text *)flip:(Text *) t{
    NSMutableArray *replacements = [[NSMutableArray alloc] init];
    for (NSString *letter in [t getLoweredLetters]) {
        int index = [Alphabet getIndex:letter];
        NSString *flipped = [Alphabet getLetter:([Alphabet NUM_LETTERS] - 1 - index)];
        [replacements addObject:flipped];
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

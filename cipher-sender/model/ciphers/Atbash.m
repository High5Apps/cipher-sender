//
//  Atbash.m
//  Cipher Sender
//
//  Created by Julian Tigler on 6/21/12.
//  Copyright (c) 2012 Duke. All rights reserved.
//

#import "Atbash.h"

@implementation Atbash

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

@end

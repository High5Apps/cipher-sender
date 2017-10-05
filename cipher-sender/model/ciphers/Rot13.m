//
//  Rot13.m
//  Cipher Sender
//
//  Created by Julian Tigler on 6/23/12.
//  Copyright (c) 2012 Duke. All rights reserved.
//

#import "Rot13.h"

@implementation Rot13

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

@end

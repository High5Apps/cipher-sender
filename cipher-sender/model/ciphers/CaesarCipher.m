//
//  CaesarCipher.m
//  Cipher Sender
//
//  Created by Julian Tigler on 6/24/12.
//  Copyright (c) 2012 Duke. All rights reserved.
//

#import "CaesarCipher.h"

@implementation CaesarCipher

- (Text *)encryptionMethodForPlaintext:(Text *)plaintext withKey:(NSString *)key{
    int k = [self processKey:key];
    return [self shiftText:plaintext by:k];
}

- (Text *)decryptionMethodForCiphertext:(Text *)ciphertext withKey:(NSString *)key{
    NSString *decipheringKey = [NSString stringWithFormat:@"%i", -1 * [self processKey:key]];
    int k = [self processKey:decipheringKey];
    return [self shiftText:ciphertext by:k];
}

- (Text *)shiftText:(Text *)t by:(int)shiftAmount{
    NSArray *loweredLetters = [t getLoweredLetters];
    NSMutableArray *replacements = [[NSMutableArray alloc] initWithCapacity:[loweredLetters count]];
    for (NSString *letter in loweredLetters) {
        int index = [Alphabet getIndex:letter];
        [replacements addObject:[Alphabet getLetter:(index + shiftAmount)]];
    }
    return [t replaceLettersWith:replacements];
}

- (int)processKey:(NSString *)key{
    int k;
    if (key.length == 1 && [Alphabet isLetter:[key characterAtIndex:0]]) {
        k = [Alphabet getIndex:key];
    }else {
        k = [key intValue];
        if (k < 0) {
            k = abs(k);
            k = k % Alphabet.NUM_LETTERS;
            k = Alphabet.NUM_LETTERS - k;
        }
    }
    return k % Alphabet.NUM_LETTERS;
}

- (BOOL)isAcceptableKey:(NSString *)key{
    if (key.length == 0) {
        return NO;
    }
    
    if ([key intValue] == 0) { //Either not a number or 0
        if ([key characterAtIndex:0] == '0' && [key length] == 1) {
            return YES;
        }else { //it's not a number
            if ([key length] != 1) {
                return NO;
            }
            if (![Alphabet isLetter:[key characterAtIndex:0]]) {
                return NO;
            }
        }
    }
    return YES;
}

- (NSString *)keyPrompt{
    return @"Enter a letter or number to rotate by:";
}

@end

//
//  CaesarCipher.m
//  Cipher Sender
//
//  Created by Julian Tigler on 6/24/12.
//  Copyright (c) 2012 Duke. All rights reserved.
//

#import "CaesarCipher.h"

@implementation CaesarCipher

static NSString * const NAME = @"Caesar Shift Cipher";
static NSString * const INFO = @"This cipher shifts every letter a certain number of letters forward in the alphabet. For example a Caesar Shift of 4 would shift each letter of 'Abe' 4 letters forward giving 'Efi'. Similarly, a shift of 1 would shift each letter of 'Abe' forward 1 giving 'Bcf'. Some implementations use a letter to specify the shift with 'a' corresponding to 1, 'b' to 2, etc. Also note that while it is possible to shift by numbers larger than 25 or smaller than 0, they just wrap around to corresponding shifts between 0 and 25.";

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

- (NSString *)name {
    return NAME;
}

- (NSString *)info {
    return INFO;
}

@end

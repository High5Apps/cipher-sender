//
//  Vigenere.m
//  Cipher Sender
//
//  Created by Julian Tigler on 6/24/12.
//  Copyright (c) 2012 Duke. All rights reserved.
//

#import "Vigenere.h"

@implementation Vigenere

static NSString * const NAME = @"Vigenere Cipher";
static NSString * const INFO = @"The Vigenere Cipher is a polyalphabetic substitution cipher that was formalized by Blaise de Vigenere in the 19th century, although variations of the cipher had existed hundereds of years prior. It was known as 'The Indecipherable Cipher' for more than 100 years because it was thought to be uncrackable. Now, however, relatively simple algorithms are known for cracking it. The Vigenere Cipher is polyalphabetic in nature because a single letter in the plaintext is not always enciphered to the same letter in the ciphertext. To achieve this, different alphabets are used that depend on the 'current' letter of the keyword. Each letter is enciphered using the Caesar Shifted alphabet corresponding to the current letter of the keyword. For example, let's encipher the word 'better' with the keyword 'king'. The 'b' would be moved forward 10 spaces according to the 'k' Caesar Shift giving 'l'. Then the 'e' would moved forward 8 spaces by the 'i' Caesar Shift alphabet giving 'm'. Then the 't', second 't', second 'e', and 'r' would be shifted forward by 13, 6, 10, and 8 letters respectively corresponding to the 'n', 'g', 'k', and 'i' Caesar Shifts. Putting this all together gives 'lmgzoz' from 'better'.";

- (Text *)encryptionMethodForPlaintext:(Text *)plaintext withKey:(NSString *)key{
    key = [key lowercaseString];
    NSMutableArray *replacements = [[NSMutableArray alloc] init];
    NSArray *square = Alphabet.SQUARE;
    int i = 0;
    for (NSString *letter in [plaintext getLoweredLetters]) {
        NSString *keyLetter = [self getLetterOfKey:key atPositionInText:i];
        int keyLetterIndex = [Alphabet getIndex:keyLetter];
        int letterIndex = [Alphabet getIndex:letter];
        NSString *replacement = square[keyLetterIndex][letterIndex];
        [replacements addObject:replacement];
        i++;
    }
    return [plaintext replaceLettersWith:replacements];
}

- (Text *)decryptionMethodForCiphertext:(Text *)ciphertext withKey:(NSString *)key{
    key = [key lowercaseString];
    NSMutableArray *replacements = [[NSMutableArray alloc] init];
    NSArray *square = Alphabet.SQUARE;
    int i = 0;
    for (NSString *letter in [ciphertext getLoweredLetters]) {
        NSString *keyLetter = [self getLetterOfKey:key atPositionInText:i];
        int keyRowIndex = [Alphabet getIndex:keyLetter];
        NSArray *keyRow = square[keyRowIndex];
        for (int j = 0; j < [keyRow count]; j++) {
            if ([keyRow[j] isEqualToString:letter]) {
                NSString *replacement = [Alphabet getLetter:j];
                [replacements addObject:replacement];
                break;
            }
        }
        i++;
    }
    return [ciphertext replaceLettersWith:replacements];
}

- (NSString *)getLetterOfKey:(NSString *)key atPositionInText:(int)position{
    int index = position % [key length];
    return [NSString stringWithFormat:@"%c", [key characterAtIndex:index]];
}

- (BOOL)isAcceptableKey:(NSString *)key{
    if (key.length == 0) {
        return NO;
    }
    
    const char *charArr = [key UTF8String];
    for (int i = 0; i < [key length]; i++) {
        char c = charArr[i];
        if (! [Alphabet isLetter:c]) {
            return NO;
        }
    }
    return YES;
}

- (NSString *)keyPrompt{
    return @"Enter a keyword";
}

- (NSString *)name {
    return NAME;
}

- (NSString *)info {
    return INFO;
}

@end

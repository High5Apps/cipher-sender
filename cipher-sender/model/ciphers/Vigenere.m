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

@end

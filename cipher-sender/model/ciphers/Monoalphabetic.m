//
//  Monoalphabetic.m
//  Cipher Sender
//
//  Created by Julian Tigler on 6/24/12.
//  Copyright (c) 2012 Duke. All rights reserved.
//

#import "Monoalphabetic.h"

@implementation Monoalphabetic

- (Text *)encryptionMethodForPlaintext:(Text *)plaintext withKey:(NSString *)key{
    NSString *processedKey = [self processKey:key];
    NSArray *substitutions = [self makeSubstitutionArrayForProcessedKey:processedKey];
    NSMutableArray *replacements = [[NSMutableArray alloc] init];
    for (NSString *letter in [plaintext getLoweredLetters]) {
        int index = [Alphabet getIndex:letter];
        NSString *replacement = substitutions[index];
        [replacements addObject:replacement];
    }
    return [plaintext replaceLettersWith:replacements];
}

- (Text *)decryptionMethodForCiphertext:(Text *)ciphertext withKey:(NSString *)key{
    NSString *processedKey = [self processKey:key];
    NSArray *substitutions = [self makeSubstitutionArrayForProcessedKey:processedKey];
    NSMutableArray *replacements = [[NSMutableArray alloc] init];
    for (NSString *letter in [ciphertext getLoweredLetters]) {
        int index = (int)[substitutions indexOfObject:letter];
        NSString *replacement = [Alphabet getLetter:index];
        [replacements addObject:replacement];
    }
    return [ciphertext replaceLettersWith:replacements];
}

- (NSString *)processKey:(NSString *)key{
    key = [key lowercaseString];
    NSMutableArray *usedLetters = [[NSMutableArray alloc] init];
    NSMutableArray *newKeyLetters = [[NSMutableArray alloc] init];
    const char *charArr = [key UTF8String];
    for (int i = 0; i < [key length]; i++) {
        NSString *letter = [NSString stringWithFormat:@"%c", charArr[i]];
        if (! [usedLetters containsObject:letter]) {
            [usedLetters addObject:letter];
            [newKeyLetters addObject:letter];
        }
    }
    return [newKeyLetters componentsJoinedByString:@""];
}

- (NSArray *)makeSubstitutionArrayForProcessedKey:(NSString *)processedKey{
    NSMutableArray *substitutions = [[NSMutableArray alloc] initWithCapacity:Alphabet.NUM_LETTERS];
    NSMutableSet *usedLetters = [[NSMutableSet alloc] init];
    int i;
    for (i = 0; i < [processedKey length]; i++) {
        NSString *letter = [NSString stringWithFormat:@"%c", [processedKey characterAtIndex:i]];
        [substitutions addObject:letter];
        [usedLetters addObject:letter];
    }
    for (NSString *letter in [Alphabet LOWER_ARR]){
        if(! [usedLetters containsObject:letter]){
            [substitutions addObject:letter];
        }
    }
    return substitutions;
}

- (BOOL)isAcceptableKey:(NSString *)key{
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
    return @"Enter a keyword or the 26 letter substitutions without spaces. eg nightwatch or ynlkxbshmiwdpjroqvfeaugtzc";
}

@end
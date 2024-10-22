//
//  A1Z26.m
//  Cipher Sender
//
//  Created by Julian Tigler on 6/23/12.
//  Copyright (c) 2012 Duke. All rights reserved.
//

#import "A1Z26.h"

@implementation A1Z26

static NSString * const NAME = @"A1Z26 Cipher";
static NSString * const INFO = @"The A1Z26 Cipher replaces the letter with its two-digit position in the alphabet. 'a' is changed into 01, 'b' to 02, 'c' to 03, etc. For example 'Able' is transformed into 01021205.";

- (Text *) encryptionMethodForPlaintext:(Text *) plaintext withKey: (NSString *)key{
    NSMutableArray *replacements = [[NSMutableArray alloc] initWithCapacity:[Alphabet NUM_LETTERS]];
    for (NSString *letter in [plaintext getLoweredLetters]) {
        int letterPosition = 1 + [Alphabet getIndex:letter];
        NSString *replacement;
        if (letterPosition < 10) {
            replacement = [NSString stringWithFormat:@"0%i", letterPosition];
        }else {
            replacement = [NSString stringWithFormat:@"%i", letterPosition];
        }
        [replacements addObject:replacement];
    }
    return [plaintext replaceLettersWith:replacements];
}

- (Text *) decryptionMethodForCiphertext:(Text *) ciphertext withKey: (NSString *)key{
    @try {
        NSMutableArray *replacements = [[NSMutableArray alloc] initWithCapacity:[Alphabet NUM_LETTERS]];
        NSArray *loweredLetters = [ciphertext getLoweredLettersPlus:[self getUnacceptableAsciiPlainLetters]];
        for (int i = 0; i < [loweredLetters count]; i += 2) {
            NSString *numString = [NSString stringWithFormat:@"%@%@", loweredLetters[i], loweredLetters[(i+1)]];
            int number = [numString intValue];
            NSString *letter = [Alphabet getNthLetter:number];
            [replacements addObject:letter];
        }
        return [ciphertext replaceLettersWith:replacements plus:[self getUnacceptableAsciiPlainLetters] everyNthLetter:2];
    }
    @catch (NSException *exception) {
        NSLog(@"in catch");
        NSLog(@"%@", exception.name);
        if ([exception.name isEqualToString:@"NSRangeException"]) {
            NSLog(@"Caught nsr");
            NSString *unevenText = [ciphertext description];
            return [[Text alloc] initWithString:[NSString stringWithFormat:@"!!!Invalid A1Z26 Ciphertext: There must be an even number of digits present and no instances of 00 should occur. %@", unevenText]];
        }
    }
}

- (NSString *)getUnacceptableAsciiPlainLetters{
    return [[super getUnacceptableAsciiPlainLetters] stringByAppendingString: @"0123456789"];
}

- (NSString *)getUnacceptableAsciiCipherLetters{
    return [[super getUnacceptableAsciiCipherLetters] stringByAppendingString: @"abcdefghijklmnopqrstuvwxyzABCDEFGHJIJKLMNOPQRSTUVWXYZ"];
}

- (NSString *)name {
    return NAME;
}

- (NSString *)info {
    return INFO;
}

@end

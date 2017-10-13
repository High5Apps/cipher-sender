//
//  MorseCode.m
//  Cipher Sender
//
//  Created by Julian Tigler on 6/23/12.
//  Copyright (c) 2012 Duke. All rights reserved.
//

#import "MorseCode.h"

@implementation MorseCode

- (Text *) encryptionMethodForPlaintext:(Text *) plaintext withKey: (NSString *)key{
    NSMutableString *newString = [[NSMutableString alloc] init];
    for (NSString *word in [plaintext getLoweredWords]) {
        const char *wordChars = [word UTF8String];
        for (int i = 0; i < [word length]; i++) {
            char c = wordChars[i];
            if([Alphabet isLetter:c]){
                int index = [Alphabet getIndex:[NSString stringWithFormat:@"%c", c]];
                [newString appendString:(self.myMorseLetters)[index]];
                [newString appendString:@" "];
            }
            else if([Alphabet isDigit:c]){
                int index = [[NSString stringWithFormat:@"%c",c] intValue];
                [newString appendString:(self.myMorseNumbers)[index]];
                [newString appendString:@" "];
            }
        }
        [newString appendString:@" "];
    }
    NSString *trimmedString = [newString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return [[Text alloc] initWithString:trimmedString];
}

- (Text *) decryptionMethodForCiphertext:(Text *) ciphertext withKey: (NSString *)key{
    @try {
        NSString *sanitizedCipherText = [[ciphertext description] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSMutableString *newString = [[NSMutableString alloc] init];
        NSArray *words = [sanitizedCipherText componentsSeparatedByString:@"  "]; //note double space
        if ([[words objectAtIndex:0] length] == 0) { // Empty cipherText so just return it
            return ciphertext;
        }
        for (NSString *word in words) {
            for (NSString *letter in [word componentsSeparatedByString:@" "]) {
                [newString appendString:[self letterForMorseLetter:letter]];
            }
            [newString appendString:@" "];
        }
        NSString *trimmedString = [newString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        return [[Text alloc] initWithString:trimmedString];
    }
    @catch (NSException *exception) {
        if ([exception.name isEqualToString:@"IllegalArgumentException"]) {
            NSString *badString = [ciphertext description];
            return [[Text alloc] initWithString:[NSString stringWithFormat:@"!!!Invalid Morse Code Ciphertext: At least one of the encoded letters from the input was invalid according to the International Morse Code alphabet. %@", badString]];
        }
    }
}

- (NSString *) letterForMorseLetter: (NSString *)morseLetter{
    for (int i = 0; i < self.myMorseLetters.count; i++) {
        if ([(self.myMorseLetters)[i] isEqualToString:morseLetter]) {
            return [Alphabet getLetter:i];
        }
    }
    for (int i = 0; i < self.myMorseNumbers.count; i++) {
        if ([(self.myMorseNumbers)[i] isEqualToString:morseLetter]) {
            return [NSString stringWithFormat:@"%i", i];
        }
    }    
    NSException * illegalArgumentException = [[NSException alloc] initWithName:@"IllegalArgumentException" reason:@"Unknown Morse Letter in ciphertext" userInfo:nil];
    [illegalArgumentException raise];
    return nil;
}

- (NSArray *)myMorseLetters{
    return @[@".-", @"-...", @"-.-.", @"-..", @".",
			@"..-.", @"--.", @"....", @"..", @".---",
			@"-.-", @".-..", @"--", @"-.", @"---", 
			@".--.", @"--.-", @".-.", @"...", @"-",
			@"..-", @"...-", @".--", @"-..-", @"-.--",
			@"--.."];
}

- (NSArray *)myMorseNumbers{
    return @[@"-----", @".----", @"..---", @"...--", @"....-", 
			@".....", @"-....", @"--...", @"---..", @"----."];
}

- (NSString *)getUnacceptablePlainLetters{
    return @".-";
}

- (NSString *)getUnacceptableCipherLetters{
    return @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
}

@end

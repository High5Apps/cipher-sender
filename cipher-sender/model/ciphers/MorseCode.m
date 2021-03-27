//
//  MorseCode.m
//  Cipher Sender
//
//  Created by Julian Tigler on 6/23/12.
//  Copyright (c) 2012 Duke. All rights reserved.
//

#import "MorseCode.h"

@implementation MorseCode

static NSString * const NAME = @"Morse Code";
static NSString * const INFO = @"International Morse Code was invented more than 150 years ago by Samuel Morse. It was originally used to send messages across telegraph wires. The code translates the English letters and the numbers 0-9 into a series of dots and dashes with lengths between 1 and 5. Letters that are used more frequently in common language get shorter lengths so that the message may be transmitted quicker. A single space is placed between each letter and a double space is inserted between words.";

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

- (NSString *)getUnacceptableAsciiPlainLetters{
    return [[super getUnacceptableAsciiPlainLetters] stringByAppendingString: @".-"];
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

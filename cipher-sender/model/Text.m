//
//  Text.m
//  Cipher Sender
//
//  Created by Julian Tigler on 6/19/12.
//  Copyright (c) 2012 Duke. All rights reserved.
//

#import "Text.h"

@interface Text()
@property (strong, nonatomic) NSString *myText;
@end

@implementation Text
@synthesize myText;

- (id)initWithString:(NSString *)string{
    
    self = [super init];
    if (self) {
        self.myText = [self sanitizeInput:string];
    }
    return self;
}

- (NSString *)sanitizeInput:(NSString *)input {
    input = [input stringByReplacingOccurrencesOfString:@"“" withString:@"\""]; // left double quote
    input = [input stringByReplacingOccurrencesOfString:@"”" withString:@"\""]; // right double quote
    input = [input stringByReplacingOccurrencesOfString:@"‘" withString:@"\'"]; // left single quote
    input = [input stringByReplacingOccurrencesOfString:@"’" withString:@"\'"]; // right single quote
    return input;
}

- (Text *)replaceLettersWith:(NSArray *)replacements{
    return [self replaceLettersWith:replacements plus:nil];
}

- (Text *)replaceLettersWith:(NSArray *)replacements plus:(NSString *)additionalSymbols{
    return [self replaceLettersWith:replacements plus:additionalSymbols everyNthLetter:1];
}

- (Text *)replaceLettersWith:(NSArray *)replacements plus:(NSString *)additionalSymbols everyNthLetter:(int)n{
    if ([replacements count] != ([[self getLoweredLettersPlus:additionalSymbols] count] / n)) {
        NSException *illegalArgumentException = [NSException exceptionWithName:@"IllegalArgumentException" 
                                                                        reason:@"Incorrect number of replacement letters provided."
                                                                      userInfo:nil];
        [illegalArgumentException raise];
    }
    
    const char *allChars = [self.myText UTF8String];
    int numAllChars = (int)[self.myText length];
    NSMutableString *newString = [[NSMutableString alloc] initWithCapacity:numAllChars];
    int index = 0;
    for (int i = 0; i < numAllChars; i++) {
        char c = allChars[i];
        if ([self isLetter:c] || (additionalSymbols != nil && [self string:additionalSymbols contains:c])) {
            if ([[NSCharacterSet uppercaseLetterCharacterSet] characterIsMember:c]) {
                [newString appendString:[(NSString *)replacements[index] uppercaseString]];
            }else {
                [newString appendString:(NSString *)replacements[index]];
            }
            i += (n - 1);
            index++;
        }else {
            [newString appendFormat:@"%c",c];
        }
    }
    return [[Text alloc] initWithString:newString];
}

- (BOOL)string: (NSString *)string contains:(char) letter{
    const char * charArr = [string UTF8String];
    for (int i = 0; i < [string length]; i++) {
        if(charArr[i] == letter){
            return YES;
        }
    }
    return NO;
}

- (BOOL)isLetter:(char)c{
    return [[NSCharacterSet letterCharacterSet] characterIsMember:c];
}

- (NSArray *)getLoweredLetters{
    return [self getLoweredLettersPlus:nil];
}

- (NSArray *)getLoweredLettersPlus: (NSString *)additionalSymbols{
    NSMutableArray *letters = [[NSMutableArray alloc] init];
    const char * charArr = [self.myText UTF8String];
    for (int i = 0; i < [self.myText length]; i++) {
        char c = charArr[i];
        if ([self isLetter:c] || (additionalSymbols != nil && [self string:additionalSymbols contains:c])) {
            [letters addObject:[[NSString stringWithFormat:@"%c", c] lowercaseString]];
        }
    }
    return letters;
}

- (NSArray *)getLoweredWords{
    return [[self.myText lowercaseString] componentsSeparatedByString:@" "];
}

- (NSString *)description{
    return self.myText;
}

@end

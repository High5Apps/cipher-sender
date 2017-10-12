//
//  Alphabet.m
//  Cipher Sender
//
//  Created by Julian Tigler on 6/21/12.
//  Copyright (c) 2012 Duke. All rights reserved.
//

#import "Alphabet.h"

@implementation Alphabet

+(NSString *) LOWER_LETTERS{
    return @"abcdefghijklmnopqrstuvwxyz";
}

+ (NSString *)UPPER_LETTERS{
    return [[self LOWER_LETTERS] uppercaseString];
}

+ (int)NUM_LETTERS{
    return (int)[[self LOWER_LETTERS] length];
}

+ (NSArray *)LOWER_ARR{
    NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:[self NUM_LETTERS]];
    const char *lowers = [[self LOWER_LETTERS] UTF8String];
    for (int i = 0; i < [self NUM_LETTERS]; i++) {
        NSString *s = [NSString stringWithFormat:@"%c", lowers[i]];
        [result addObject:s];
    }
    return result;
}

+ (NSArray *)UPPER_ARR{
    NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:[self NUM_LETTERS]];
    for (NSString *s in [self LOWER_ARR]) {
        [result addObject:[s uppercaseString]];
    }
    return result;
}

+ (NSArray *)SQUARE{
    NSMutableArray *square = [[NSMutableArray alloc] initWithCapacity:[self NUM_LETTERS]];
    for (int i = 0; i < [self NUM_LETTERS]; i++) {
        NSMutableArray *row = [[NSMutableArray alloc] initWithCapacity:[self NUM_LETTERS]];
        for (int j = 0; j < [self NUM_LETTERS]; j++) {
            int charIndex = (i + j) % [self NUM_LETTERS];
            [row addObject:[self getLetter:charIndex]];
        }
        [square addObject:row];
    }
    return square;
}

+ (NSString *)getLetter: (int)index{
    index = index % [self NUM_LETTERS];
    return [self LOWER_ARR][index];
}

+ (NSString *)getNthLetter: (int)n{
    return [self LOWER_ARR][(n-1)];
}

+ (int)getIndex:(NSString *)letter{
    return (int)[[self LOWER_ARR] indexOfObject:letter];
}

+ (BOOL)isLetter:(char)c{
    return [[NSCharacterSet letterCharacterSet] characterIsMember:c];
}

+ (BOOL)isDigit:(char)c{
    return [[NSCharacterSet decimalDigitCharacterSet] characterIsMember:c];
}

@end

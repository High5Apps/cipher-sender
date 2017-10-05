//
//  Alphabet.h
//  Cipher Sender
//
//  Created by Julian Tigler on 6/21/12.
//  Copyright (c) 2012 Duke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Alphabet : NSObject

+ (NSString *)LOWER_LETTERS;
+ (NSString *)UPPER_LETTERS;
+ (int)NUM_LETTERS;
+ (NSArray *)LOWER_ARR;
+ (NSArray *)UPPER_ARR;
+ (NSArray *)SQUARE;

+ (NSString *)getLetter: (int)index;
+ (NSString *)getNthLetter: (int)n;
+ (int)getIndex:(NSString *)letter;

+ (BOOL)isLetter:(char)c;
+ (BOOL)isDigit:(char)c;

@end

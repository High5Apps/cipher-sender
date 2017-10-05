//
//  Text.h
//  Cipher Sender
//
//  Created by Julian Tigler on 6/19/12.
//  Copyright (c) 2012 Duke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Text : NSObject{
    @private
    NSString *myText;
}

- (id)initWithString:(NSString *)string;
- (Text *)replaceLettersWith:(NSArray *)replacements;
- (Text *)replaceLettersWith:(NSArray *)replacements plus:(NSString *)additionalSymbols;
- (Text *)replaceLettersWith:(NSArray *)replacements plus:(NSString *)additionalSymbols everyNthLetter:(int)n;
- (NSArray *)getLoweredLetters;
- (NSArray *)getLoweredLettersPlus: (NSString *)additionalSymbols;
- (NSArray *)getLoweredWords;
- (NSString *)description;

@end

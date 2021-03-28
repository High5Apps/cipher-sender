//
//  CipherFactory.m
//  Cipher Sender
//
//  Created by Julian Tigler on 6/24/12.
//  Copyright (c) 2012 Duke. All rights reserved.
//

#import "CipherFactory.h"
#import "AbstractCipher.h"
#import "Atbash.h"
#import "Rot13.h"
#import "KeyboardShift.h"
#import "A1Z26.h"
#import "MorseCode.h"
#import "CaesarCipher.h"
#import "Monoalphabetic.h"
#import "Vigenere.h"
#import "RailFence.h"

@interface CipherFactory()
@end

@implementation CipherFactory

static NSArray *cipherClasses;

+ (int)cipherCount {
    return (int) CipherFactory.cipherClasses.count;
}

+ (AbstractCipher *)createCipherAtIndex:(int)index {
    return [[[CipherFactory.cipherClasses objectAtIndex:index] alloc] init];
}

+ (NSArray *)cipherClasses{
    if (cipherClasses == nil) {
        cipherClasses = @[
            [A1Z26 class],
            [Atbash class],
            [CaesarCipher class],
            [KeyboardShift class],
            [Monoalphabetic class],
            [MorseCode class],
            [RailFence class],
            [Rot13 class],
            [Vigenere class],
        ];
    }
    
    return cipherClasses;
}

@end

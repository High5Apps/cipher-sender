//
//  KeylessCipher.m
//  Cipher Sender
//
//  Created by Julian Tigler on 6/21/12.
//  Copyright (c) 2012 Duke. All rights reserved.
//

#import "KeylessCipher.h"

@implementation KeylessCipher

- (BOOL)needsKey{
    return NO;
}

- (BOOL)isAcceptableKey:(NSString *)key{
    return NO;
}

- (NSString *)keyPrompt{
    return nil;
}

@end

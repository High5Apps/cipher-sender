//
//  KeyedCipher.h
//  Cipher Sender
//
//  Created by Julian Tigler on 6/21/12.
//  Copyright (c) 2012 Duke. All rights reserved.
//

#import "AbstractCipher.h"

@interface KeyedCipher : AbstractCipher

- (BOOL)needsKey;

@end

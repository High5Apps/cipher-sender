//
//  CipherFactory.h
//  Cipher Sender
//
//  Created by Julian Tigler on 6/24/12.
//  Copyright (c) 2012 Duke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractCipher.h"

@interface CipherFactory : NSObject

+ (NSArray *)cipherClasses;
+ (NSArray *)cipherNames;
+ (NSArray *)cipherDescriptions;

-(AbstractCipher *)cipherForName:(NSString *)cipherName;

@end

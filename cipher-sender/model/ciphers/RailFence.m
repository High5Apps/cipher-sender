//
//  RailFence.m
//  Cipher Sender
//
//  Created by Julian Tigler on 6/24/12.
//  Copyright (c) 2012 Duke. All rights reserved.
//

#import "RailFence.h"

@implementation RailFence

static NSString * const NAME = @"Rail Fence Cipher";
static NSString * const INFO = @"The Rail Fence Cipher does not switch letters with other letters like most of these ciphers. Instead, it transposes the order of the letters. To accomplish this, the letters are laid out in a zig-zagging fashion. The depth of the zig-zag is given by the number of rails. Traditionally, 3 rails are used. After laying out the letters, the message is recombined by pushing the top rail together and putting it first. Then the second rail is pushed together and put after the first. This process is continued through the last rail. For example, to encode the message 'Hello, Jay' with a rail count of 3, you would first lay out the letters in a zig-zag as follows:\n H...o...a.\n .e.l.,.J.y \n ..l..._... \nThen push together the three lines to get 'Hoael,Jyl_' Note that '_' has been used to emphasize the [space], and '.'s have been added for spacing purposes only.";

- (Text *)encryptionMethodForPlaintext:(Text *)plaintext withKey:(NSString *)key{
    int numRails = [key intValue];
    NSMutableArray *rails = [[NSMutableArray alloc] initWithCapacity:numRails];
    NSString *textString = [plaintext description];
    const char *allChars = [textString UTF8String];
    if (numRails > [textString length] ) {
        return plaintext;
    }
    for (int i = 0; i < numRails; i++) {
        [rails addObject:[[NSMutableString alloc] init]];
    }
    for (int i = 0; i < [textString length]; i++) {
        int whichRail = [self getCurrentRailForIteration:i withRailTotal:numRails];
        [rails[whichRail] appendFormat:@"%c",allChars[i]];
    }
    NSMutableString *newString = [[NSMutableString alloc] init];
    for (int i = 0; i < numRails; i++) {
        [newString appendString:rails[i]];
    }
    
    return [[Text alloc] initWithString:newString];
}

- (Text *)decryptionMethodForCiphertext:(Text *)ciphertext withKey:(NSString *)key{
    int numRails = [key intValue];
    NSMutableArray *rails = [[NSMutableArray alloc] initWithCapacity:numRails];
    NSString *textString = [ciphertext description];
    const char *allChars = [textString UTF8String];
    
    if (numRails > [textString length]) {
        return ciphertext;
    }
    
    NSDictionary *railCounts = [self makeRailCountsForTextLength:(int)[textString length] withRailTotal:numRails];
    int position = 0;
    for (int i = 0; i < numRails; i++) {
        int railCount = [railCounts[@(i)] intValue];
        NSMutableArray *rail = [[NSMutableArray alloc] initWithCapacity:railCount];
        for (int j = 0; j < railCount; j++) {
            char c = allChars[position + j];
            [rail addObject:[NSString stringWithFormat:@"%c", c]];
        }
        [rails addObject:rail];
        position += railCount;
    }
    NSMutableString *newString = [[NSMutableString alloc] initWithCapacity:[textString length]];
    NSMutableArray *railPositions = [[NSMutableArray alloc] initWithCapacity:numRails];
    for (int i = 0; i < numRails; i++) {
        [railPositions addObject:@0];
    }
    for (int i = 0; i < [textString length]; i++) {
        int whichRail = [self getCurrentRailForIteration:i withRailTotal:numRails];
        NSNumber *incrementedPosition = @([railPositions[whichRail] intValue] + 1);
        railPositions[whichRail] = incrementedPosition;
        NSString *stringToAppend = rails[whichRail][([incrementedPosition intValue] - 1)];
        [newString appendString:stringToAppend];
    }
    return [[Text alloc] initWithString:newString];
}

- (NSDictionary *)makeRailCountsForTextLength:(int)textLength withRailTotal:(int) numRails{
    NSMutableDictionary *counts = [[NSMutableDictionary alloc] init];
    for (int i = 0; i < textLength; i++) {
        NSNumber *whichRail = @([self getCurrentRailForIteration:i withRailTotal:numRails]);
        if (counts[whichRail] == nil) {
            counts[whichRail] = @0;
        }
        NSNumber *incrementedCount = @([counts[whichRail] intValue] + 1);
        counts[whichRail] = incrementedCount;
    }
    return counts;
}

- (int)getCurrentRailForIteration:(int)iteration withRailTotal:(int) numRails{
    int period = (numRails - 1) * 2;
    iteration = iteration % period;
    if (iteration < (period / 2)) {
        return iteration;
    }else {
        return period - iteration;
    }
}

- (BOOL)isAcceptableKey:(NSString *)key{
    int numRails = [key intValue];
    return (numRails >= 2 && numRails <= 100);
}

- (NSString *)keyPrompt{
    return @"Enter a number of rails between 2 and 100. Note: choosing a number of rails larger than the length of the text will return the original text.";

}

- (NSString *)name {
    return NAME;
}

- (NSString *)info {
    return INFO;
}

@end

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
#import "KeyboardCode.h"
#import "LetterNumber.h"
#import "MorseCode.h"
#import "CaesarCipher.h"
#import "Monoalphabetic.h"
#import "Vigenere.h"
#import "RailFence.h"

@interface CipherFactory()
@end

@implementation CipherFactory

+ (AbstractCipher *)createCipherAtIndex:(int)index {
    return [[[[CipherFactory cipherClasses] objectAtIndex:index] alloc] init];
}

+ (NSArray *)cipherClasses{
    return @[[Atbash class],
            [CaesarCipher class],
            [KeyboardCode class],
            [LetterNumber class],
            [Monoalphabetic class],
            [MorseCode class],
            [RailFence class],
            [Rot13 class],
            [Vigenere class]];
}

+ (NSArray *)cipherDescriptions{
    return @[@"The Atbash Cipher simply flips the letters of the alphabet. 'a' swaps with 'z', 'b' with 'y', 'c' with 'x', and so on.",
            @"This cipher shifts every letter a certain number of letters forward in the alphabet. For example a Caesar Shift of 4 would shift each letter of 'Abe' 4 letters forward giving 'Efi'. Similarly, a shift of 1 would shift each letter of 'Abe' forward 1 giving 'Bcf'. Some implementations use a letter to specify the shift with 'a' corresponding to 1, 'b' to 2, etc. Also note that while it is possible to shift by numbers larger than 25 or smaller than 0, they just wrap around to corresponding shifts between 0 and 25.",
            @"The Keyboard Code is based off of the standard american QWERTY keyboard key arrangements. To encipher, you simply take the key that is one to the right of the desired letter. To decipher, the opposite operation is performed.",
            @"The Letter-Number Code simply replaces the letter with its two-digit position in the alphabet. 'a' is changed into 01, 'b' to 02, 'c' to 03, etc. For example 'Able' is transformed into 01021205.",
            @"Monoalphabetic Substitution switches each letter of the alphabet with another letter of the alphabet. For example, 'a' might be switched with 'h', 'b' with 'x', 'c' with 'm', etc. Some versions of this cipher explicitly specify the switchings for every letter of the alphabet in the key. This means that the key has to be as long as the entire alphabet. However, an easier and shorter way to do this is just to use a keyword: First, duplicated letters are removed from the keyword, and it is placed at the beginning of the alphabet. Then, the rest of the unused letters in the alphabet are placed afterwards. For example, let's use a keyword of 'better'. First remove the duplicates giving 'betr'. Then place it at the beginning of the alphabet and fill in the rest of the unused letters. So if we used 'better' as the keyword, these 26 letter substitutions would be used: 'betracdfghijklmnopqrsuvwxyz'. So 'a' would be switched with 'b', 'b' with 'e', 'c' with 't', 'd' with 'r', etc.",
            @"International Morse Code was invented more than 150 years ago by Samuel Morse. It was originally used to send messages across telegraph wires. The code translates the English letters and the numbers 0-9 into a series of dots and dashes with lengths between 1 and 5. Letters that are used more frequently in common language get shorter lengths so that the message may be transmitted quicker. A single space is placed between each letter and a double space is inserted between words.",
            @"The Rail Fence Cipher does not switch letters with other letters like most of these ciphers. Instead, it transposes the order of the letters. To accomplish this, the letters are laid out in a zig-zagging fashion. The depth of the zig-zag is given by the number of rails. Traditionally, 3 rails are used. After laying out the letters, the message is recombined by pushing the top rail together and putting it first. Then the second rail is pushed together and put after the first. This process is continued through the last rail. For example, to encode the message 'Hello, Jay' with a rail count of 3, you would first lay out the letters in a zig-zag as follows:\n H...o...a.\n .e.l.,.J.y \n ..l..._... \nThen push together the three lines to get 'Hoael,Jyl_' Note that '_' has been used to emphasize the [space], and '.'s have been added for spacing purposes only.",
            @"The ROT13 Cipher is a speciallized case of the Caesar Shift Cipher with a shift value of 13. The ROT13 Cipher has gained popularity, especially in online communities, because enciphering and deciphering can be performed using the same simple process.",
            @"The Vigenere Cipher is a polyalphabetic substitution cipher that was formalized by Blaise de Vigenere in the 19th century, although variations of the cipher had existed hundereds of years prior. It was known as 'The Indecipherable Cipher' for more than 100 years because it was thought to be uncrackable. Now, however, relatively simple algorithms are known for cracking it. The Vigenere Cipher is polyalphabetic in nature because a single letter in the plaintext is not always enciphered to the same letter in the ciphertext. To achieve this, different alphabets are used that depend on the 'current' letter of the keyword. Each letter is enciphered using the Caesar Shifted alphabet corresponding to the current letter of the keyword. For example, let's encipher the word 'better' with the keyword 'king'. The 'b' would be moved forward 10 spaces according to the 'k' Caesar Shift giving 'l'. Then the 'e' would moved forward 8 spaces by the 'i' Caesar Shift alphabet giving 'm'. Then the 't', second 't', second 'e', and 'r' would be shifted forward by 13, 6, 10, and 8 letters respectively corresponding to the 'n', 'g', 'k', and 'i' Caesar Shifts. Putting this all together gives 'lmgzoz' from 'better'."];
}

@end

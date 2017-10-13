//
//  cipher_sender_unit_tests.m
//  cipher-sender-unit-tests
//
//  Created by Julian Tigler on 10/13/17.
//  Copyright © 2017 High5! Apps. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Atbash.h"
#import "CaesarCipher.h"
#import "KeyboardCode.h"
#import "LetterNumber.h"
#import "Monoalphabetic.h"
#import "MorseCode.h"
#import "RailFence.h"
#import "Rot13.h"
#import "Vigenere.h"

@interface cipher_sender_unit_tests : XCTestCase

@end

@implementation cipher_sender_unit_tests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testAtbashEncrypt {
    NSString *plainText = @"abcdefghijklmnopqrstuvwxyz";
    NSString *expectedCipherText = @"zyxwvutsrqponmlkjihgfedcba";
    Atbash *atbash = [[Atbash alloc] init];
    NSString *cipherText = [atbash encrypt:plainText];
    XCTAssertEqualObjects(expectedCipherText, cipherText);
}

- (void)testAtbashDecrypt {
    NSString *cipherText = @"zyxwvutsrqponmlkjihgfedcba";
    NSString *expectedPlaintext = @"abcdefghijklmnopqrstuvwxyz";
    Atbash *atbash = [[Atbash alloc] init];
    NSString *plaintext = [atbash decrpyt:cipherText];
    XCTAssertEqualObjects(expectedPlaintext, plaintext);
}

- (void)testCaesarCipherEncrypt {
    NSString *plainText = @"abcdefghijklmnopqrstuvwxyz";
    NSString *expectedCipherText = @"cdefghijklmnopqrstuvwxyzab";
    NSString *key = @"c";
    CaesarCipher *caesarCipher = [[CaesarCipher alloc] init];
    [caesarCipher setKey:key];
    NSString *cipherText = [caesarCipher encrypt:plainText];
    XCTAssertEqualObjects(expectedCipherText, cipherText);
}

- (void)testCaesarCipherDecrypt {
    NSString *cipherText = @"cdefghijklmnopqrstuvwxyzab";
    NSString *expectedPlainText = @"abcdefghijklmnopqrstuvwxyz";
    NSString *key = @"c";
    CaesarCipher *caesarCipher = [[CaesarCipher alloc] init];
    [caesarCipher setKey:key];
    NSString *plainText = [caesarCipher decrpyt:cipherText];
    XCTAssertEqualObjects(expectedPlainText, plainText);
}

- (void)testKeyboardCodeEncrypt {
    NSString *plainText = @"abcdefghijklmnopqrstuvwxyz";
    NSString *expectedCipherText = @"snvfrghjokl;,mp[wtdyibecux";
    KeyboardCode *keyboardCode = [[KeyboardCode alloc] init];
    NSString *cipherText = [keyboardCode encrypt:plainText];
    XCTAssertEqualObjects(expectedCipherText, cipherText);
}

- (void)testKeyboardCodeDecrypt {
    NSString *cipherText = @"snvfrghjokl;,mp[wtdyibecux";
    NSString *expectedPlainText = @"abcdefghijklmnopqrstuvwxyz";
    KeyboardCode *keyboardCode = [[KeyboardCode alloc] init];
    NSString *plaintext = [keyboardCode decrpyt:cipherText];
    XCTAssertEqualObjects(expectedPlainText, plaintext);
}

- (void)testLetterNumberCodeEncrypt {
    NSString *plainText = @"abcdefghijklmnopqrstuvwxyz";
    NSString *expectedCipherText = @"0102030405060708091011121314151617181920212223242526";
    LetterNumber *letterNumber = [[LetterNumber alloc] init];
    NSString *cipherText = [letterNumber encrypt:plainText];
    XCTAssertEqualObjects(expectedCipherText, cipherText);
}

- (void)testLetterNumberCodeDecrypt {
    NSString *cipherText = @"0102030405060708091011121314151617181920212223242526";
    NSString *expectedPlainText = @"abcdefghijklmnopqrstuvwxyz";
    LetterNumber *letterNumber = [[LetterNumber alloc] init];
    NSString *plaintext = [letterNumber decrpyt:cipherText];
    XCTAssertEqualObjects(expectedPlainText, plaintext);
}

- (void)testMonoalphabeticSubstitutionEncrypt {
    NSString *plainText = @"abcdefghijklmnopqrstuvwxyz";
    NSString *expectedCipherText = @"midnghtabcefjklopqrsuvwxyz";
    NSString *key = @"midnight";
    Monoalphabetic *monoalphabeticSubstition = [[Monoalphabetic alloc] init];
    [monoalphabeticSubstition setKey:key];
    NSString *cipherText = [monoalphabeticSubstition encrypt:plainText];
    XCTAssertEqualObjects(expectedCipherText, cipherText);
}

- (void)testMonoalphabeticSubstitutionDecrypt {
    NSString *cipherText = @"midnghtabcefjklopqrsuvwxyz";
    NSString *expectedPlainText = @"abcdefghijklmnopqrstuvwxyz";
    NSString *key = @"midnight";
    Monoalphabetic *monoalphabeticSubstition = [[Monoalphabetic alloc] init];
    [monoalphabeticSubstition setKey:key];
    NSString *plainText = [monoalphabeticSubstition decrpyt:cipherText];
    XCTAssertEqualObjects(expectedPlainText, plainText);
}

- (void)testMorseCodeEncrypt {
    NSString *plainText = @"abcdefghijklmnopqrstuvwxyz";
    NSString *expectedCipherText = @".- -... -.-. -.. . ..-. --. .... .. .--- -.- .-.. -- -. --- .--. --.- .-. ... - ..- ...- .-- -..- -.-- --..";
    MorseCode *morseCode = [[MorseCode alloc] init];
    NSString *cipherText = [morseCode encrypt:plainText];
    XCTAssertEqualObjects(expectedCipherText, cipherText);
}

- (void)testMorseCodeDecrypt {
    NSString *cipherText = @".- -... -.-. -.. . ..-. --. .... .. .--- -.- .-.. -- -. --- .--. --.- .-. ... - ..- ...- .-- -..- -.-- --..";
    NSString *expectedPlainText = @"abcdefghijklmnopqrstuvwxyz";
    MorseCode *morseCode = [[MorseCode alloc] init];
    NSString *plainText = [morseCode decrpyt:cipherText];
    XCTAssertEqualObjects(expectedPlainText, plainText);
}

- (void)testRailFenceEncrypt {
    NSString *plainText = @"abcdefghijklmnopqrstuvwxyz";
    NSString *expectedCipherText = @"aeimquybdfhjlnprtvxzcgkosw";
    NSString *key = @"3";
    RailFence *railFence = [[RailFence alloc] init];
    [railFence setKey:key];
    NSString *cipherText = [railFence encrypt:plainText];
    XCTAssertEqualObjects(expectedCipherText, cipherText);
}

- (void)testRailFenceDecrypt {
    NSString *cipherText = @"aeimquybdfhjlnprtvxzcgkosw";
    NSString *expectedPlainText = @"abcdefghijklmnopqrstuvwxyz";
    NSString *key = @"3";
    RailFence *railFence = [[RailFence alloc] init];
    [railFence setKey:key];
    NSString *plainText = [railFence decrpyt:cipherText];
    XCTAssertEqualObjects(expectedPlainText, plainText);
}

- (void)testRot13Encrypt {
    NSString *plainText = @"abcdefghijklmnopqrstuvwxyz";
    NSString *expectedCipherText = @"nopqrstuvwxyzabcdefghijklm";
    Rot13 *rot13 = [[Rot13 alloc] init];
    NSString *cipherText = [rot13 encrypt:plainText];
    XCTAssertEqualObjects(expectedCipherText, cipherText);
}

- (void)testRot13Decrypt {
    NSString *cipherText = @"nopqrstuvwxyzabcdefghijklm";
    NSString *expectedPlainText = @"abcdefghijklmnopqrstuvwxyz";
    Rot13 *rot13 = [[Rot13 alloc] init];
    NSString *plainText = [rot13 decrpyt:cipherText];
    XCTAssertEqualObjects(expectedPlainText, plainText);
}

- (void)testVignereEncrypt {
    NSString *plainText = @"abcdefghijklmnopqrstuvwxyz";
    NSString *expectedCipherText = @"mjfqmlnaurnyutviczvgcbdqkh";
    NSString *key = @"midnight";
    Vigenere *vignere = [[Vigenere alloc] init];
    [vignere setKey:key];
    NSString *cipherText = [vignere encrypt:plainText];
    XCTAssertEqualObjects(expectedCipherText, cipherText);
}

- (void)testVignereDecrypt {
    NSString *cipherText = @"mjfqmlnaurnyutviczvgcbdqkh";
    NSString *expectedPlainText = @"abcdefghijklmnopqrstuvwxyz";
    NSString *key = @"midnight";
    Vigenere *vignere = [[Vigenere alloc] init];
    [vignere setKey:key];
    NSString *plainText = [vignere decrpyt:cipherText];
    XCTAssertEqualObjects(expectedPlainText, plainText);
}

@end

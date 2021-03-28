//
//  cipher_sender_unit_tests.m
//  cipher-sender-unit-tests
//
//  Created by Julian Tigler on 10/13/17.
//  Copyright © 2017 High5! Apps. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "A1Z26.h"
#import "Atbash.h"
#import "CaesarCipher.h"
#import "KeyboardShift.h"
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

- (void)testA1Z26Encrypt {
    NSString *plainText = @"abcdefghijklmnopqrstuvwxyz";
    NSString *expectedCipherText = @"0102030405060708091011121314151617181920212223242526";
    AbstractCipher *cipher = [[A1Z26 alloc] init];
    NSString *cipherText = [cipher encrypt:plainText];
    XCTAssertEqualObjects(expectedCipherText, cipherText);
}

- (void)testA1Z26Decrypt {
    NSString *cipherText = @"0102030405060708091011121314151617181920212223242526";
    NSString *expectedPlainText = @"abcdefghijklmnopqrstuvwxyz";
    AbstractCipher *cipher = [[A1Z26 alloc] init];
    NSString *plaintext = [cipher decrypt:cipherText];
    XCTAssertEqualObjects(expectedPlainText, plaintext);
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
    NSString *plaintext = [atbash decrypt:cipherText];
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
    NSString *plainText = [caesarCipher decrypt:cipherText];
    XCTAssertEqualObjects(expectedPlainText, plainText);
}

- (void)testKeyboardShiftEncrypt {
    NSString *plainText = @"abcdefghijklmnopqrstuvwxyz";
    NSString *expectedCipherText = @"snvfrghjokl;,mp[wtdyibecux";
    AbstractCipher *cipher = [[KeyboardShift alloc] init];
    NSString *cipherText = [cipher encrypt:plainText];
    XCTAssertEqualObjects(expectedCipherText, cipherText);
}

- (void)testKeyboardShiftDecrypt {
    NSString *cipherText = @"snvfrghjokl;,mp[wtdyibecux";
    NSString *expectedPlainText = @"abcdefghijklmnopqrstuvwxyz";
    AbstractCipher *cipher = [[KeyboardShift alloc] init];
    NSString *plaintext = [cipher decrypt:cipherText];
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
    NSString *plainText = [monoalphabeticSubstition decrypt:cipherText];
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
    NSString *plainText = [morseCode decrypt:cipherText];
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
    NSString *plainText = [railFence decrypt:cipherText];
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
    NSString *plainText = [rot13 decrypt:cipherText];
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
    NSString *plainText = [vignere decrypt:cipherText];
    XCTAssertEqualObjects(expectedPlainText, plainText);
}

@end

# Cipher Sender iOS App
Send secret messages with your friends! [Cipher Sender](https://github.com/High5Apps/cipher-sender) is free, ad-free, and open source.

[Get it free](https://apple.co/2PgMzzj) on the iOS App Store

## Ciphers
Cipher Sender includes some of the most popular ciphers and codes from throughout history including:
- [A1Z26 Cipher](https://cryptii.com/pipes/a1z26-cipher)
- [Atbash Cipher](https://en.wikipedia.org/wiki/Atbash)
- [Caesar Shift Cipher](https://en.wikipedia.org/wiki/Caesar_cipher)
- [Keyboard Shift Cipher](https://www.dcode.fr/keyboard-shift-cipher)
- [Monoalphabetic Substitution](https://en.wikipedia.org/wiki/Substitution_cipher)
- [Morse Code](https://en.wikipedia.org/wiki/Morse_code)
- [Rail Fence Cipher](https://en.wikipedia.org/wiki/Rail_fence_cipher)
- [ROT13](https://en.wikipedia.org/wiki/ROT13)
- [Vigenere Cipher](https://en.wikipedia.org/wiki/Vigen%C3%A8re_cipher)

### Add a new Cipher
Cipher inputs and outputs are currently limited to [ASCII](https://en.wikipedia.org/wiki/ASCII) characters.

1. Add a new subclass of 
[`KeyedCipher`](https://github.com/High5Apps/cipher-sender/blob/master/cipher-sender/model/KeyedCipher.h), 
[`KeylessCipher`](https://github.com/High5Apps/cipher-sender/blob/master/cipher-sender/model/KeylessCipher.h), or
[`AbstractCipher`](https://github.com/High5Apps/cipher-sender/blob/master/cipher-sender/model/AbstractCipher.h), 
under [`cipher-sender/model/ciphers`](https://github.com/High5Apps/cipher-sender/tree/master/cipher-sender/model/ciphers)
2. Add your new cipher to [`CipherFactory.m`](https://github.com/High5Apps/cipher-sender/blob/master/cipher-sender/model/ciphers/CipherFactory.m)
3. Add unit tests for your new cipher to [`cipher_sender_unit_tests.m`](https://github.com/High5Apps/cipher-sender/blob/master/cipher-sender-unit-tests/cipher_sender_unit_tests.m)

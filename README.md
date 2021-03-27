# Cipher Sender iOS App
Send secret messages with your friends! [Cipher Sender](https://github.com/High5Apps/cipher-sender) is free, ad-free, and open source.

[Get it free on the iOS App Store](https://apple.co/2PgMzzj)

## Ciphers
Cipher Sender includes some of the most popular ciphers and codes from throughout history including:
1. [Caesar Shift Cipher](https://en.wikipedia.org/wiki/Caesar_cipher)
2. [Morse Code](https://en.wikipedia.org/wiki/Morse_code)
3. [Rail Fence Cipher](https://en.wikipedia.org/wiki/Rail_fence_cipher)
4. [ROT13](https://en.wikipedia.org/wiki/ROT13)
5. [Monoalphabetic Substitution](https://en.wikipedia.org/wiki/Substitution_cipher)
6. [Vigenere Cipher](https://en.wikipedia.org/wiki/Vigen%C3%A8re_cipher)
7. Letter-Number Code (aka [A1Z26 Cipher](https://cryptii.com/pipes/a1z26-cipher))
8. [Atbash Cipher](https://en.wikipedia.org/wiki/Atbash)
9. [Keyboard Shift Cipher](https://www.dcode.fr/keyboard-shift-cipher)

### Add a new Cipher
Cipher inputs and outputs are currently limited to ASCII characters.

1. Add a new subclass of 
[`AbstractCipher`](https://github.com/High5Apps/cipher-sender/blob/master/cipher-sender/model/AbstractCipher.h), 
[`KeyedCipher`](https://github.com/High5Apps/cipher-sender/blob/master/cipher-sender/model/KeyedCipher.h), or 
[`KeylessCipher`](https://github.com/High5Apps/cipher-sender/blob/master/cipher-sender/model/KeylessCipher.h), 
under [`cipher-sender/model/ciphers`](https://github.com/High5Apps/cipher-sender/tree/master/cipher-sender/model/ciphers)
2. Add your new cipher to [`CipherFactory.m`](https://github.com/High5Apps/cipher-sender/blob/master/cipher-sender/model/ciphers/CipherFactory.m)

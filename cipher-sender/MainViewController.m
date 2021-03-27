//
//  ViewController.m
//  cipher-sender
//
//  Created by Julian Tigler on 10/4/17.
//  Copyright © 2017 High5! Apps. All rights reserved.
//

#import "MainViewController.h"
#import "CipherFactory.h"

@interface MainViewController ()
@property (strong, nonatomic) CipherFactory *cipherFactory;
@property int cipherIndex;
@property (nonatomic) BOOL isEnciphering;
@end

@implementation MainViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    self.cipherIndex = (int)[prefs integerForKey:@"cipherType"];
    NSString *savedText = [prefs valueForKey:@"inputText"];
    if (savedText == nil) {
        savedText = @"Input Cipher Text Here...";
    }
    self.textView.text = savedText;
    [self addDoneBar];
    
    self.cipherFactory = [[CipherFactory alloc] init];
    
    [self.cipherTypeButton setTitle:self.selectedCipherType forState:UIControlStateNormal];
    self.cipherTypeButton.titleLabel.minimumScaleFactor = 0.5f;
    self.cipherTypeButton.titleLabel.numberOfLines = 2;
    self.cipherTypeButton.titleLabel.adjustsFontSizeToFitWidth = YES;
}

- (void)addDoneBar{
    UIToolbar *doneBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 33)];
    UIBarButtonItem *clearBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Clear" style:UIBarButtonItemStylePlain target:self action:@selector(clear:)];
    UIBarButtonItem *copyButton = [[UIBarButtonItem alloc] initWithTitle:@"Copy" style:UIBarButtonItemStylePlain target:self action:@selector(copyPressed:)];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissKeyboard)];
    UIBarButtonItem *flexibleSpaceLeft = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *flexibleSpaceLeft2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [doneBar setItems:@[clearBarButton, flexibleSpaceLeft, copyButton, flexibleSpaceLeft2, doneButton]];
    [self.textView setInputAccessoryView:doneBar];
}

- (void)saveUserData{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs synchronize];
    [prefs setValue:self.textView.text forKey:@"inputText"];
    [prefs setInteger:self.cipherIndex forKey:@"cipherType"];
}

- (void)dismissKeyboard{
    [self.textView resignFirstResponder];
}

- (IBAction)encipher:(id)sender{
    self.isEnciphering = YES;
    AbstractCipher *ac = self.selectedCipher;
    NSString *plaintext = self.textView.text;
    if ([ac isAcceptablePlaintext:plaintext]) {
        if (ac.needsKey) {
            [self showAlertForCipher:ac];
        }else {
            NSString *ciphertext = [[ac encrypt:plaintext] description];
            self.textView.text = ciphertext;
        }
    }else {
        NSMutableString *message = [NSMutableString stringWithString:@"The plaintext must only contain English ASCII characters"];
        NSString *unacceptableCharacters = [ac getUnacceptableAsciiPlainLetters];
        if (unacceptableCharacters.length > 0) {
            [message appendString:[NSString stringWithFormat:@" and must not contain any of the following characters %@", unacceptableCharacters]];
        }
        [self showUnacceptableInputAlert:message];
    }
}

- (IBAction)decipher:(id)sender{
    self.isEnciphering = NO;
    AbstractCipher *ac = self.selectedCipher;
    NSString *ciphertext = self.textView.text;
    if ([ac isAcceptableCiphertext:ciphertext]) {
        if (ac.needsKey) {
            [self showAlertForCipher:ac];
        }else {
            NSString *plaintext = [[ac decrypt:ciphertext] description];
            self.textView.text = plaintext;
        }
    }else {
        NSMutableString *message = [NSMutableString stringWithString:@"The plaintext must only contain English ASCII characters"];
        NSString *unacceptableCharacters = [ac getUnacceptableAsciiCipherLetters];
        if (unacceptableCharacters.length > 0) {
            [message appendString:[NSString stringWithFormat:@" and must not contain any of the following characters %@", unacceptableCharacters]];
        }
        [self showUnacceptableInputAlert:message];
    }
}

- (void)showUnacceptableInputAlert:(NSString *)message{
    UIAlertController *badTextAlert = [UIAlertController alertControllerWithTitle:@"Unacceptable Input" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:NULL];
    [badTextAlert addAction:okAction];
    [self presentViewController:badTextAlert animated:YES completion:NULL];
}

- (void)showAlertForCipher: (AbstractCipher *)cipher{
    UIAlertController *keyAlert = [UIAlertController alertControllerWithTitle:@"Key" message:cipher.keyPrompt preferredStyle:UIAlertControllerStyleAlert];
    [keyAlert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.keyboardAppearance = UIKeyboardAppearanceDark;
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:NULL];
    [keyAlert addAction:cancelAction];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *unsanitizedKey = keyAlert.textFields.firstObject.text;
        NSString *key = [unsanitizedKey stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        AbstractCipher *ac = self.selectedCipher;
        if ([ac setKey:key]) {
            if (self.isEnciphering) {
                NSString *ciphertext = [[ac encrypt:self.textView.text] description];
                self.textView.text = ciphertext;
            }else {
                NSString *plaintext = [[ac decrypt:self.textView.text] description];
                self.textView.text = plaintext;
            }
        }
    }];
    [keyAlert addAction:okAction];
    [self presentViewController:keyAlert animated:YES completion:NULL];
}

- (IBAction)send:(id)sender{
    NSString *text = self.textView.text;
    NSArray *items = @[text];
    UIActivityViewController *controller = [[UIActivityViewController alloc]initWithActivityItems:items applicationActivities:nil];
    [controller setCompletionWithItemsHandler:^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
        NSNumber *value = @0;
        if (completed) {
            value = @1;
        }
    }];
    [self presentViewController:controller animated:YES completion:NULL];
}

- (void)copyPressed:(id)sender{
    UIPasteboard *clipboard = [UIPasteboard generalPasteboard];
    [clipboard setString:self.textView.text];
}

- (IBAction)pastePressed:(id)sender{
    UIPasteboard *clipboard = [UIPasteboard generalPasteboard];
    self.textView.text = [clipboard string];
}

- (IBAction)clear:(id)sender{
    self.textView.text = @"";
}

- (IBAction)cipherTypePressed:(id)sender{
    CipherPickerTVC *cipherList = [[CipherPickerTVC alloc] initWithStyle:UITableViewStylePlain];
    cipherList.title = @"Choose a Cipher";
    cipherList.delegate = self;
    cipherList.initiallySelectedRow = self.cipherIndex;
    UINavigationController *navcon = [[UINavigationController alloc] initWithRootViewController:cipherList];
    [self presentViewController:navcon animated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    FlipsideViewController *flipsideViewController = [[[segue destinationViewController] viewControllers] objectAtIndex:0];
    flipsideViewController.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Helpers
- (NSString *)selectedCipherType {
    return [CipherFactory cipherNames][self.cipherIndex];
}

- (AbstractCipher *)selectedCipher {
    return [self.cipherFactory cipherForName:self.selectedCipherType];
}

#pragma mark Delegate Methods

- (void)cipherPickerTVCDidSelectDone:(CipherPickerTVC *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)cipherPickerTVC: (CipherPickerTVC *)sender didSelectRowAtIndexPath: (NSIndexPath *)indexPath{
    self.cipherIndex = (int) indexPath.row;
    [self.cipherTypeButton setTitle:self.selectedCipherType forState:UIControlStateNormal];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

//
//  ViewController.m
//  cipher-sender
//
//  Created by Julian Tigler on 10/4/17.
//  Copyright © 2017 High5! Apps. All rights reserved.
//

#import "ViewController.h"
#import "CipherFactory.h"

@interface ViewController ()
@property (strong, nonatomic) CipherFactory *myCipherFactory;
@property (strong, nonatomic) NSString *myCipherType;
@property (nonatomic) BOOL isEnciphering;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    int savedCipherNumber = (int)[prefs integerForKey:@"cipherType"];
    NSString *savedText = [prefs valueForKey:@"inputText"];
    if (savedText == nil) {
        savedText = @"Input Cipher Text Here...";
    }
    self.textView.text = savedText;
    [self addDoneBar];
    
    self.myCipherFactory = [[CipherFactory alloc] init];
    self.myCipherType = [CipherFactory cipherNames][savedCipherNumber];
    [self.cipherTypeButton setTitle:self.myCipherType forState:UIControlStateNormal];
}

- (void)addDoneBar{
    UIToolbar *doneBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 33)];
    doneBar.barStyle = UIBarStyleBlackTranslucent;
    UIBarButtonItem *clearBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Clear" style:UIBarButtonItemStylePlain target:self action:@selector(clear:)];
    NSDictionary *buttonTextAttributes = @{NSFontAttributeName: [UIFont fontWithName:@"CourierNewPS-BoldMT" size:15], NSForegroundColorAttributeName: [UIColor greenColor]};
    [clearBarButton setTitleTextAttributes:buttonTextAttributes forState:UIControlStateNormal];
    UIBarButtonItem *copyButton = [[UIBarButtonItem alloc] initWithTitle:@"Copy" style:UIBarButtonItemStylePlain target:self action:@selector(copyPressed:)];
    [copyButton setTitleTextAttributes:buttonTextAttributes forState:UIControlStateNormal];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissKeyboard)];
    [doneButton setTitleTextAttributes:buttonTextAttributes forState:UIControlStateNormal];
    UIBarButtonItem *flexibleSpaceLeft = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *flexibleSpaceLeft2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [doneBar setItems:@[clearBarButton, flexibleSpaceLeft, copyButton, flexibleSpaceLeft2, doneButton]];
    [self.textView setInputAccessoryView:doneBar];
}

- (void)dismissKeyboard{
    [self.textView resignFirstResponder];
}

- (IBAction)encipher:(id)sender{
    self.isEnciphering = YES;
    AbstractCipher *ac = [self.myCipherFactory cipherForName:self.myCipherType];
    NSString *plaintext = self.textView.text;
    if ([ac isAcceptablePlaintext:plaintext]) {
        if (ac.needsKey) {
            [self showAlertForCipher:ac];
        }else {
            NSString *ciphertext = [[ac encrypt:plaintext] description];
            self.textView.text = ciphertext;
        }
    }else {
        NSString *message = [NSString stringWithFormat: @"The plaintext may not contain any of the following: %@", ac.getUnacceptablePlainLetters];
        [self showUnacceptableInputAlert:message];
    }
}

- (IBAction)decipher:(id)sender{
    self.isEnciphering = NO;
    AbstractCipher *ac = [self.myCipherFactory cipherForName:self.myCipherType];
    NSString *ciphertext = self.textView.text;
    if ([ac isAcceptableCiphertext:ciphertext]) {
        if (ac.needsKey) {
            [self showAlertForCipher:ac];
        }else {
            NSString *plaintext = [[ac decrpyt:ciphertext] description];
            self.textView.text = plaintext;
        }
    }else {
        NSString *message = [NSString stringWithFormat: @"The ciphertext may not contain any of the following: %@", ac.getUnacceptableCipherLetters];
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
        
        AbstractCipher *ac = [self.myCipherFactory cipherForName:self.myCipherType];
        if ([ac setKey:key]) {
            if (self.isEnciphering) {
                NSString *ciphertext = [[ac encrypt:self.textView.text] description];
                self.textView.text = ciphertext;
            }else {
                NSString *plaintext = [[ac decrpyt:self.textView.text] description];
                self.textView.text = plaintext;
            }
        }
    }];
    [keyAlert addAction:okAction];
    [self presentViewController:keyAlert animated:YES completion:NULL];
}

- (IBAction)send:(id)sender{
    NSLog(@"send txt");
//    if ([MFMessageComposeViewController canSendText]) {
//        MFMessageComposeViewController *messageSender = [[MFMessageComposeViewController alloc] init];
//        messageSender.messageComposeDelegate = self;
//        messageSender.body = self.textView.text;
//        [self presentViewController:messageSender animated:YES completion:nil];
//    }else {
//        NSLog(@"Can't send text :(");
//    }
}

- (IBAction)copyPressed:(id)sender{
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
    cipherList.title = @"Choose a Cipher...";
    cipherList.delegate = self;
    UINavigationController *navcon = [[UINavigationController alloc] initWithRootViewController:cipherList];
    navcon.navigationBar.tintColor = [UIColor blackColor];
    [self presentViewController:navcon animated:YES completion:nil];
}

- (IBAction)showInfo:(id)sender{
    NSLog(@"Show info");
//    NSString *flipsideNib;
//    if ([UIScreen mainScreen].bounds.size.height > 480) {
//        flipsideNib = @"FlipsideViewController_4in";
//    }else {
//        flipsideNib = @"FlipsideViewController";
//    }
//    FlipsideViewController *flipsideController = [[FlipsideViewController alloc] initWithNibName:flipsideNib bundle:nil];
//    flipsideController.advert = self.advert;
//    flipsideController.bannerIsVisible = self.bannerIsVisible;
//    flipsideController.delegate = self;
//    flipsideController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//    [self presentViewController:flipsideController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Delegate Methods

- (void)cipherPickerTVCDidSelectDone:(CipherPickerTVC *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)cipherPickerTVC: (CipherPickerTVC *)sender didSelectRowAtIndexPath: (NSIndexPath *)indexPath{
    NSString *selectedCipher = [CipherFactory cipherNames][indexPath.row];
    [self.cipherTypeButton setTitle:selectedCipher forState:UIControlStateNormal];
    self.myCipherType = selectedCipher;
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

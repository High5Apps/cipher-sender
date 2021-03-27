//
//  ViewController.h
//  cipher-sender
//
//  Created by Julian Tigler on 10/4/17.
//  Copyright © 2017 High5! Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CipherPickerTVC.h"
#import "FlipsideViewController.h"

@interface MainViewController : UIViewController<CipherPickerTVCDelegate, FlipsideViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIButton *cipherTypeButton;
@property (strong, nonatomic) IBOutlet UIButton *clearButton;

- (IBAction)encipher:(id)sender;
- (IBAction)decipher:(id)sender;
- (IBAction)share:(id)sender;
- (IBAction)copyPressed:(id)sender;
- (IBAction)pastePressed:(id)sender;
- (IBAction)clear:(id)sender;
- (IBAction)cipherTypePressed:(id)sender;

- (void)saveUserData;

@end

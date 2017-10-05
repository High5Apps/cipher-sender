//
//  ViewController.h
//  cipher-sender
//
//  Created by Julian Tigler on 10/4/17.
//  Copyright © 2017 High5! Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CipherPickerTVC.h"

@interface ViewController : UIViewController<CipherPickerTVCDelegate>

@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIButton *cipherTypeButton;
//@property (strong, nonatomic) IBOutlet UILabel *arrowLabel;
@property (strong, nonatomic) IBOutlet UIButton *clearButton;
//@property (strong, nonatomic) IBOutlet UIButton *encipherButton;
//@property (strong, nonatomic) IBOutlet UIButton *decipherButton;
//@property (strong, nonatomic) IBOutlet UIButton *sendTextButton;
//@property (strong, nonatomic) IBOutlet UIButton *pasteButton;

- (IBAction)showInfo:(id)sender;
- (IBAction)encipher:(id)sender;
- (IBAction)decipher:(id)sender;
- (IBAction)send:(id)sender;
- (IBAction)copyPressed:(id)sender;
- (IBAction)pastePressed:(id)sender;
- (IBAction)clear:(id)sender;
- (IBAction)cipherTypePressed:(id)sender;

@end


//
//  FlipsideViewController.h
//  Cipher Sender
//
//  Created by Julian Tigler on 6/19/12.
//  Copyright (c) 2012 High5! Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "AboutCiphersTableViewController.h"

@class FlipsideViewController;

@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end

@interface FlipsideViewController : UIViewController<MFMailComposeViewControllerDelegate, AboutCiphersTableViewControllerDelegate, UITextViewDelegate>

@property (strong, nonatomic) id <FlipsideViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;

- (IBAction)done:(id)sender;
- (IBAction)about:(id)sender;
- (IBAction)contact:(id)sender;
- (IBAction)rate:(id)sender;

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error;

- (void)aboutCiphersTVCDidSelectDone:(AboutCiphersTableViewController *)sender;


@end

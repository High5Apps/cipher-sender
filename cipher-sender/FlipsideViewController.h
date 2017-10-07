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

@interface FlipsideViewController : UIViewController<MFMailComposeViewControllerDelegate, AboutCiphersTableViewControllerDelegate>

@property (strong, nonatomic) id <FlipsideViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UIButton *about;
@property (strong, nonatomic) IBOutlet UIButton *contact;

- (IBAction)done:(id)sender;
- (IBAction)about:(id)sender;
- (IBAction)contact:(id)sender;

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error;

- (void)aboutCiphersTVCDidSelectDone:(AboutCiphersTableViewController *)sender;


@end

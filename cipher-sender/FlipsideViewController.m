//
//  FlipsideViewController.m
//  Cipher Sender
//
//  Created by Julian Tigler on 6/19/12.
//  Copyright (c) 2012 High5! Apps. All rights reserved.
//

#import "FlipsideViewController.h"
#import "AboutCiphersTableViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation FlipsideViewController

@synthesize delegate = _delegate;

- (void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - Actions

- (IBAction)done:(id)sender{
    [self.delegate flipsideViewControllerDidFinish:self];
}

- (IBAction)about:(id)sender{
    AboutCiphersTableViewController *aboutVC = [[AboutCiphersTableViewController alloc] init];
    aboutVC.title = @"Cipher Info";
    aboutVC.delegate = self;
    UINavigationController *navCon = [[UINavigationController alloc] init];    
    [navCon pushViewController:aboutVC animated:NO];
    [self presentViewController:navCon animated:YES completion:nil];
}

- (IBAction)contact:(id)sender{
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
        controller.mailComposeDelegate = self;
        [controller setSubject:@"Cipher Sender Feedback (iOS)"];
        [controller setToRecipients:@[@"High5Apps@gmail.com"]];
        [self presentViewController:controller animated:YES completion:nil];
    }
}

- (IBAction)rate:(id)sender{
    NSURL *reviewLink = [NSURL URLWithString:@"https://apps.apple.com/app/id548958077?action=write-review"];
    [[UIApplication sharedApplication] openURL:reviewLink options:@{} completionHandler:NULL];
}

- (IBAction)share:(id)sender{
    NSString *text = @"Let's send secret messages! Get Cipher Sender free on the app store: https://apple.co/2PgMzzj";
    NSArray *items = @[text];
    UIActivityViewController *controller = [[UIActivityViewController alloc] initWithActivityItems:items applicationActivities:nil];
    [self presentViewController:controller animated:YES completion:NULL];
}

#pragma mark - Delegate Methods

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)aboutCiphersTVCDidSelectDone:(AboutCiphersTableViewController *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction {
    return YES;
}

@end

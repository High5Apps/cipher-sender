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
    int appStoreId = 548958077;
    static NSString *const iOS7AppStoreURLFormat = @"itms-apps://itunes.apple.com/app/id%d";
    static NSString *const iOSAppStoreURLFormat = @"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%d";
    NSURL *reviewLink = [NSURL URLWithString:[NSString stringWithFormat:([[UIDevice currentDevice].systemVersion floatValue] >= 7.0f)? iOS7AppStoreURLFormat: iOSAppStoreURLFormat, appStoreId]];
    [[UIApplication sharedApplication] openURL:reviewLink options:@{} completionHandler:NULL];
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

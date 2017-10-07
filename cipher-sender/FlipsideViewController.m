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

@interface FlipsideViewController ()

@end

@implementation FlipsideViewController

@synthesize delegate = _delegate;
@synthesize about, contact;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
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
    navCon.navigationBar.tintColor = [UIColor blackColor];
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

#pragma mark - Delegate Methods

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)aboutCiphersTVCDidSelectDone:(AboutCiphersTableViewController *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

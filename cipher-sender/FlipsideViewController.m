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
#import <GAI.h>
#import "GAIDictionaryBuilder.h"
#import "GAIFields.h"

@interface FlipsideViewController ()
@property id<GAITracker> tracker;
@end

@implementation FlipsideViewController

@synthesize delegate = _delegate;
@synthesize about, contact;

- (void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.tracker = [GAI sharedInstance].defaultTracker;
    [self.tracker set:kGAIScreenName value:@"FlipsideViewController"];
    [self.tracker send:[[GAIDictionaryBuilder createScreenView] build]];
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
    
    [self.tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"UIAction" action:@"ButtonPress" label:@"Email" value:nil] build]];
}

- (IBAction)rate:(id)sender{
    int appStoreId = 548958077;
    static NSString *const iOS7AppStoreURLFormat = @"itms-apps://itunes.apple.com/app/id%d";
    static NSString *const iOSAppStoreURLFormat = @"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%d";
    NSURL *reviewLink = [NSURL URLWithString:[NSString stringWithFormat:([[UIDevice currentDevice].systemVersion floatValue] >= 7.0f)? iOS7AppStoreURLFormat: iOSAppStoreURLFormat, appStoreId]];
    [[UIApplication sharedApplication] openURL:reviewLink options:@{} completionHandler:NULL];
    
    [self.tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"UIAction" action:@"ButtonPress" label:@"Rate" value:nil] build]];
}

#pragma mark - Delegate Methods

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)aboutCiphersTVCDidSelectDone:(AboutCiphersTableViewController *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

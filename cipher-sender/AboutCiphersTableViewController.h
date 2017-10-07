//
//  AboutCiphersTableViewController.h
//  Cipher Sender
//
//  Created by Julian Tigler on 6/25/12.
//  Copyright (c) 2012 High5! Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AboutCiphersTableViewController;

@protocol AboutCiphersTableViewControllerDelegate
- (void)aboutCiphersTVCDidSelectDone:(AboutCiphersTableViewController *)sender;
@end

@interface AboutCiphersTableViewController : UITableViewController{
    id <AboutCiphersTableViewControllerDelegate> delegate;
}

@property (strong, nonatomic) id <AboutCiphersTableViewControllerDelegate> delegate;

@end

//
//  CipherPickerTVC.h
//  Cipher Sender
//
//  Created by Julian Tigler on 7/8/12.
//  Copyright (c) 2012 High5! Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CipherPickerTVC;

@protocol CipherPickerTVCDelegate
- (void)cipherPickerTVCDidSelectDone:(CipherPickerTVC *)sender;
- (void)cipherPickerTVC: (CipherPickerTVC *)sender didSelectRowAtIndexPath: (NSIndexPath *)indexPath;
@end

@interface CipherPickerTVC : UITableViewController{
    id <CipherPickerTVCDelegate> delegate;
}

@property (strong, nonatomic) id <CipherPickerTVCDelegate> delegate;

@end

//
//  CustomButton.m
//  Cipher Sender
//
//  Created by Julian Tigler on 7/5/12.
//  Copyright (c) 2012 Duke. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    
    [self.layer setCornerRadius:5.0f];
    [self.layer setBorderWidth:1.0f];
    [self.layer setBorderColor:[[UIColor systemGrayColor] CGColor]];
    
    self.titleEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8);
    
    [self.titleLabel setAdjustsFontForContentSizeCategory:YES];
    
    [self.titleLabel setNumberOfLines:1];
    [self.titleLabel setAdjustsFontSizeToFitWidth:YES];
    [self.titleLabel setMinimumScaleFactor:0.5];
    [self.titleLabel setLineBreakMode:NSLineBreakByClipping];
}

@end

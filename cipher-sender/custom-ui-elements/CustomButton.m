//
//  CustomButton.m
//  Cipher Sender
//
//  Created by Julian Tigler on 7/5/12.
//  Copyright (c) 2012 Duke. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton

static CGFloat const PADDING = 8;

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
    
    BOOL hasImage = (BOOL) self.imageView.image;
    CGFloat imageTitlePadding = hasImage ? (0.5 * PADDING) : 0;
    [self updateInsetsForContentPadding:UIEdgeInsetsMake(PADDING, PADDING, PADDING, PADDING) imageTitlePadding:imageTitlePadding];
    
    [self.titleLabel setAdjustsFontForContentSizeCategory:YES];
    
    [self.titleLabel setNumberOfLines:1];
    [self.titleLabel setAdjustsFontSizeToFitWidth:YES];
    [self.titleLabel setMinimumScaleFactor:0.5];
    [self.titleLabel setLineBreakMode:NSLineBreakByClipping];
}

- (void) updateInsetsForContentPadding:(UIEdgeInsets)contentPadding imageTitlePadding:(CGFloat)imageTitlePadding {
    self.contentEdgeInsets = UIEdgeInsetsMake(contentPadding.top, contentPadding.left, contentPadding.bottom, contentPadding.right + imageTitlePadding);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, imageTitlePadding, 0, -imageTitlePadding);
}

@end

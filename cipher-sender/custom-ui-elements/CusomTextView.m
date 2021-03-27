//
//  CusomTextView.m
//  Cipher Sender
//
//  Created by Julian Tigler on 7/5/12.
//  Copyright (c) 2012 High5! Apps. All rights reserved.
//

#import "CusomTextView.h"
#import <QuartzCore/QuartzCore.h>

@implementation CusomTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self.layer setCornerRadius:5.0f];
    [self.layer setBorderWidth:1.0f];
    [self.layer setBorderColor:[[UIColor systemGrayColor] CGColor]];
}
@end

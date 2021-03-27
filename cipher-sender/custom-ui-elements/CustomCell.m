//
//  CustomCell.m
//  Cipher Sender
//
//  Created by Julian Tigler on 7/21/12.
//  Copyright (c) 2012 High5! Apps. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

@synthesize gradientLayer;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {        
        self.gradientLayer = [[CAGradientLayer alloc] init];
        [self.gradientLayer setBounds:self.bounds];
        [self.gradientLayer setPosition:CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2)];
        [self.gradientLayer setColors:@[(id)[[UIColor greenColor] CGColor], (id)[[UIColor systemBackgroundColor] CGColor]]];
        self.gradientLayer.hidden = YES;
        [self.contentView.layer insertSublayer:gradientLayer atIndex:0];
        [self.contentView.layer setMasksToBounds:YES];        
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    [super setHighlighted:highlighted animated:animated];
    [self.gradientLayer setBounds:self.bounds];
    [self.gradientLayer setPosition:CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2)];

    self.gradientLayer.hidden = !highlighted;
}

@end

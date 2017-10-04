//
//  CustomButton.m
//  Cipher Sender
//
//  Created by Julian Tigler on 7/5/12.
//  Copyright (c) 2012 Duke. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton

@synthesize gradientLayer;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    
    [self addObserver:self forKeyPath:@"highlighted" options:NSKeyValueObservingOptionNew context:NULL];
    
    self.gradientLayer = [[CAGradientLayer alloc] init];
    [self.gradientLayer setBounds:self.bounds];
    [self.gradientLayer setPosition:CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2)];
    [self.gradientLayer setColors:@[(id)[[UIColor greenColor] CGColor], (id)[[UIColor blackColor] CGColor]]];
    self.gradientLayer.hidden = YES;
    [self.layer insertSublayer:gradientLayer atIndex:0];
    [self.layer setMasksToBounds:YES];
    
    [self.layer setBackgroundColor:[[UIColor blackColor]CGColor]];
    [self.layer setCornerRadius:5.0f];
    [self.layer setBorderWidth:1.0f];
    float grayscale = 192.0/255;
    [self.layer setBorderColor:[[UIColor colorWithRed:grayscale green:grayscale blue:grayscale alpha:1]CGColor]];

}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect{    
    [self.gradientLayer setBounds:self.bounds];
    [self.gradientLayer setPosition:CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2)];
    self.gradientLayer.hidden = !self.highlighted;
    [super drawRect:rect];
}

-(CGSize)intrinsicContentSize {
    CGSize s = [super intrinsicContentSize];
    s = CGSizeMake(s.width, 44);
    return s;
}

- (void)dealloc{
    [self removeObserver:self forKeyPath:@"highlighted"];
}

@end

//
//  CipherPickerTVC.m
//  Cipher Sender
//
//  Created by Julian Tigler on 7/8/12.
//  Copyright (c) 2012 High5! Apps. All rights reserved.
//

#import "CipherPickerTVC.h"
#import "CipherFactory.h"
#import "CustomCell.h"

@interface CipherPickerTVC ()

@end

@implementation CipherPickerTVC
@synthesize delegate;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.tableView.backgroundColor = self.backgroundColor;
        [self.tableView setSeparatorColor:[UIColor colorWithWhite:51.0/255 alpha:1.0]];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //must make Done button here bc in loadView, self.delegate is still nil
	UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self.delegate action:@selector(cipherPickerTVCDidSelectDone:)];
    cancelButton.tintColor = [UIColor greenColor];
	self.navigationItem.leftBarButtonItem = cancelButton;
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIFont *)titleFont{
    return [UIFont fontWithName:@"Courier" size:20.0];
}

- (UIColor *)backgroundColor{
    return [UIColor blackColor];
}

- (UIColor *)textColor{
    return [UIColor greenColor];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[CipherFactory cipherNames] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CipherCell";
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.contentView.backgroundColor = self.backgroundColor;
        cell.textLabel.backgroundColor = self.backgroundColor;
        
        cell.textLabel.textColor = self.textColor;
        
        cell.textLabel.font = self.titleFont;
        
        self.tableView.separatorInset = UIEdgeInsetsZero;
    }
    
    // Configure the cell...
    cell.textLabel.text = [CipherFactory cipherNames][indexPath.row];
        
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate cipherPickerTVC:self didSelectRowAtIndexPath:indexPath];
}

@end

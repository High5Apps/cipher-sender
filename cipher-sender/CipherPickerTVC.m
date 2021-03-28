//
//  CipherPickerTVC.m
//  Cipher Sender
//
//  Created by Julian Tigler on 7/8/12.
//  Copyright (c) 2012 High5! Apps. All rights reserved.
//

#import "CipherPickerTVC.h"
#import "CipherFactory.h"

@interface CipherPickerTVC ()
@end

@implementation CipherPickerTVC
@synthesize delegate;
@synthesize initiallySelectedRow;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Removes extra separators from tableview
    self.tableView.tableFooterView = [UIView new];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    // Must make Done button here bc in loadView, self.delegate is still nil
	UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self.delegate action:@selector(cipherPickerTVCDidSelectDone:)];
	self.navigationItem.rightBarButtonItem = cancelButton;
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIFont *)titleFont{
    return [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return CipherFactory.cipherCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CipherCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        cell.textLabel.font = self.titleFont;
        
        self.tableView.separatorInset = UIEdgeInsetsZero;
    }
    
    // Configure the cell...
    AbstractCipher *cipher = [CipherFactory createCipherAtIndex: (int) indexPath.row];
    cell.textLabel.text = cipher.name;
    BOOL isSelectedRow = indexPath.row == self.initiallySelectedRow;
    cell.accessoryType = isSelectedRow ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
        
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

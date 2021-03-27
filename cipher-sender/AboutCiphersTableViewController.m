//
//  AboutCiphersTableViewController.m
//  Cipher Sender
//
//  Created by Julian Tigler on 6/25/12.
//  Copyright (c) 2012 High5! Apps. All rights reserved.
//

#import "AboutCiphersTableViewController.h"
#import "CipherFactory.h"

@interface AboutCiphersTableViewController ()

@end

@implementation AboutCiphersTableViewController

@synthesize delegate;

- (id)initWithStyle:(UITableViewStyle)style{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
        self.tableView.backgroundColor = self.backgroundColor;
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //must make Done button here bc in loadView, self.delegate is still nil
	UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self.delegate action:@selector(aboutCiphersTVCDidSelectDone:)];
	self.navigationItem.rightBarButtonItem = doneButton;
}

- (UIFont *)textFont{
    return [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
}

- (UIFont *)titleFont{
    return [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
}

- (UIColor *)backgroundColor{
    return [UIColor systemBackgroundColor];
}

- (UIColor *)textColor{
    return [UIColor greenColor];
}

- (BOOL)shouldAutorotate{
    return YES;
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
    return [[CipherFactory cipherClasses] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AboutCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.contentView.backgroundColor = self.backgroundColor;
        cell.textLabel.backgroundColor = self.backgroundColor;
        cell.detailTextLabel.backgroundColor = self.backgroundColor;
        
        cell.textLabel.textColor = self.textColor;
        cell.detailTextLabel.textColor = self.textColor;
        
        cell.textLabel.font = self.titleFont;
        cell.detailTextLabel.font = self.textFont;
        
        cell.detailTextLabel.numberOfLines = 0;
        cell.detailTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
    
    // Configure the cell...
    AbstractCipher *cipher = [CipherFactory createCipherAtIndex: (int) indexPath.row];
    cell.textLabel.text = cipher.name;
    cell.detailTextLabel.text = [CipherFactory cipherDescriptions][indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}



@end

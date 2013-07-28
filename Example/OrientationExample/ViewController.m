//
//  ViewController.m
//  OrientationExample
//
//  Created by Andrei Stanescu on 7/28/13.
//  Copyright (c) 2013 Andrei Stanescu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _mainTable.orientation = UITableViewOrientationPortrait;

    [self refreshOrientationLabel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)refreshOrientationLabel
{
    UITableViewOrientation orientation = _mainTable.orientation;
    
    NSArray* labels = [NSArray arrayWithObjects:@"Portrait", @"Landscape Left", @"Landscape Right", @"Upside Down", nil];
    if (orientation >= labels.count)
        _rotateStatusLabel.text = @"Unknown";
    
    _rotateStatusLabel.text = labels[orientation];
}

#pragma mark - UITableView Delegate & DataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"demoCell"];
    if (cell == nil)
    {
        cell = [self loadCellFromNib];
    }
    
    [tableView applyOrientationToCell:cell];
    
    UILabel* label = (UILabel*)[cell.contentView viewWithTag:555];
    
    label.text = [NSString stringWithFormat:@"row %d", indexPath.row];
    
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 15;
}

- (UITableViewCell*)loadCellFromNib
{
    return [[[NSBundle mainBundle] loadNibNamed:@"TableCell" owner:nil options:nil] objectAtIndex:0];
}

- (IBAction)onRotate:(id)sender {
    _mainTable.orientation = (_mainTable.orientation + 1) % 4;   // this is a little hackish, but ok for an example
    
    [_mainTable reloadData];
    [self refreshOrientationLabel];
}
@end

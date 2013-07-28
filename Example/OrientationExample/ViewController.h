//
//  ViewController.h
//  OrientationExample
//
//  Created by Andrei Stanescu on 7/28/13.
//  Copyright (c) 2013 Andrei Stanescu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITableView+Orientation.h"

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *mainTable;
@property (weak, nonatomic) IBOutlet UILabel *rotateStatusLabel;

- (IBAction)onRotate:(id)sender;

@end

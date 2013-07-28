//
//  UITableView+Orientation.h
//  awards
//
//  Created by Andrei Stanescu on 7/28/13.
//  Copyright (c) 2013 Mind Treat Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    UITableViewOrientationPortrait,
    UITableViewOrientationLandscapeLeft,
    UITableViewOrientationLandscapeRight,
    UITableViewOrientationPortraitUpsideDown,
}UITableViewOrientation;

@interface UITableView (Orientation)

@property (nonatomic, readwrite) UITableViewOrientation orientation;

- (void)applyOrientationToCell:(UITableViewCell*)cell;

@end

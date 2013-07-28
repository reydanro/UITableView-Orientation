//
//  UITableView+Orientation.m
//  awards
//
//  Created by Andrei Stanescu on 7/28/13.
//  Copyright (c) 2013 Mind Treat Studios. All rights reserved.
//

#import "UITableView+Orientation.h"
#import <objc/runtime.h>

@implementation UITableView (Orientation)

static const char ORIENTATION_KEY;

- (UITableViewOrientation)orientation
{
    return [objc_getAssociatedObject(self, &ORIENTATION_KEY)  intValue];
}

- (void)setOrientation:(UITableViewOrientation)orientation
{
    objc_setAssociatedObject(self, &ORIENTATION_KEY, [NSNumber numberWithInt:orientation], OBJC_ASSOCIATION_RETAIN/*OBJC_ASSOCIATION_COPY_NONATOMIC*/);
    
    switch (orientation)
    {
        case UITableViewOrientationPortrait:
            break;
        
        case UITableViewOrientationLandscapeRight:
            self.bounds = CGRectMake(0, 0, self.frame.size.height, self.frame.size.width);
            self.transform = CGAffineTransformScale(self.transform, 1, -1);
            self.transform = CGAffineTransformRotate(self.transform, -M_PI_2);
            break;

        case UITableViewOrientationLandscapeLeft:
            self.bounds = CGRectMake(0, 0, self.frame.size.height, self.frame.size.width);
            self.transform = CGAffineTransformRotate(self.transform, M_PI_2);
            break;
        
        case UITableViewOrientationPortraitUpsideDown:
            self.transform = CGAffineTransformScale(self.transform, -1, 1);
            self.transform = CGAffineTransformRotate(self.transform, M_PI);
            break;
    }
    
}

- (void)applyOrientationToCell:(UITableViewCell *)cell
{
    switch (self.orientation)
    {
        case UITableViewOrientationPortrait:
            break;
            
        case UITableViewOrientationLandscapeRight:
            cell.transform = CGAffineTransformRotate(cell.transform, M_PI_2);
            cell.transform = CGAffineTransformScale(cell.transform, 1, -1);
            break;
            
        case UITableViewOrientationLandscapeLeft:
            cell.transform = CGAffineTransformRotate(cell.transform, -M_PI_2);
            break;
            
        case UITableViewOrientationPortraitUpsideDown:
            cell.transform = CGAffineTransformRotate(cell.transform, -M_PI);
            cell.transform = CGAffineTransformScale(cell.transform, -1, 1);
            break;
    }
}

@end

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

- (void)setOrientation:(UITableViewOrientation)newOrientation
{
    UITableViewOrientation prevOrientation = self.orientation;
    
    if (newOrientation == prevOrientation)
        return ;

    objc_setAssociatedObject(self, &ORIENTATION_KEY, [NSNumber numberWithInt:newOrientation], OBJC_ASSOCIATION_RETAIN/*OBJC_ASSOCIATION_COPY_NONATOMIC*/);

    BOOL wasLandscape = (prevOrientation == UITableViewOrientationLandscapeLeft) ||
                        (prevOrientation == UITableViewOrientationLandscapeRight);
    
    switch (newOrientation)
    {
        case UITableViewOrientationPortrait:
            if (wasLandscape)
                self.bounds = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
            self.transform = CGAffineTransformIdentity;
            break;
        
        case UITableViewOrientationLandscapeRight:
            if (!wasLandscape)
                self.bounds = CGRectMake(0, 0, self.frame.size.height, self.frame.size.width);
            self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, -1);
            self.transform = CGAffineTransformRotate(self.transform, -M_PI_2);
            break;

        case UITableViewOrientationLandscapeLeft:
            if (!wasLandscape)
                self.bounds = CGRectMake(0, 0, self.frame.size.height, self.frame.size.width);
            self.transform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI_2);
            break;
        
        case UITableViewOrientationPortraitUpsideDown:
            if (wasLandscape)
                self.bounds = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
            self.transform = CGAffineTransformScale(CGAffineTransformIdentity, -1, 1);
            self.transform = CGAffineTransformRotate(self.transform, M_PI);
            break;
    }
    
}

- (void)applyOrientationToCell:(UITableViewCell *)cell
{
    cell.contentView.backgroundColor = [UIColor lightGrayColor];
    switch (self.orientation)
    {
        case UITableViewOrientationPortrait:
            cell.contentView.transform = CGAffineTransformIdentity;
            break;
            
        case UITableViewOrientationLandscapeRight:
            cell.contentView.transform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI_2);
            cell.contentView.transform = CGAffineTransformScale(cell.contentView.transform, 1, -1);
            break;
            
        case UITableViewOrientationLandscapeLeft:
            cell.contentView.transform = CGAffineTransformRotate(CGAffineTransformIdentity, -M_PI_2);
            break;
            
        case UITableViewOrientationPortraitUpsideDown:
            cell.contentView.transform = CGAffineTransformRotate(CGAffineTransformIdentity, -M_PI);
            cell.contentView.transform = CGAffineTransformScale(cell.contentView.transform, -1, 1);
            break;
    }
}

@end

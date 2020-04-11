//
//  NSLayoutConstraint+Tool.m
//  OhEastMakeWant_Shop
//
//  Created by SZJ on 2020/3/11.
//  Copyright © 2020 SZJ. All rights reserved.
//

#import "NSLayoutConstraint+Tool.h"

@implementation NSLayoutConstraint (Tool)

-(NSLayoutConstraint *)setChangeMultiplier:(float)changeMultiplier{
    if (changeMultiplier > 1.f) changeMultiplier = 1.f;
    [NSLayoutConstraint deactivateConstraints:@[self]];
    NSLayoutConstraint *newConstraint = [NSLayoutConstraint constraintWithItem:self.firstItem attribute:self.firstAttribute relatedBy:self.relation toItem:self.secondItem attribute:self.secondAttribute multiplier:changeMultiplier constant:self.constant];
    newConstraint.priority = self.priority;
    newConstraint.shouldBeArchived = self.shouldBeArchived;
    newConstraint.identifier = self.identifier;
    [NSLayoutConstraint activateConstraints:@[newConstraint]];
    return newConstraint;
}

@end

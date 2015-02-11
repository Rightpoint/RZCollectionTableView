//
//  UICollectionReusableView+ReuseHelpers.m
//  RZCollectionTableViewDemo
//
//  Copyright (c) 2015 Raizlabs. All rights reserved.
//

#import "UICollectionReusableView+ReuseHelpers.h"

@implementation UICollectionReusableView (ReuseHelpers)

+ (UINib *)demo_reuseNib {
    UINib* nib = [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
    return nib;
}

+ (NSString *)demo_reuseIdentifier {
    return NSStringFromClass([self class]);
}

@end

//
//  UICollectionReusableView+ReuseHelpers.h
//  RZCollectionTableViewDemo
//
//  Copyright (c) 2015 Raizlabs. All rights reserved.
//

@import UIKit;

@interface UICollectionReusableView (ReuseHelpers)

/**
 *  Returns a UINib created in the main bundle with the name of the class as the name of the xib.
 *
 *  @return The UINib to pass to the collectionView
 */
+ (UINib *)demo_reuseNib;

/**
 *  Uses the class name as the Resuse identifier.
 *
 *  @return The reuse identifier for the cell
 */
+ (NSString *)demo_reuseIdentifier;

@end

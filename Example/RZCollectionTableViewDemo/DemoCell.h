//
//  DemoCell.h
//  RZCollectionTableViewDemo
//
//  Copyright (c) 2015 Raizlabs. All rights reserved.
//

@import UIKit;

#import "RZCollectionTableViewCell.h"


@class DemoCell;

@interface DemoCell : RZCollectionTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *headingLabel;
@property (weak, nonatomic) IBOutlet UILabel *subheadingLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

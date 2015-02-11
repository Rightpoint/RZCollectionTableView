//
//  DemoCell.m
//  RZCollectionTableViewDemo
//
//  Copyright (c) 2015 Raizlabs. All rights reserved.
//

#import "DemoCell.h"


@interface DemoCell ()

@end

@implementation DemoCell

- (void)initWithHeading:(NSString *)heading subheading:(NSString *)subheading andImage:(NSString *)imageName {
    self.headingLabel.text = heading;
    self.subheadingLabel.text = subheading;
    self.imageView.image = [UIImage imageNamed:imageName];
}

@end

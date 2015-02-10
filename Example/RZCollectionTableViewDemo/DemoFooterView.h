//
//  DemoFooterView.h
//  RZCollectionTableViewDemo
//
//  Copyright (c) 2015 Raizlabs. All rights reserved.
//

@import UIKit;

@class DemoFooterView;

@protocol DemoFooterDelegate <NSObject>

- (void)demoFooterAddSectionPressed:(DemoFooterView*)footerView;

@end

@interface DemoFooterView : UICollectionReusableView

@property (nonatomic, assign) NSUInteger sectionIndex;
@property (nonatomic, weak) id<DemoFooterDelegate> delegate;

@end

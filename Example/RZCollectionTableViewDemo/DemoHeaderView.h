//
//  DemoHeaderView.h
//  RZCollectionTableViewDemo
//
//  Copyright (c) 2015 Raizlabs. All rights reserved.
//

@import UIKit;

@class DemoHeaderView;

@protocol DemoHeaderDelegate <NSObject>

- (void)demoHeaderDeleteSectionPressed:(DemoHeaderView*)headerView;

@end

@interface DemoHeaderView : UICollectionReusableView

@property (nonatomic, assign) NSUInteger sectionIndex;
@property (nonatomic, assign) BOOL hideDelete;

@property (nonatomic, weak) id<DemoHeaderDelegate> delegate;

@end

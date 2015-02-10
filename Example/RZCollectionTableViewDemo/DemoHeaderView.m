//
//  DemoHeaderView.m
//  RZCollectionTableViewDemo
//
//  Copyright (c) 2015 Raizlabs. All rights reserved.
//

#import "DemoHeaderView.h"

@interface DemoHeaderView ()

@property (weak,nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

@end

@implementation DemoHeaderView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if ( self ) {
        _sectionIndex = NSNotFound;
    }
    return self;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    _sectionIndex = NSNotFound;
    self.hideDelete = YES;
}

- (void)setHideDelete:(BOOL)hideDelete
{
    _hideDelete = hideDelete;
    self.deleteButton.hidden = hideDelete;
}

- (void)setSectionIndex:(NSUInteger)sectionIndex
{
    _sectionIndex = sectionIndex;
    self.label.text = [NSString stringWithFormat:@"Header %lu", sectionIndex];
}

- (IBAction)deleteSectionPressed:(id)sender
{
    [self.delegate demoHeaderDeleteSectionPressed:self];
}

@end

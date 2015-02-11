//
//  DemoFooterView.m
//  RZCollectionTableViewDemo
//
//  Copyright (c) 2015 Raizlabs. All rights reserved.
//

#import "DemoFooterView.h"

@interface DemoFooterView ()

@property (weak,nonatomic) IBOutlet UILabel *label;

- (IBAction)addSectionPressed:(id)sender;


@end

@implementation DemoFooterView

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
}

- (void)setSectionIndex:(NSUInteger)sectionIndex
{
    _sectionIndex = sectionIndex;
    self.label.text = [NSString stringWithFormat:@"Footer %lu", sectionIndex];
}

- (IBAction)addSectionPressed:(id)sender {
    [self.delegate demoFooterAddSectionPressed:self];
}


@end

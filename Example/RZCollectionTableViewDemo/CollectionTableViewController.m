//
//  CollectionTableViewController.m
//  RZCollectionTableViewDemo
//
//  Copyright (c) 2015 Raizlabs. All rights reserved.
//

#import "CollectionTableViewController.h"

#import "RZCollectionTableView.h"
#import "UICollectionReusableView+ReuseHelpers.h"
#import "DemoCell.h"
#import "DemoHeaderView.h"
#import "DemoFooterView.h"
#import "DetailViewController.h"


@interface CollectionTableViewController () <DemoHeaderDelegate, DemoFooterDelegate, RZCollectionTableViewLayoutDelegate, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet RZCollectionTableView *collectionView;
@property (nonatomic, strong) NSMutableArray *sections;

@end

@implementation CollectionTableViewController

#define kCollectionTableViewDemoTitle     NSLocalizedString(@"CollectionTableViewDemo", @"")

static CGFloat const kRowHeight = 132.0f;

static CGFloat const kHeaderHeight = 26.0f;
static CGFloat const kFooterHeight = 34.0f;

static CGFloat const kRowSpacing = 1.0f;

static UIEdgeInsets const kSectionInsets = { .left = 0, .right = 0, .top = 5, .bottom = 5 };


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.delegate = self;
    
    // Table.plist is an array of sections each containing an array of rows of strings
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Table" ofType:@"plist"];
    self.sections = [NSMutableArray arrayWithContentsOfFile:filePath];

    [self configureCollectionView];

    self.title = kCollectionTableViewDemoTitle;
}

- (void)configureCollectionView {
    ((RZCollectionTableViewLayout*) self.collectionView.collectionViewLayout).rowHeight = kRowHeight;

    ((RZCollectionTableViewLayout*) self.collectionView.collectionViewLayout).headerHeight = kHeaderHeight;
    ((RZCollectionTableViewLayout*) self.collectionView.collectionViewLayout).footerHeight = kFooterHeight;

    ((RZCollectionTableViewLayout*) self.collectionView.collectionViewLayout).rowSpacing = kRowSpacing;

    ((RZCollectionTableViewLayout*) self.collectionView.collectionViewLayout).sectionInsets = kSectionInsets;
    
    ((RZCollectionTableViewLayout*) self.collectionView.collectionViewLayout).allowsHeaderViewsToFloat = YES;
    
    [self.collectionView registerNib:[DemoCell demo_reuseNib] forCellWithReuseIdentifier:[DemoCell demo_reuseIdentifier]];
    [self.collectionView registerNib:[DemoHeaderView demo_reuseNib] forSupplementaryViewOfKind:RZCollectionTableViewLayoutHeaderView withReuseIdentifier:[DemoHeaderView demo_reuseIdentifier]];
    [self.collectionView registerNib:[DemoFooterView demo_reuseNib] forSupplementaryViewOfKind:RZCollectionTableViewLayoutFooterView withReuseIdentifier:[DemoFooterView demo_reuseIdentifier]];
}

#pragma mark - Object insert/delete

- (void)insertRowInSection:(NSUInteger)section
{
    NSMutableArray *rows = [self.sections[section]objectAtIndex:0];
    [rows addObject:@""];
    [self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:rows.count-1 inSection:section]]];
}

- (void)deleteRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *items = [self.sections[indexPath.section] objectAtIndex:0];
    [items removeObjectAtIndex:indexPath.row];
    [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
}

- (void)insertSectionAtIndex:(NSUInteger)index
{
    [self.sections insertObject:[NSMutableArray arrayWithObject:[NSMutableArray arrayWithObject:@""]] atIndex:index];
    
    // Batch this so the other sections will be updated on completion
    [self.collectionView performBatchUpdates:^{
        [self.collectionView insertSections:[NSIndexSet indexSetWithIndex:index]];
    }
                                  completion:^(BOOL finished) {
                                      [self.collectionView reloadData];
                                  }];
}

- (void)deleteSectionAtIndex:(NSUInteger)index
{
    [self.sections removeObjectAtIndex:index];
    
    // Batch this so the other sections will be updated on completion
    [self.collectionView performBatchUpdates:^{
        [self.collectionView deleteSections:[NSIndexSet indexSetWithIndex:index]];
    }
                                  completion:^(BOOL finished) {
                                      [self.collectionView reloadData];
                                  }];
}

#pragma mark - DemoHeaderDelegate

- (void)demoHeaderDeleteSectionPressed:(DemoHeaderView *)headerView
{
    if ( headerView.sectionIndex != NSNotFound ) {
        [self deleteSectionAtIndex:headerView.sectionIndex];
    }
}

#pragma mark - DemoFooterDelegate

- (void)demoFooterAddSectionPressed:(DemoFooterView *)footerView
{
    if ( footerView.sectionIndex != NSNotFound ) {
        [self insertSectionAtIndex:footerView.sectionIndex+1];
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [self.sections count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray *items = [self.sections objectAtIndex:section];
    return [[items objectAtIndex:0]count];
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DemoCell *demoCell =
    [collectionView dequeueReusableCellWithReuseIdentifier:[DemoCell demo_reuseIdentifier]
                                              forIndexPath:indexPath];
    
    demoCell.headingLabel.text = [NSString stringWithFormat:@"(%lu, %lu)", indexPath.section, indexPath.row];
    
    RZCollectionTableViewCellAttributes *rowAttributes = (RZCollectionTableViewCellAttributes *)[self.collectionView layoutAttributesForItemAtIndexPath:indexPath];
    
    
    if ( [rowAttributes isKindOfClass:[RZCollectionTableViewCellAttributes class]] ) {
        switch (rowAttributes.rowPosition) {
            case RZCollectionTableViewCellRowPositionSolo: {
                demoCell.subheadingLabel.text = @"Solo";
            }
                break;
            case RZCollectionTableViewCellRowPositionTop: {
                demoCell.subheadingLabel.text = @"Top";
            }
                break;
            case RZCollectionTableViewCellRowPositionBottom: {
                demoCell.subheadingLabel.text = @"Bottom";
            }
                break;
            case RZCollectionTableViewCellRowPositionMiddle: {
                demoCell.subheadingLabel.text = @"Middle";
            }
                break;
            default:
                break;
        }
    }
    
    RZCollectionTableViewCellEditingAction *deleteEditingAction = [RZCollectionTableViewCellEditingAction
        actionWithTitle:@"Delete"
        font:[UIFont systemFontOfSize:16]
        titleColor:[UIColor whiteColor]
        highlightedTitlecolor:[UIColor blueColor]
        backgroundColor:[UIColor redColor]];
    
    RZCollectionTableViewCellEditingAction *addEditingAction = [RZCollectionTableViewCellEditingAction
        actionWithTitle:@"Add"
        font:[UIFont systemFontOfSize:16]
        titleColor:[UIColor blackColor]
        highlightedTitlecolor:[UIColor blueColor]
        backgroundColor:[UIColor greenColor]];

    NSArray *editingActions = [NSArray arrayWithObjects:deleteEditingAction, addEditingAction, nil];
    
    [demoCell setRzEditingActions:editingActions];
    [demoCell setRzEditingEnabled:YES];

    return demoCell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *result = nil;
    
    if ( [kind isEqualToString:RZCollectionTableViewLayoutHeaderView] ) {
        DemoHeaderView *headerView = [self.collectionView  dequeueReusableSupplementaryViewOfKind:kind
            withReuseIdentifier:[DemoHeaderView demo_reuseIdentifier]
            forIndexPath:indexPath];
        
        headerView.delegate = self;
        headerView.sectionIndex = indexPath.section;
        headerView.hideDelete = collectionView.numberOfSections == 1; // hide when only one section

        result = headerView;
    } else if ( [kind isEqualToString:RZCollectionTableViewLayoutFooterView] ) {
        DemoFooterView *footerView = [self.collectionView  dequeueReusableSupplementaryViewOfKind:kind
            withReuseIdentifier:[DemoFooterView demo_reuseIdentifier]
            forIndexPath:indexPath];
        
        footerView.delegate = self;
        footerView.sectionIndex = indexPath.section;

        result = footerView;
    }
    
    return result;
}

#pragma mark - RZCollectionTableViewLayoutDelegate

- (CGFloat)collectionView:(UICollectionView *)collectionView rzTableLayout:(RZCollectionTableViewLayout *)layout estimatedHeightForRowAtIndexPath:(NSIndexPath*)indexPath {
    
    return kRowHeight;
}

- (void)collectionView:(UICollectionView *)collectionView rzTableLayout:(RZCollectionTableViewLayout *)layout editingButtonPressedForIndex:(NSUInteger)buttonIndex forRowAtIndexPath:(NSIndexPath*)indexPath {
    
    // Batch this so the other sections will be updated on completion
    [self.collectionView performBatchUpdates:^{
        if ( buttonIndex == 0 ) {
            [self deleteRowAtIndexPath:indexPath];
        }
        else if ( buttonIndex == 1 ) {
            [self insertRowInSection:indexPath.section];
        }
    }
                                  completion:^(BOOL finished) {
                                      [self.collectionView reloadData];
                                  }];
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"ShowDetail" sender:self];
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ( [[segue identifier] isEqualToString:@"ShowDetail"] )
    {
        NSIndexPath *selectedIndexPath = [[self.collectionView indexPathsForSelectedItems] objectAtIndex:0];
        
        DetailViewController *detailViewController = [segue destinationViewController];
        detailViewController.sectionText = [NSString stringWithFormat:@"Section %lu", selectedIndexPath.section];
        detailViewController.rowText = [NSString stringWithFormat:@"Row %lu", selectedIndexPath.row];
    }
}


@end

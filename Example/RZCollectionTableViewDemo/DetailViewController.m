//
//  DetailViewController.m
//  RZCollectionTableViewDemo
//
//  Copyright (c) 2015 Raizlabs. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *sectionLabel2;
@property (weak, nonatomic) IBOutlet UILabel *rowLabel2;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.sectionLabel2.text = self.sectionText;
    self.rowLabel2.text = self.rowText;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

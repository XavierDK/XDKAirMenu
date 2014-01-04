//
//  ViewController.m
//  XDKAirMenu
//
//  Created by Xavier De Koninck on 29/12/2013.
//  Copyright (c) 2013 XavierDeKoninck. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <XDKAirMenuDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end


@implementation ViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
        
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.airMenuController = [[XDKAirMenuController alloc] init];
    self.airMenuController.airDelegate = self;

    [self.view addSubview:self.airMenuController.view];
    [self addChildViewController:self.airMenuController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"TableViewSegue"])
    {
        self.tableView = ((UITableViewController*)segue.destinationViewController).tableView;
    }
}


#pragma mark - XDKAirMenuDelegate

- (NSInteger)numberOfSectionsForAirMenu:(XDKAirMenuController*)airMenu
{
    return self.tableView.numberOfSections;
}

- (NSInteger)airMenu:(XDKAirMenuController*)airMenu numberOfRowInSection:(NSInteger)section
{
    return [self.tableView numberOfRowsInSection:section];
}

- (UIViewController*)airMenu:(XDKAirMenuController*)airMenu viewControllerAtIndexPath:(NSIndexPath*)indexPath
{
    UIStoryboard *storyboard = self.storyboard;
    UIViewController *vc = nil;
    
    if (indexPath.row == 0)
        vc = [storyboard instantiateViewControllerWithIdentifier:@"ViewController1"];
    else if (indexPath.row == 1)
        vc = [storyboard instantiateViewControllerWithIdentifier:@"ViewController2"];
    
    return vc;
}

- (UITableView*)tableViewForAirMenu:(XDKAirMenuController*)airMenu
{
    return self.tableView;
}

@end

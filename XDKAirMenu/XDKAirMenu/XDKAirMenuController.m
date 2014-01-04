//
//  XDKAirMenuController.m
//  XDKAirMenu
//
//  Created by Xavier De Koninck on 29/12/2013.
//  Copyright (c) 2013 XavierDeKoninck. All rights reserved.
//

#import "XDKAirMenuController.h"
#import <QuartzCore/QuartzCore.h>

#define WIDTH_OPENED (35.f)
#define MIN_SCALE_CONTROLLER (0.5f)
#define MIN_SCALE_TABLEVIEW (0.8f)
#define MIN_ALPHA_TABLEVIEW (0.01f)
#define DELTA_OPENING (25.f)


@interface XDKAirMenuController ()<UITableViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, assign) CGPoint startLocation;
@property (nonatomic, assign) CGPoint lastLocation;
@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, assign) BOOL isMenuOpened;

@end


@implementation XDKAirMenuController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self.airDelegate respondsToSelector:@selector(tableViewForAirMenu:)])
    {
        self.tableView = [self.airDelegate tableViewForAirMenu:self];
        self.tableView.delegate = self;
    }
    
    self.isMenuOpened = FALSE;
    [self openViewControllerAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    UIWindow *frontWindow = [[UIApplication sharedApplication] keyWindow];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    [frontWindow addGestureRecognizer:panGesture];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)panGesture:(UIPanGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        self.startLocation = [sender locationInView:self.view];
        NSLog(@"LOCATION : %f", self.startLocation.x);
    }
    else if (sender.state == UIGestureRecognizerStateEnded && (self.isMenuOpened || self.startLocation.x < DELTA_OPENING)) {
        
        CGFloat dx = self.lastLocation.x - self.startLocation.x;
        
        NSLog(@"====>  %f", dx);
        
        if ((self.isMenuOpened && dx < 0.f) || self.view.frame.origin.x < self.view.frame.size.width / 4)
            [self animationCloseMenu];
        else
            [self animationOpenMenu];
    }
    else if (sender.state == UIGestureRecognizerStateChanged && (self.isMenuOpened || self.startLocation.x < DELTA_OPENING)) {
        
        CGPoint stopLocation = [sender locationInView:self.view];
        self.lastLocation = stopLocation;
        
        CGFloat dx = stopLocation.x - self.startLocation.x;
        
        CGFloat distance = dx;
        
        CGFloat scaleController = 1 - ((self.view.frame.origin.x / (self.view.frame.size.width - WIDTH_OPENED)) * (1-MIN_SCALE_CONTROLLER));
        
        CGFloat scaleTableView = 1 - ((1 - MIN_SCALE_TABLEVIEW) + ((self.view.frame.origin.x / (self.view.frame.size.width - WIDTH_OPENED)) * (-1+MIN_SCALE_TABLEVIEW)));
        
        CGFloat alphaTableView = 1 - ((1 - MIN_ALPHA_TABLEVIEW) + ((self.view.frame.origin.x / (self.view.frame.size.width - WIDTH_OPENED)) * (-1+MIN_ALPHA_TABLEVIEW)));
        
        
        NSLog(@"scale2 : %f", scaleTableView);
        
        if (scaleTableView < MIN_SCALE_TABLEVIEW)
            scaleTableView = MIN_SCALE_TABLEVIEW;
        
        if (scaleController > 1.f)
            scaleController = 1.f;
        
        
        NSLog(@"distance : %f , newScale : %f", distance, scaleController);
        
        self.tableView.transform = CGAffineTransformMakeScale(scaleTableView, scaleTableView);
        
        self.tableView.alpha = alphaTableView;
        
        self.currentViewController.view.transform = CGAffineTransformMakeScale(scaleController, scaleController);
        
        CGRect frame = self.view.frame;
        frame.origin.x = frame.origin.x + distance;
        if (frame.origin.x < 0.f)
            frame.origin.x = 0.f;
        if (frame.origin.x > (frame.size.width))
            frame.origin.x = (frame.size.width);
        
        self.view.frame = frame;
        
        NSLog(@"new X : %f", frame.origin.x);
        
        frame = self.currentViewController.view.frame;
        frame.origin.x = 0.f;
        self.currentViewController.view.frame = frame;
    }
    
}

- (void)animationOpenMenu
{
    [UIView animateWithDuration:0.3f animations:^{
        
        self.currentViewController.view.transform = CGAffineTransformMakeScale(MIN_SCALE_CONTROLLER, MIN_SCALE_CONTROLLER);
        
        CGRect frame = self.view.frame;
        frame.origin.x = frame.size.width - WIDTH_OPENED;
        
        self.view.frame = frame;
        
        self.tableView.alpha = 1.f;
        
        self.tableView.transform = CGAffineTransformMakeScale(1.f, 1.f);
        
        NSLog(@"new X : %f", frame.origin.x);
        
        frame = self.currentViewController.view.frame;
        frame.origin.x = 0.f;
        self.currentViewController.view.frame = frame;
    }];
    
    self.isMenuOpened = TRUE;
}

- (void)animationCloseMenu
{
    [UIView animateWithDuration:0.3f animations:^{
        
        self.currentViewController.view.transform = CGAffineTransformMakeScale(1.f, 1.f);
        
        CGRect frame = self.view.frame;
        frame.origin.x = 0.f;
        self.view.frame = frame;
        
        self.tableView.alpha = MIN_ALPHA_TABLEVIEW;
        
        self.tableView.transform = CGAffineTransformMakeScale(MIN_SCALE_TABLEVIEW, MIN_SCALE_TABLEVIEW);
        
        NSLog(@"new X : %f", frame.origin.x);
        
        frame = self.currentViewController.view.frame;
        frame.origin.x = 0.f;
        self.currentViewController.view.frame = frame;
    }];
    
    self.isMenuOpened = FALSE;
}

- (void)openMenu
{
    self.isMenuOpened = TRUE;
    CGRect frame = self.view.frame;
    frame.origin.x = (frame.size.width - WIDTH_OPENED);
    self.view.frame = frame;
}

- (void)openViewControllerAtIndexPath:(NSIndexPath*)indexPath
{
    if ([self.airDelegate respondsToSelector:@selector(airMenu:viewControllerAtIndexPath:)])
    {
        BOOL firstTime = FALSE;
        if (self.currentViewController == nil)
            firstTime = TRUE;
        
        self.currentViewController = [self.airDelegate airMenu:self viewControllerAtIndexPath:indexPath];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(animationCloseMenu)];
        tapGesture.delegate = self;
        [self.currentViewController.view addGestureRecognizer:tapGesture];
                
        [self.view addSubview:self.currentViewController.view];
        [self addChildViewController:self.currentViewController];
        
        CGRect frame = self.currentViewController.view.frame;
        frame.origin.x = 0.f;
        self.currentViewController.view.frame = frame;
        
        if (!firstTime)
        {
            self.currentViewController.view.transform = CGAffineTransformMakeScale(MIN_SCALE_CONTROLLER, MIN_SCALE_CONTROLLER);
            
            CGRect frame = self.view.frame;
            frame.origin.x = frame.size.width - WIDTH_OPENED;
            self.view.frame = frame;
            
            self.tableView.alpha = 1.f;
            
            self.tableView.transform = CGAffineTransformMakeScale(1.f, 1.f);
            
            frame = self.currentViewController.view.frame;
            frame.origin.x = 0.f;
            self.currentViewController.view.frame = frame;
            
            [self animationCloseMenu];
        }
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if (self.isMenuOpened)
        return TRUE;
    return FALSE;
}


#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.currentViewController.view removeFromSuperview];
    [self.currentViewController removeFromParentViewController];
    [self openViewControllerAtIndexPath:indexPath];
}

@end

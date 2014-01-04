//
//  XDKAirMenuController.h
//  XDKAirMenu
//
//  Created by Xavier De Koninck on 29/12/2013.
//  Copyright (c) 2013 XavierDeKoninck. All rights reserved.
//

#import <UIKit/UIKit.h>


@class XDKAirMenuController;


@protocol XDKAirMenuDelegate <NSObject>

@required

- (NSInteger)numberOfSectionsForAirMenu:(XDKAirMenuController*)airMenu;
- (NSInteger)airMenu:(XDKAirMenuController*)airMenu numberOfRowInSection:(NSInteger)section;
- (UITableView*)tableViewForAirMenu:(XDKAirMenuController*)airMenu;
- (UIViewController*)airMenu:(XDKAirMenuController*)airMenu viewControllerAtIndexPath:(NSIndexPath*)indexPath;

@end


@interface XDKAirMenuController : UIViewController

@property (nonatomic, strong) UIViewController *currentViewController;
@property (nonatomic, weak) id<XDKAirMenuDelegate> airDelegate;

@end

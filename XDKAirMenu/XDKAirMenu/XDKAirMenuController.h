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

/**
 *  Method of protocol returning number of sections for the menu
 *
 *  @param airMenu The menu caller
 *
 *  @return Number of sections for the menu
 */
- (NSInteger)numberOfSectionsForAirMenu:(XDKAirMenuController*)airMenu;

/**
 *  Method of protocol returning number of rows in a section
 *
 *  @param airMenu The menu caller
 *
 *  @param section The section index
 *
 *  @return Number of rows in the section
 */
- (NSInteger)airMenu:(XDKAirMenuController*)airMenu numberOfRowInSection:(NSInteger)section;

/**
 *  Method of protocol returning the tableView used by the menu
 *
 *  @param airMenu The menu caller
 *
 *  @return The tableView used by the menu
 */
- (UITableView*)tableViewForAirMenu:(XDKAirMenuController*)airMenu;

/**
 *  Method of protocol returning the viewController used by the menu at the indexPath
 *
 *  @param airMenu The menu caller
 *
 *  @param indexPath The indexPath
 *
 *  @return The viewController used by the menu at the indexPath
 */
- (UIViewController*)airMenu:(XDKAirMenuController*)airMenu viewControllerAtIndexPath:(NSIndexPath*)indexPath;

@end


@interface XDKAirMenuController : UIViewController

@property (nonatomic, strong, readonly) UIViewController *currentViewController;
@property (nonatomic, weak) id<XDKAirMenuDelegate> airDelegate;
@property (nonatomic, assign, readonly) BOOL isMenuOpened;

+ (instancetype)sharedMenu;

- (void)openMenuAnimated;
- (void)closeMenuAnimated;

@end

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


@optional

/**
 *  Method of protocol returning the width of visible part (Default : 35.f)
 *
 *  @param airMenu The menu caller
 *
 *  @return The width of visible part for controller when menu opened
 */
- (CGFloat)widthControllerForAirMenu:(XDKAirMenuController*)airMenu;

/**
 *  Method of protocol returning the minimum of scale for the controller (Default : 0.5f)
 *
 *  @param airMenu The menu caller
 *
 *  @return The minimum of scale for the controller
 */
- (CGFloat)minScaleControllerForAirMenu:(XDKAirMenuController*)airMenu;

/**
 *  Method of protocol returning the minimum of scale for the tableView (Default : 0.8f)
 *
 *  @param airMenu The menu caller
 *
 *  @return The minimum of scale for the tableView
 */
- (CGFloat)minScaleTableViewForAirMenu:(XDKAirMenuController*)airMenu;

/**
 *  Method of protocol returning the minimum of alpha for the tableView (Default : 0.01f)
 *
 *  @param airMenu The menu caller
 *
 *  @return The minimum of alpha for the tableView
 */
- (CGFloat)minAlphaTableViewForAirMenu:(XDKAirMenuController*)airMenu;

@end



/**
 *
 * Controller which is in charge of managing a XDKAirMenu
 *
 */
@interface XDKAirMenuController : UIViewController


/**
 * The actual viewController opened by the menu
 */
@property (nonatomic, strong, readonly) UIViewController *currentViewController;

/**
 * The delegate of the XDKAirMenuController
 */
@property (nonatomic, weak) id<XDKAirMenuDelegate> airDelegate;

/**
 * A boolean indicating if the menu is opened or not
 */
@property (nonatomic, assign, readonly) BOOL isMenuOpened;

/**
 * A boolean indicating if the menu should be on right or not
 */
@property (nonatomic, assign) BOOL isMenuOnRight;


/**
 *  Method returning the singleton instance of the XDKAirMenuController
 *
 *  @return An instance of XDKAirMenuController
 */
+ (instancetype)sharedMenu;

/**
 * Method to open menu with animation
 */
- (void)openMenuAnimated;

/**
 * Method to close menu with animation
 */
- (void)closeMenuAnimated;


@end

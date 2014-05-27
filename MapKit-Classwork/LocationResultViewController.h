//
//  LocationResultViewController.h
//  MapKit-Classwork
//
//  Created by Evan Baumgardner on 5/27/14.
//  Copyright (c) 2014 Evan Baumgardner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "LocationResultsTableViewCell.h"
#import "MapRouteViewController.h"

@interface LocationResultsTableViewController : UITableViewController

@property (strong, nonatomic) NSArray *mapItems;

@end

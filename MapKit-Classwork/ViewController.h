//
//  ViewController.h
//  MapKit-Classwork
//
//  Created by Evan Baumgardner on 5/20/14.
//  Copyright (c) 2014 Evan Baumgardner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "LocationResultViewController.h"


@interface ViewController : UIViewController <CLLocationManagerDelegate, UISearchDisplayDelegate, UISearchBarDelegate, MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) MKLocalSearchResponse *response;

- (IBAction)changeMapType:(UIBarButtonItem *)sender;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *detailsButton;

@end

//
//  MapRouteViewController.h
//  MapKit-Classwork
//
//  Created by Evan Baumgardner on 5/27/14.
//  Copyright (c) 2014 Evan Baumgardner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <AVFoundation/AVFoundation.h>

@interface MapRouteViewController : UIViewController <MKMapViewDelegate, AVSpeechSynthesizerDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *routeMap;
@property (strong, nonatomic) MKMapItem *destination;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *playPauseButton;
@property (strong, nonatomic) AVSpeechSynthesizer *synthesizer;

@property (strong, nonatomic) NSString *directionsToSpeak;


@end

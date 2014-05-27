//
//  MapRouteViewController.m
//  MapKit-Classwork
//
//  Created by Evan Baumgardner on 5/27/14.
//  Copyright (c) 2014 Evan Baumgardner. All rights reserved.
//

#import "MapRouteViewController.h"

@interface MapRouteViewController ()

@end

@implementation MapRouteViewController

BOOL speechPaused = NO; // used to track state of speech

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _routeMap.showsUserLocation = YES;
    MKUserLocation *userLocation = _routeMap.userLocation;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 2000, 2000);
    [_routeMap setRegion:region animated:NO];
    _routeMap.delegate = self;
    [self getDirections];
    
    self.synthesizer = [[AVSpeechSynthesizer alloc] init];
    speechPaused = NO;
    self.synthesizer.delegate = self;
}

- (void)getDirections
{
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
    
    request.source = [MKMapItem mapItemForCurrentLocation];
    request.destination = _destination;
    request.requestsAlternateRoutes = NO;
    MKDirections *directions = [[MKDirections alloc] initWithRequest:request];
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
        if (error) {
            // handle error
        } else {
            [self showRoute:response];
        }
        //        NSLog(@"Direction: %@", response.routes.lastObject);
    }];
}

-(void)showRoute:(MKDirectionsResponse *)response
{
    self.directionsToSpeak = @"";
    for (MKRoute *route in response.routes)
    {
        [_routeMap addOverlay:route.polyline level:MKOverlayLevelAboveRoads];
        
        for (MKRouteStep *step in route.steps)
        {
            NSLog(@"%@", step.instructions);
            self.directionsToSpeak = [self.directionsToSpeak stringByAppendingString:step.instructions];
            self.directionsToSpeak = [self.directionsToSpeak stringByAppendingString:@"..."];
            NSLog(@"direction: %@", self.directionsToSpeak);
        }
    }
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id < MKOverlay >)overlay
{
    MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    renderer.strokeColor = [UIColor blueColor];
    renderer.lineWidth = 5.0;
    return renderer;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)playPauseButtonPressed:(UIBarButtonItem *)sender
{
    if (speechPaused == NO) {
        [sender setTitle:@"Pause"];
        [self.synthesizer continueSpeaking];
        speechPaused = YES;
    } else {
        [sender setTitle:@"Play Directions"];
        speechPaused = NO;
        [self.synthesizer pauseSpeakingAtBoundary:AVSpeechBoundaryImmediate];
    }
    if (self.synthesizer.speaking == NO) {
        AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc] initWithString:self.directionsToSpeak];
        utterance.rate = 0.25;
        utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"en-US"];
        [self.synthesizer speakUtterance:utterance];
    }
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance
{
    [self.playPauseButton setTitle:@"Play Directions"];
    speechPaused = NO;
    NSLog(@"Playback finished.");
}

@end

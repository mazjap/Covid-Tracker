//
//  ViewController.m
//  Covid Tracker
//
//  Created by Jordan Christensen on 11/9/20.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (nonatomic) CLLocationManager *locationManager;
@property (nonatomic) BOOL locationEnabled;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self requestAccess];
}

- (void)locationManagerDidChangeAuthorization:(CLLocationManager *)manager {
    BOOL alertUser = false;
    
    if ([CLLocationManager locationServicesEnabled]) {
        switch ([manager authorizationStatus]) {
            case kCLAuthorizationStatusDenied:
                alertUser = true;
                _locationEnabled = false;
            case kCLAuthorizationStatusNotDetermined:
                [self requestAccess];
            default:
                _locationEnabled = true;
        }
    } else {
        _locationEnabled = false;
    }
    
    if (alertUser) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Access to Location Denied" message:@"To accurately provide data, Covid Tracker needs access to your location" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
        
        [self presentViewController:alert animated:true completion:nil];
    }
}

- (void)requestAccess {
    [_locationManager requestWhenInUseAuthorization];
}

@end

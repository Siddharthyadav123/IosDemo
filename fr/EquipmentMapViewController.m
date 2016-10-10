//
//  EquipmentMapViewController.m
//  FleetRight
//
//  Created by test on 29/08/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import "EquipmentMapViewController.h"

@interface EquipmentMapViewController ()

@end

@implementation EquipmentMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeInstance];
    [self initializeLocationUpdate];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//loading filter after view shown
-(void) viewDidAppear:(BOOL)animated
{
    [self initFilterView];
}

/*
 * Method to initialize views
 */
-(void)initializeInstance{
    [super initializeInstance];
    [self.actionBarHeaderView addSubview: [self loadActionBarView]];
    
    self.mapView.delegate = self;
    
    //Instantiate a location object.
    locationManager = [[CLLocationManager alloc] init];
    
    //Make this controller the delegate for the location manager.
    [locationManager setDelegate:self];
    
    //Set some parameters for the location object.
    [locationManager setDistanceFilter:kCLDistanceFilterNone];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    
    
    self.mapView.showsUserLocation = YES;
    
    point = [[MKPointAnnotation alloc] init];
    
    
}

/*
 * Method to call delegate methods of Location Manager to get current location in latitude and longitude.
 */
-(void)initializeLocationUpdate{
    if ([CLLocationManager locationServicesEnabled]) {
        
        //Check for ios 8 and its upper version
        if(IS_OS_8_OR_LATER) {
            [locationManager requestAlwaysAuthorization];
        }
        
        [locationManager  startUpdatingLocation];
        
    } else {
        
        NSLog(@"Location services is not enabled");
        
    }
}


/*
 * Method to load custom action bar on each viewcontroller
 */
-(UIView*)loadActionBarView{
    // ActionBarView *actionBarView = [[ActionBarView alloc]init];
    self.actionBarView = [[[NSBundle mainBundle] loadNibNamed:@"ActionBarView"
                                                        owner:self options:nil]objectAtIndex:0];
    [self.actionBarView setBaseViewController:self];
    return self.actionBarView;
}



- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
//        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
//        [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
//    
    
    latitude= userLocation.coordinate.latitude;
    longitude = userLocation.coordinate.latitude;
    [self addMarkerOnMap];
}

/*
 * Method to add marker on Map
 */
-(void)addMarkerOnMap{
    // Add an annotation
    [self.mapView removeAnnotation:point];
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = latitude;
    coordinate.longitude = longitude;
    point.coordinate = coordinate;
  //  NSLog(@"coordinate.latitude %f,coordinate.longitude %f ",coordinate.latitude,coordinate.longitude );
//    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(point.coordinate, 800, 800);
//    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];


    NSString* title = [_equipmentDo.cname stringByAppendingFormat:@"-%@",_equipmentDo.mdname];
    point.title = title;
    point.subtitle = _equipmentDo.mnfname;
    [self.mapView addAnnotation:point];
    
}

-(void)destroy{
    locationManager=nil;
    point=nil;
    _mapView = nil;
}


@end

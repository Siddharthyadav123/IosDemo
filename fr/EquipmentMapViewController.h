//
//  EquipmentMapViewController.h
//  FleetRight
//
//  Created by test on 29/08/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import "BaseViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "EquipmentDo.h"

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)


@interface EquipmentMapViewController : BaseViewController<MKMapViewDelegate,CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
    float latitude;
    float longitude;
    MKPointAnnotation *point;
}

@property (strong, nonatomic) EquipmentDo *equipmentDo;
@property (weak, nonatomic) IBOutlet UIView *actionBarHeaderView;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@end

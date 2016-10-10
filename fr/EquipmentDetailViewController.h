//
//  EquipmentDetailViewController.h
//  FleetRight
//
//  Created by Ranjit singh on 8/16/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import "BaseViewController.h"
#import <MapKit/MapKit.h>
#import "EquipmentIndividualModel.h"
#import "CustomAlertView.h"
#import "EquipmentDo.h"
#import "OtherEquipmentCollectionCell.h"
#import "OtherEquipmentModel.h"
#import "Utils.h"


@interface EquipmentDetailViewController : BaseViewController<CLLocationManagerDelegate, MKMapViewDelegate,CustomAlertViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    CLLocationManager *locationManager;
    CustomAlertView *customAlertView;
    float latitude;
    float longitude;
    MKPointAnnotation *point;
    BOOL isScreenLaunchFirst;
    UIImage *tempVehicleImage;
    int otherEquipmentId;
    NSString *equipmentIndividualModelInitIdentifier;
}



@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *vehicleImageActivityIndicator;
@property (strong, nonatomic) IBOutlet UIImageView *vehicleImageview;
@property (weak, nonatomic) IBOutlet UIView *actionBarHeaderView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *parentView;
@property (strong, nonatomic) IBOutlet UIView *equipmentSpecificationView;

//Vehicle Name, status etc labels
@property (strong, nonatomic) IBOutlet UILabel *vehicleNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *vehicleStatusLabel;
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic) IBOutlet UILabel *vehicleModelNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *ownerNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *vehicleYearLabel;
@property (strong, nonatomic) IBOutlet UILabel *hoursLabel;
@property (strong, nonatomic) IBOutlet UILabel *companyName;
@property (strong, nonatomic) IBOutlet UILabel *notAvailabelLabel;
@property (strong, nonatomic) IBOutlet UILabel *sellPriceConstLabel;
@property (strong, nonatomic) IBOutlet UIButton *mapButton;
@property (strong, nonatomic) IBOutlet UILabel *compactorLabel;
- (IBAction)mapButtonClicked:(id)sender;


//Days Label
@property (strong, nonatomic) IBOutlet UILabel *forRentLabel;
@property (strong, nonatomic) IBOutlet UILabel *weekLabel;
@property (strong, nonatomic) IBOutlet UILabel *monthLabel;
@property (strong, nonatomic) IBOutlet UILabel *daysLabel;

//Map Label
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UITextView *equipmentDescripterLabel;

//other Equipment Variables
@property (strong, nonatomic) IBOutlet UIView *otherEquipmentView;
@property (strong, nonatomic) IBOutlet UICollectionView *otherEquipmentCollectionView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *otherEquipmentActivityIndicator;


//Buttons variables
@property (strong, nonatomic) IBOutlet UILabel *separatorLabel;
@property (strong, nonatomic) IBOutlet UIButton *sendRequestButton;

- (IBAction)sendRequestButtonClicked:(id)sender;





@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *descriptionActivityIndicator;



@property (strong, nonatomic) EquipmentIndividualModel *equipmentIndividualMode;
@property (strong, nonatomic) OtherEquipmentModel *otherEquipmentModel;
@property (strong, nonatomic) EquipmentDo *equipmentDo;

-(void)onVehicleImageResponse;

@end

//
//  EquipmentDetailViewController.m
//  FleetRight
//
//  Created by Ranjit singh on 8/16/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import "EquipmentDetailViewController.h"


@interface EquipmentDetailViewController ()

@end

@implementation EquipmentDetailViewController

static NSString *simpleTableIdentifier = @"OtherEquipmentCollectionCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initializeInstance];
    
    
}

-(void) viewDidAppear:(BOOL)animated
{
    if (!isScreenLaunchFirst) {
        
        [Utils setBorderToView:self.mapButton];
        [Utils setBorderToView:self.sendRequestButton];
        [self setDeligateOfMapView];
        [self setDataInLabels];
        [self initializeModel];
        [self initFilterView];
        isScreenLaunchFirst = true;
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 * Method to initialize views
 */
-(void)initializeInstance{
    [super initializeInstance];
    [self.actionBarHeaderView addSubview: [self loadActionBarView]];
    [_scrollView setContentSize:CGSizeMake(_parentView.frame.size.width, _parentView.frame.size.height)];
    customAlertView = [CustomAlertView createCustomAlertView:CUSTOM_ALERT_ERROR_TITLE alertMessage:@"" leftButtonTitle:@"OK" rightButtonTitle:nil delegate:self identifier:1];
    _equipmentDescripterLabel.editable = NO;
    _equipmentDescripterLabel.scrollEnabled = NO;
    
    //Default set  EquipmentIndividualModel InitIdentifier as "IMAGE_REQUEST_FROM_EQUIPMENT_INDIVIDUAL_MODEL"
    equipmentIndividualModelInitIdentifier = IMAGE_REQUEST_FROM_EQUIPMENT_INDIVIDUAL_MODEL;
    
    [self.otherEquipmentCollectionView registerNib:[UINib nibWithNibName:@"OtherEquipmentCollectionCell" bundle:nil] forCellWithReuseIdentifier:simpleTableIdentifier];
    point = [[MKPointAnnotation alloc] init];
    
    //Initialize EquipmentIndividualModel
    _equipmentIndividualMode = [[EquipmentIndividualModel alloc]init];
    self.localModel.equipmentIndividualModel = _equipmentIndividualMode;
    [_equipmentIndividualMode registerview:self];
    
    
    //Initialize OtherEquipmentModel
    self.otherEquipmentModel = [[OtherEquipmentModel alloc]init];
    [self.otherEquipmentModel registerview:self];
}

/*
 * Void method to set data in labelsz
 */
-(void)setDataInLabels{
    @autoreleasepool {
        
        //        "id": 48;
        //
        //        "url": "http://alkurn.net/clients/fleetright/frontend/web/uploads/default.jpg"
        
        if (_equipmentDo!=nil) {
            
            if (_equipmentDo.status!=nil) {
                _vehicleStatusLabel.text=_equipmentDo.status;
            }
            else{
                _vehicleStatusLabel.text=@"N/A";
            }
            
            if (_equipmentDo.ename!=nil) {
                _vehicleNameLabel.text=_equipmentDo.ename;
            }
            else{
                _vehicleNameLabel.text=@"N/A";
            }
            
            
            if (_equipmentDo.mdname!=nil) {
                _vehicleModelNameLabel.text= _equipmentDo.mdname;
            }
            else{
                _vehicleModelNameLabel.text=@"N/A";
            }
            
            if (_equipmentDo.year!=0) {
                _vehicleYearLabel.text=[NSString stringWithFormat:@"Year-%ld",(long)_equipmentDo.year];
            }
            else{
                _vehicleYearLabel.text=0;
            }
            
            if (_equipmentDo.hour_per_miles!=0) {
                _hoursLabel.text=[NSString stringWithFormat:@"Hour-%ld",(long)_equipmentDo.hour_per_miles];
            }
            else{
                _hoursLabel.text=0;
            }
            
            if (_equipmentDo.weekly!=nil) {
                _weekLabel.text=_equipmentDo.weekly;
            }
            else{
                _weekLabel.text=@"N/A";
            }
            
            if (_equipmentDo.monthly!=nil) {
                _monthLabel.text=_equipmentDo.monthly;
            }
            else{
                _monthLabel.text=@"N/A";
            }
            
            if (_equipmentDo.daily!=nil) {
                _daysLabel.text=_equipmentDo.daily;
            }
            else{
                _daysLabel.text=@"N/A";
            }
            
            if (_equipmentDo.cname!=nil) {
                //_equipmentDo.mnfname;
                _companyName.text = _equipmentDo.cname;
            }
            else{
                _companyName.text=@"N/A";
            }
            
            if (_equipmentDo.desc!=nil) {
                
                _equipmentDescripterLabel.text = _equipmentDo.desc;
            }
            else{
                _equipmentDescripterLabel.text=@"N/A";
            }
            
            
            if (_equipmentDo.mnfname!=nil) {
                _ownerNameLabel.text = _equipmentDo.mnfname;
            }
            else{
                _ownerNameLabel.text=@"N/A";
            }
            
            // set default user image while image is being downloaded
            //self.vehicleImageview.image = [UIImage imageNamed:@"icon_logo.png"];
            
            if (_equipmentDo.vehicleImage!=nil ) {
                if ([equipmentIndividualModelInitIdentifier isEqualToString:IMAGE_REQUEST_FROM_EQUIPMENT_INDIVIDUAL_MODEL]) {
                    [self.vehicleImageview setImage:_equipmentDo.vehicleImage];
                    
                    //Load already having vehicle image in tempVehicleImage variable, to avoid again vehicle image download hit.
                    tempVehicleImage = _equipmentDo.vehicleImage ;
                }
                
            }
            
            _locationLabel.text=@"N/A";
            _compactorLabel.text=@"N/A";
            
        }
        
    }
    
}


/*
 * Method to initialize EquipmentIndividual Model
 */
-(void)initializeModel{
    
    //initialize equipmentIndividualMode for Individual Equipment Model Data
    [self initializeEquipmentIndividualModel];
    
    //initialize OtherEquipmentModel
    [self initializeOtherEquipmentModel];
    
}

/*
 * Method to initialize equipment individual model
 */
-(void)initializeEquipmentIndividualModel{
    [self.descriptionActivityIndicator startAnimating];
    [self.vehicleImageActivityIndicator startAnimating];
    
    
    //Initialize this model for other equipment data
    if ([equipmentIndividualModelInitIdentifier isEqualToString:IMAGE_REQUEST_FROM_OTHER_EQUIPMENT_MODEL]) {
        _equipmentIndividualMode.selectedVehicleID = otherEquipmentId;
        
    }
    
    //Initialize this model for equipment individual model data
    else{
        _equipmentIndividualMode.selectedVehicleID = (int)_equipmentDo.id;
    }
    
    [_equipmentIndividualMode initialize];
}

/*
 * initialize Other Equipment Model
 */
-(void)initializeOtherEquipmentModel{
    [self.otherEquipmentActivityIndicator startAnimating];
    _otherEquipmentModel.equipment_id = (int)_equipmentDo.id;
    _otherEquipmentModel.mnf_id = (int)_equipmentDo.mnf_id;
    [_otherEquipmentModel initialize];
}


-(void)update{
    [self.descriptionActivityIndicator stopAnimating];
    [self.vehicleImageActivityIndicator stopAnimating];
    
    if (self.equipmentIndividualMode.errorCode == SUCCESS_CODE) {
        if ( self.equipmentIndividualMode!=nil) {
            self.equipmentDo = self.equipmentIndividualMode.equipmentDo;
            if (tempVehicleImage!=nil) {
                [self.equipmentDo setVehicleImage:tempVehicleImage];
            }
            
            //If response id for Other Equipment Data then scroll ScrollView at top.
            if ([equipmentIndividualModelInitIdentifier isEqualToString:IMAGE_REQUEST_FROM_OTHER_EQUIPMENT_MODEL]) {
                [self.scrollView setContentOffset:CGPointZero animated:YES];
            }
            
            
            [self.view setNeedsLayout];
            [self setDataInLabels];
            
            //Need equipment_id and mnf_id. So initialize Other EquipmentModel once get response from equipmentIndividualMode for Other equipment
            if ([equipmentIndividualModelInitIdentifier isEqualToString:IMAGE_REQUEST_FROM_OTHER_EQUIPMENT_MODEL]){
                [self initializeOtherEquipmentModel];
        }
        
    }
}
else{
    
    if (![Utils isInternertConnectionAvailabel]) {
        [customAlertView setMessage:@"No Internet connection available"];
    }
    else{
        [customAlertView setMessage:@"Error In Response"];
    }
    [customAlertView show:self];
    
}
}


/******************* Other equipment Collection View Code *********************/

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if([_otherEquipmentModel.otherRelatedEquipmrntArray count]!=0)
    {
        return [_otherEquipmentModel.otherRelatedEquipmrntArray count];
    }
    return 0;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    OtherEquipmentCollectionCell *cell = (OtherEquipmentCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:simpleTableIdentifier forIndexPath:indexPath];
    if (cell == nil)
    {
        [collectionView registerNib:[UINib nibWithNibName:@"OtherEquipmentCollectionCell" bundle:nil] forCellWithReuseIdentifier:simpleTableIdentifier];
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:simpleTableIdentifier forIndexPath:indexPath];
        
        
    }
    
    int ind = indexPath.row;
    [self setDataToOtherEquipmentCell:cell index:ind];
    
    
    return cell;
    
}



/*
 * Here sets the data to each item cell.
 */
-(void) setDataToOtherEquipmentCell:(OtherEquipmentCollectionCell*) otherEquipmentCollectionCell index:(int) index{
    @autoreleasepool {
        if ([_otherEquipmentModel.otherRelatedEquipmrntArray count]!=0) {
            EquipmentDo *equipmentDo = [_otherEquipmentModel.otherRelatedEquipmrntArray objectAtIndex:index];
            
            if (equipmentDo!=nil) {
                otherEquipmentCollectionCell.otherEquipVehicleImgaeView.image = [UIImage imageNamed:@"icon_logo.png"];
                
                if (equipmentDo.vehicleImage!=nil ) {
                    [otherEquipmentCollectionCell.otherEquipVehicleImgaeView setImage:equipmentDo.vehicleImage];
                }
                
                otherEquipmentCollectionCell.otherEquipVehicleName.text = equipmentDo.ename;
                
                otherEquipmentCollectionCell.otherEquipVehicleStatus.text = equipmentDo.status;
                
            }
            
            
        }
        
    }
}


-(void)onVehicleImageResponse{
    
    [self.otherEquipmentActivityIndicator stopAnimating];
    if (self.otherEquipmentModel.errorCode == SUCCESS_CODE) {
        [self.otherEquipmentCollectionView reloadData];
    }
    else{
        if (![Utils isInternertConnectionAvailabel]) {
            [customAlertView setMessage:@"No Internet connection available"];
        }
        else{
            [customAlertView setMessage:@"Error In Response"];
        }
        [customAlertView show:self];
        
    }
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    EquipmentDo *equipmentDao = [self.otherEquipmentModel.otherRelatedEquipmrntArray objectAtIndex:indexPath.row];
    otherEquipmentId = (int)equipmentDao.id;
    equipmentIndividualModelInitIdentifier = IMAGE_REQUEST_FROM_OTHER_EQUIPMENT_MODEL;
    
    //Load already having vehicle image in tempVehicleImage variable, to avoid again vehicle image download hit.
    if (equipmentDao.vehicleImage!=nil) {
        [self.vehicleImageview setImage:equipmentDao.vehicleImage];
        tempVehicleImage = equipmentDao.vehicleImage ;
    }
    
    //initialize equipmentIndividualMode for Other Equipment Model Data
    [self initializeEquipmentIndividualModel];
    //[self initializeModel];
}

/******************* MAP Code *********************/
/*
 * Method to set delegate of MKMapView
 */
-(void)setDeligateOfMapView{
    
    //Make this controller the delegate for the map view.
    self.mapView.delegate = self;
    
    // Ensure that you can view your own location in the map view.
    [self.mapView setShowsUserLocation:YES];
    
    self.mapView.zoomEnabled = YES;
    
    //Instantiate a location object.
    locationManager = [[CLLocationManager alloc] init];
    
    
    //Make this controller the delegate for the location manager.
    [locationManager setDelegate:self];
    
    //Set some parameters for the location object.
    [locationManager setDistanceFilter:kCLDistanceFilterNone];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    latitude= userLocation.coordinate.latitude;
    longitude = userLocation.coordinate.latitude;
    // [self addMarkerOnMap];
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
    //        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(point.coordinate, 800, 800);
    //    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    
    NSString* title = [_equipmentDo.cname stringByAppendingFormat:@"-%@",_equipmentDo.mdname];
    point.title = title;
    point.subtitle = _equipmentDo.mnfname;
    [self.mapView addAnnotation:point];
    
}


- (IBAction)sendRequestButtonClicked:(id)sender {
    [[ApplicationController getInstance]handleEvent:EVENT_ID_EQUIPMENT_RENT_REQUEST_RENTER_VIEW_SCREEN andeventObject:_equipmentDo];
}

- (IBAction)mapButtonClicked:(id)sender {
    [[ApplicationController getInstance]handleEvent:EVENT_ID_EQUIPMENT_MAP_VIEW_SCREEN andeventObject:_equipmentDo];
}

-(void)onAlertViewLeftButtonClicked:(int)identifier{
    
}

-(void)onAlertViewRightButtonClicked:(int)identifier{
    
}


/*
 * Method to destroy variables
 */
-(void)destroy{
    locationManager = nil;
    customAlertView = nil;
    point = nil;
    _vehicleImageview= nil;
    _actionBarHeaderView= nil;
    _scrollView= nil;
    _parentView= nil;
    _equipmentSpecificationView= nil;
    _vehicleNameLabel= nil;
    _vehicleStatusLabel= nil;
    _locationLabel= nil;
    _priceLabel= nil;
    _vehicleModelNameLabel= nil;
    _ownerNameLabel= nil;
    _vehicleYearLabel= nil;
    _hoursLabel= nil;
    _companyName= nil;
    _notAvailabelLabel= nil;
    _sellPriceConstLabel= nil;
    _mapButton= nil;
    _forRentLabel= nil;
    _weekLabel= nil;
    _monthLabel= nil;
    _daysLabel= nil;
    _mapView= nil;
    _equipmentDescripterLabel= nil;
    _otherEquipmentView= nil;
    _otherEquipmentCollectionView= nil;
    _otherEquipmentActivityIndicator= nil;
    _separatorLabel= nil;
    _sendRequestButton= nil;
    _descriptionActivityIndicator= nil;
    tempVehicleImage = nil;
    
    
}

@end

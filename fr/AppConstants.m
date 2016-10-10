//
//  AppConstants.m
//  IosApplicationFrameworkProject
//
//  Created by Ranjit singh on 2/9/15.
//  Copyright (c) 2015 syslogic. All rights reserved.
//

#import "AppConstants.h"

@implementation AppConstants


/*
 * Server URL i.e. Host URL.
 */

NSString* const SERVER_URL =  @"http://tim.manthanstudio.in:8080/dynamic_carriers/api/client/";


#define BASE_URL @"http://alkurn.net/clients/fleetright/api/web/v1/"
NSString *const URL_GET_EQUIPMENT_LIST = BASE_URL @"equipments";
NSString *const URL_POST_REGISTRATION = BASE_URL @"users";
NSString *const URL_POST_LOGIN = BASE_URL @"logins";
NSString *const URL_GET_FILTER_CATEGORIES = BASE_URL @"categories/equipment-categories";
NSString *const URL_GET_ALL_SEARCH_DATA = BASE_URL @"equipments/search";
NSString *const URL_GET_ALL_SEARCH_TEXT_RELATED_DATA = BASE_URL @"equipments/searchlist?keyword=";
NSString *const URL_GET_INDIVIDUAL_EQUIPMENT_DETAILS = BASE_URL @"equipments/";
NSString *const URL_GET_OTHER_RELATED_EQUIPMENT_DETAILS = BASE_URL @"equipments/related-equipment-list?";
NSString *const URL_POST_RENTAL_REQUEST = BASE_URL @"requests/equipment-renting-request";
NSString *const URL_GET_RENTAL_REQUEST_LIST = BASE_URL @"requests/rent-requests?renter_id=51";
NSString *const URL_GET_SUPPLIER_REQUEST_LIST = BASE_URL @"requests/supplier-requests?supplier_id=46";
NSString *const URL_GET_RENTER_INVENTORY = BASE_URL @"users/renter-inventory?renter_id=51";
NSString *const URL_GET_SUPPLIER_INVENTORY = BASE_URL @"users/supplier-inventory?supplier_id=46";
NSString *const URL_GET_RENTER_CONTRACT_RENT_EQUIPMENT = BASE_URL @"contracts/renter-contracts-for-rent?renter_id=51";
NSString *const URL_GET_RENTER_CONTRACT_SOLD_EQUIPMENT = BASE_URL @"contracts/renter-contracts-for-sold?renter_id=51";
NSString *const URL_GET_SUPPLIER_CONTRACT_RENT_EQUIPMENT = BASE_URL @"contracts/supplier-contracts-for-rent?supplier_id=46";
NSString *const URL_GET_SUPPLIER_CONTRACT_SOLD_EQUIPMENT = BASE_URL @"contracts/supplier-contracts-for-sold?supplier_id=46";
NSString *const URL_GET_RENTER_INDIVIDUAL_CONTRACT_RENT_EQUIPMENT = BASE_URL @"contracts/renter-contracts-for-rent?renter_id=51&";
NSString *const URL_GET_RENTER_INDIVIDUAL_CONTRACT_SOLD_EQUIPMENT = BASE_URL @"contracts/renter-contracts-for-sold?renter_id=51&";
NSString *const URL_GET_SUPPLIER_INDIVIDUAL_CONTRACT_RENT_EQUIPMENT = BASE_URL @"contracts/supplier-contracts-for-rent?supplier_id=46&";
NSString *const URL_GET_SUPPLIER_INDIVIDUAL_CONTRACT_SOLD_EQUIPMENT = BASE_URL @"contracts/supplier-contracts-for-sold?supplier_id=46&";
NSString *const URL_POST_SUPPLIER_REQUEST_APPROVAL = BASE_URL @"requests/request-approval";




NSString* const CUSTOM_ALERT_ERROR_TITLE = @"Alert";
NSString* const CUSTOM_ALERT_PROGRESS_TITLE = @"Loading";
NSString* const MANDATORY_FIELD_ERROR_MESSAGE = @"All fields are mantatory";
NSString* const INCORRECT_EMAIL_ERROR_MESSAGE = @"You have entered incorrect email. Please try again!";
NSString* const INCORRECT_PHONE_NUMBER_ERROR_MESSAGE =  @"Enter 10 digits contact number!";
NSString* const CONFIRM_PASSWORD_ERROR_MESSAGE = @"Confirm Password should be same as Password. Please try again!";
NSString* const PASSWORD_LENGTH_ERROR_MESSAGE = @" Password length should be greater then 5. Please try again!";
NSString* const USERNAME_LENGTH_ERROR_MESSAGE = @" Username length should be greater then 5. Please try again!";
NSString* const CUSTOM_ALERT_PROGRESS_SEARCH = @"Loading Search Data";
NSString* const IMAGE_REQUEST_FROM_EQUIPMENT_INDIVIDUAL_MODEL = @"Image Request from equipment individual model";
NSString* const IMAGE_REQUEST_FROM_OTHER_EQUIPMENT_MODEL = @"Image Request from other equipment model";
NSString* const IMAGE_REQUEST_FROM_INVENTORY_MODEL=@"Image Request from inventory model";
NSString* const IMAGE_REQUEST_FROM_INDIVIDUAL_CONTRACT = @"Image Request from individual contract model";
NSString* const LOGIN_TYPE_SUPPLIER = @"Supplier";
NSString* const IMAGE_REQUEST_FROM_RENT=@"Image Request from RENT";
NSString* const IMAGE_REQUEST_FROM_SOLD=@"Image Request from SOLD";
NSString* const IMAGE_REQUEST_FROM_IDLE=@"Image Request from IDLE";
NSString * const RENTER_CONTRACT_RENT_REQUEST = @"Renter Contract list request for rent";
NSString * const RENTER_CONTRACT_PURCHASE_REQUEST = @"Renter Contract list request for sold";
NSString * const IMAGE_DOWNLOAD_REQUEST_FOR_RENTER=@"Image Download Request For Renter";
NSString * const IMAGE_DOWNLOAD_REQUEST_FOR_SUPPLIER=@"Image Download Request For Supplier";



int const SUCCESS_CODE = -1;
int const SPLASH_SCREEN_DISPLAY_LENGTH = 3;



NSInteger const DEFAULT_ORDER_STATUS = 0;

@end

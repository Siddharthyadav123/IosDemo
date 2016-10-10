//
//  SearchViewController.h
//  Ecommerce
//
//  Created by Ranjit singh on 4/21/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import "BaseViewController.h"
#import "SearchAllDataModel.h"
#import "CustomAlertView.h"
#import "SearchDao.h"
#import "Utils.h"

@interface SearchViewController : BaseViewController <UITableViewDelegate,UITableViewDataSource,UISearchDisplayDelegate>
{
    CustomAlertView *customAlertView;
    CustomAlertView *progressAlertView;
    NSString* searchCharacter;
}
@property (nonatomic, strong) NSMutableArray *searchResults;
@property (nonatomic, strong) NSMutableArray *allDataArray;
@property (nonatomic, strong) SearchAllDataModel *searchAllDataModel;
@property (weak, nonatomic) IBOutlet UITableView *searchResultTableView;

@property int tableViewTag;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
- (IBAction)onSearchCancelClick:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *searchEquipmentTableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *progressBar;
@property (nonatomic,retain) EquipmentSearchListModel *equipmentSearchListModel;
@property (weak, nonatomic) IBOutlet UIView *shadowView;

@end

//
//  SearchViewController.m
//  Ecommerce
//
//  Created by Ranjit singh on 4/21/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import "SearchViewController.h"
#import "EquipmentTableViewCell.h"
#import "EquipmentDo.h"
#import "EquipmentDetailViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeInstance];
    
    //setting table as hidden
    self.searchEquipmentTableView.hidden=YES;
    self.progressBar.hidden=YES;
    self.searchBar.delegate=self;
    
}

-(void)viewDidAppear:(BOOL)animated{
    [self setupSearchTable];
    [self.searchBar becomeFirstResponder];
}

/*
 * Method to initialize instance
 */
-(void)initializeInstance{
    [super initializeInstance];
    
    //search result array for sorting
    self.searchResults = [[NSMutableArray alloc]init];
    
    //this array will contain all the elements
    self.allDataArray = [[NSMutableArray alloc]init];
    
    //aleart shown while loading search hint
    customAlertView = [CustomAlertView createCustomAlertView:CUSTOM_ALERT_ERROR_TITLE alertMessage:@"" leftButtonTitle:@"OK" rightButtonTitle:nil delegate:self identifier:1];
    
    //progress bar for search hint
    progressAlertView = [CustomAlertView createCustomProgressDialog:CUSTOM_ALERT_PROGRESS_SEARCH delegate:self identifier:2];
    
    //initializing equipment list service moodel
    self.equipmentSearchListModel=[[EquipmentSearchListModel alloc]init];
    [self.equipmentSearchListModel registerview:self];
    
}

/*
 * Method to request search result
 */
-(void) requestSearchEquimentList:(NSString*) searchText{
    //show table view
    if(self.searchEquipmentTableView!=nil)
    {
        self.searchEquipmentTableView.hidden=true;
    }
    //show loading
    [self showInnerLoading];
    
    //setting text to search result for
    self.equipmentSearchListModel.searchText=searchText;
    
    //go for search equipment list
    [self.equipmentSearchListModel initialize ];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    //    [searchBar resignFirstResponder];
    NSLog(@"called %@",searchBar.text);
    
    self.searchResultTableView.hidden=YES;
    [self.searchBar endEditing:TRUE];
    self.shadowView.hidden=YES;
    [self requestSearchEquimentList:searchBar.text];
    
    // Do the search...
}

/*
 * Setting up search Table for the first time
 */
-(void)setupSearchTable{
    if ([self.localModel.searchDataArray count]==0) {
        [progressAlertView show:self];
        
        self.searchAllDataModel = [[SearchAllDataModel alloc]init];
        [_searchAllDataModel registerview:self];
        [_searchAllDataModel initialize];
        
    }
    else{
        [_allDataArray removeAllObjects];
        if ([self.localModel.searchDataArray count]!=0) {
            _allDataArray = self.localModel.searchDataArray;
            
            self.searchResults =[[NSMutableArray alloc]init];
            
            if (_allDataArray !=nil) {
                for (int i=0; i< [_allDataArray count]; i++) {
                    [self.searchResults  addObject:[_allDataArray objectAtIndex:i]];
                }
            }
            
            
        }
        [self.searchResultTableView reloadData];
    }
}



-(void)update{
    [progressAlertView dismissCustomProgressDialog:^{[self initialiseTableData];}];
    
    //loading result of search
    if(self.equipmentSearchListModel!=nil && self.equipmentSearchListModel.searchEquipmentListArray!=nil
       && [self.equipmentSearchListModel.searchEquipmentListArray count]>0)
    {
        self.searchEquipmentTableView.hidden=NO;
        [self.searchEquipmentTableView reloadData];
        [self hideInnerLoading];
    }else if(self.equipmentSearchListModel!=nil && self.equipmentSearchListModel.errorMessage!=nil)
    {
        [customAlertView setMessage:self.equipmentSearchListModel.errorMessage];
        [customAlertView show:self];
        [self hideInnerLoading];
        self.searchBar.text=@"";
    }
    
}



/*
 * Method to initialize array with the data fetch from server.
 */
-(void)initialiseTableData
{
    if ([_allDataArray count]!=0) {
        [_allDataArray removeAllObjects];
    }
    
    self.searchResults =[[NSMutableArray alloc]init];
    
    if ([self.searchAllDataModel.allSearchDataArray count]!=0) {
        int count = (int)[self.searchAllDataModel.allSearchDataArray count];
        for (int i=0; i< count; i++) {
            SearchDao *searchDao  = [self.searchAllDataModel.allSearchDataArray objectAtIndex:i];
            [_allDataArray addObject:searchDao.searchName];
            [self.searchResults  addObject:searchDao.searchName];
        }
        
        self.localModel.searchDataArray = _allDataArray;
    }
    
    [self.searchResultTableView reloadData];
    
}


//filtering logic
- (void)filterListForSearchText:(NSString*)searchText
{
    
    [self.searchResults removeAllObjects];
    
    if(searchText==nil || searchText.length==0 || [searchText isEqualToString:@""])
    {
        //adding all search text
        if (_allDataArray !=nil) {
            for (int i=0; i< [_allDataArray count]; i++) {
                [self.searchResults  addObject:[_allDataArray objectAtIndex:i]];
            }
        }
        
    }else if ([_allDataArray count]!=0) {
        
        for (int i = 0; i<[_allDataArray count]; i++) {
            
            //Object at ith index
            NSString* tempStr = [_allDataArray objectAtIndex:i];
            
            if (tempStr!=nil) {
                
                //Array after splitting an object with space
                NSArray *itemsSplittedArray = [tempStr componentsSeparatedByString:@" "];   //take the one array for split the string
                
                //if searchText is completely compared with tempStr, then add it to search array.
                if ([[tempStr lowercaseString] hasPrefix:[searchText lowercaseString]]) {
                    [self.searchResults addObject:tempStr];
                }
                
                else{
                    
                    //for loop as per the length of splitted array.
                    for (int i = 0; i<[itemsSplittedArray count]; i++) {
                        
                        //Take individual object of ith index
                        NSString *item=[itemsSplittedArray objectAtIndex:i];
                        
                        //Comare with has prefix method and if found , add to searchArray.
                        if ([[item lowercaseString] hasPrefix:[searchText lowercaseString]])  {
                            [self.searchResults addObject:tempStr];
                            break;
                        }
                        
                    }
                }
                
                
                
            }
        }
        
    }
    
    [self.searchResultTableView reloadData];
}


/**
 * Search text callback
 **/
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    NSLog(@"Typed character is: %@",searchText);
    if (searchText!=nil) {
        searchCharacter = searchText;
    }
    
    //make table view visible first
    if([self.searchResultTableView isHidden])
    {
        self.searchResultTableView.hidden=NO;
        self.shadowView.hidden=NO;
    }
    
    //then provide the result
    [self filterListForSearchText:searchText];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (tableView == self.searchResultTableView)
    {
        return [self.searchResults count];
    }
    else if(self.equipmentSearchListModel!=nil && self.equipmentSearchListModel.searchEquipmentListArray!=nil)
    {
        return [self.equipmentSearchListModel.searchEquipmentListArray count];
    }
    else
    {
        return 0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //if table is SEARCH HINT ONE
    if (tableView == self.searchResultTableView)
    {
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        
        cell.textLabel.text = [self.searchResults objectAtIndex:indexPath.row];
        
        return cell;
        
    }else if (tableView == self.searchEquipmentTableView){
        static NSString *simpleTableIdentifier = @"EquipmentTableViewCell";
        
        EquipmentTableViewCell *cell = (EquipmentTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"EquipmentTableViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        [self setDataInEquipmentCell:cell andIndex:indexPath];
        
        
        return cell;
    }
    return nil;
}

/*
 * Void method to set data in labels of cell
 */
-(void)setDataInEquipmentCell:(EquipmentTableViewCell*)cell andIndex:(NSIndexPath *)indexPath{
    @autoreleasepool {
        
        EquipmentDo *equipmentDo=[self.equipmentSearchListModel.searchEquipmentListArray objectAtIndex:indexPath.row];
        
        cell.ename.text=equipmentDo.ename;
        cell.year.text= [NSString stringWithFormat:@"Year- %li",(long)(equipmentDo.year)];
        cell.modelNum.text=equipmentDo.mdname;
        cell.hoursPerMile.text=[NSString stringWithFormat:@"Hours- %li",(long)(equipmentDo.hour_per_miles)];
        //cell.status.text=equipmentDo.status;
        cell.daily.text=equipmentDo.daily;
        cell.weekly.text=equipmentDo.weekly;
        cell.monthly.text=equipmentDo.monthly;
        
        // set default user image while image is being downloaded
        cell.equipmentUIImageView.image = [UIImage imageNamed:@"icon_logo.png"];
        
        if (equipmentDo.vehicleImage!=nil ) {
            [cell.equipmentUIImageView setImage:equipmentDo.vehicleImage];
        }
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
}


/*
 *Method for getting Table row index.
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return the number of rows in the section.
    if (tableView == self.searchResultTableView)
    {
        
        NSString *searchTextClicked = [[self.searchResults objectAtIndex:indexPath.row]stringByTrimmingCharactersInSet:
                                       [NSCharacterSet whitespaceCharacterSet]];
        
        
        self.searchBar.text=searchTextClicked;
        self.searchResultTableView.hidden=YES;
        [self.searchBar endEditing:TRUE];
        self.shadowView.hidden=YES;
        [self requestSearchEquimentList:searchTextClicked];
    }
    else
    {
        
        EquipmentDo *equipmentDo=[self.equipmentSearchListModel.searchEquipmentListArray objectAtIndex:indexPath.row];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            // your navigation controller action goes here
            [[ApplicationController getInstance]handleEvent:EVENT_ID_EQUIPMENT_DETAILS_SCREEN andeventObject:equipmentDo];
            
        });
    }
}


-(void)onAlertViewLeftButtonClicked:(int)identifier{
    
}

-(void)onAlertViewRightButtonClicked:(int)identifier{
    
}


-(void)destroy{
    customAlertView = nil;
    progressAlertView = nil;
}

- (IBAction)onSearchCancelClick:(id)sender {
    [[ApplicationController getInstance]handleEvent:EVENT_ID_FINISH_SCREEN];
}
@end

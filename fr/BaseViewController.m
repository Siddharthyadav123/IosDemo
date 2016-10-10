//
//  BaseViewController.m
//  IosApplicationFrameworkProject
//
//  Created by test on 11/08/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import "BaseViewController.h"
#import "LoginScreenViewController.h"
#import "RootUIViewController.h"
#import "EquipmentDetailViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void) viewDidAppear:(BOOL)animated
{
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initializeInstance{
    self.localModel = [[[ApplicationController getInstance]getModelFacade]getLocalModel];
    _popUpArray = [[NSArray alloc]initWithObjects:@"My Dashboard", @"My Profile", @"Logout", nil];
    
    //filter equipement category model
    self.filterEquipmentCategoryModel=[[FilterEquipmentCategoryModel alloc]init];
    [self.filterEquipmentCategoryModel registerview:self];
    
    
}

-(void) destroy{
    
}

-(void) update{
    
}


-(void) onScreenPopedUp{
    
}


-(void)onTopScreenFinished{
    
}


-(void)update:(int)identifier{
    
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

/*
 * Method to load custom action bar on each viewcontroller
 */
-(void)initFilterView{
    
    //shawdow image
    self.shadowView = [[UIView alloc] initWithFrame: CGRectMake ( 0, 80, self.view.frame.size.width, self.view.frame.size.height-80)];
    self.shadowView.backgroundColor = [UIColor blackColor];
    self.shadowView.alpha = 0;
    
    
    //setting tab gesture
    UITapGestureRecognizer  *tabOnShadowView   = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onShowdowTab:)];
    [self.shadowView addGestureRecognizer:tabOnShadowView];
    [self.view addSubview:self.shadowView];
    
    
    //filter view
    self.filterView = [[[NSBundle mainBundle] loadNibNamed:@"FilterMenuView" owner:self options:nil]objectAtIndex:0];
    [self.filterView setBaseViewController:self];
    [self.filterView setFrame:CGRectMake(0,80,self.view.frame.size.width,0)];
    self.filterView.filterEquipmentCateoryList=[[[ApplicationController getInstance] getModelFacade]getLocalModel].filterEquipmentCateoryList;
    [self.view addSubview:self.filterView];
    
    
    
    //Table view of more menu popup
    popUpTableView = [[[NSBundle mainBundle] loadNibNamed:@"PopUpView" owner:self options:nil]objectAtIndex:0];
    [popUpTableView setBaseViewController:self];
    [popUpTableView setFrame:CGRectMake(self.view.frame.size.width-popUpTableView.frame.size.width,80,popUpTableView.frame.size.width,0)];
    [self.view addSubview:popUpTableView];
    
     [self hideShowFilterOption];

}


bool filterOpen=false;
-(void) showOrHideFilterView{
    if(filterOpen == true)
    {
        [self animateClose:true];
        
    }else{
        //Close moreMenuPopup if it is open
        [self closeMoreMenuPopUp];
        [self animateOpen:true];
    }
}

-(void) animateOpen:(BOOL)isFullOpen{
    
    int openHeight=[self.filterView getTableHeight];
    if(openHeight> self.view.frame.size.height-80)
    {
        openHeight=self.view.frame.size.height-80;
    }
    
    //animate open filter view
    CGRect tempFrame=self.filterView.frame;
    tempFrame.size.width=self.view.frame.size.width;//change acco. how much you want to expand
    tempFrame.size.height=openHeight;
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationDuration:0.4];
    self.filterView.frame=tempFrame;
    [UIView commitAnimations];
    
    
    if(isFullOpen)
    {
        filterOpen=true;
        
        [self.actionBarView.showFilterButton setTitle:@"Categories" forState:UIControlStateNormal];
        
        //animate shadow appear
        [UIView animateWithDuration:0.4 animations:^(void) {
            self.shadowView.alpha = 0;
            self.shadowView.alpha = 0.7;
        }];
        
        //animate arrow
        [UIView animateWithDuration:0.4 animations:^(void) {
            self.actionBarView.filterArrowImage.transform = CGAffineTransformMakeRotation(M_PI);
        }];
    }
    
}

-(void) animateClose:(BOOL)isFullClose{
    
    int closeHeight=0;
    
    //setting height for making small
    if(!isFullClose)
    {
        closeHeight=[self.filterView getTableHeight];
    }
    
    //animate close filter view
    CGRect tempFrame=self.filterView.frame;
    tempFrame.size.width=self.view.frame.size.width;//change acco. how much you want to expand
    tempFrame.size.height=closeHeight;
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationDuration:0.4];
    self.filterView.frame=tempFrame;
    [UIView commitAnimations];
    
    
    //making it full close
    if(isFullClose)
    {
        filterOpen=false;
        [self.actionBarView.showFilterButton setTitle:@"Show Filter" forState:UIControlStateNormal];
        //animate shadow disappear
        [UIView animateWithDuration:0.4 animations:^(void) {
            self.shadowView.alpha = 0.7;
            self.shadowView.alpha = 0;
        }];
        
        //animate arrow
        [UIView animateWithDuration:0.4 animations:^(void) {
            self.actionBarView.filterArrowImage.transform = CGAffineTransformMakeRotation(0);
        }];
    }
    
    
}

- (void)onShowdowTab:(UITapGestureRecognizer *)gestureRecognizer{
    [self animateClose:true];
    [self closeMoreMenuPopUp];
}


/******************** More Menu POP Up Functionality ********************/

-(void)showMoreMenuPopUp{
    if (iSPopUpViewOpen) {
        [self closeMoreMenuPopUp];
    }
    else{
        [self openMoreMenuPopUp];
    }
}

/*
 * Method to open MoreMenuPopUp on click of more button
 */
-(void)openMoreMenuPopUp{
    
    [self animateClose:true];
    
    //animate open popup view
    CGRect tempFrame=popUpTableView.frame;
    tempFrame.size.width=popUpTableView.frame.size.width;
    tempFrame.size.height=140;
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationDuration:0.4];
    popUpTableView.frame=tempFrame;
    [UIView commitAnimations];
    
    
    //animate shadow appear
    [UIView animateWithDuration:0.4 animations:^(void) {
        self.shadowView.alpha = 0;
        self.shadowView.alpha = 0.7;
    }];
    
    iSPopUpViewOpen = true;
}

/*
 * Method to close MoreMenuPopUp on click of more button or on outer touch close it.
 */

-(void)closeMoreMenuPopUp{
    
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationDuration:0.4];
    [popUpTableView setFrame:CGRectMake(self.view.frame.size.width-popUpTableView.frame.size.width,80,popUpTableView.frame.size.width,0)];
    [UIView commitAnimations];
    
    [UIView animateWithDuration:0.4 animations:^(void) {
        self.shadowView.alpha = 0.7;
        self.shadowView.alpha = 0;
    }];
    
    iSPopUpViewOpen = false;
}



-(void) requestFilterEquimentCateogries{
    [self.filterEquipmentCategoryModel initialize ];
}

-(void) showInnerLoading{
    if(self.progressBar!=nil)
    {
        self.progressBar.hidden=false;
        [self.progressBar startAnimating];
    }
    
}

-(void) hideInnerLoading{
    if(self.progressBar!=nil)
    {
        self.progressBar.hidden=true;
        [self.progressBar stopAnimating];
    }
    
}

/******************** HomeScreen Button Functionality ********************/
-(void)dismissCurrentScreen{
   
    UIViewController *presentingVC = self.presentingViewController;
    NSLog(@"Presenting VC %@",presentingVC);
    
    if (![presentingVC isKindOfClass:[RootUIViewController class]]) {
          [[ApplicationController getInstance]handleEvent:EVENT_ID_FINISH_SCREEN];
    }
    
    
    
}


/******************** Hide showFilter option on Renter Request screen ********************/
-(void)hideShowFilterOption{
    
    UIViewController *presentingVC = self.presentingViewController;
    NSLog(@"Presenting VC %@",presentingVC);
    
    if ([presentingVC isKindOfClass:[EquipmentDetailViewController class]]) {
        [self.actionBarView.showFilterButton setHidden:YES];
         [self.actionBarView.filterArrowImage setHidden:YES];
    }
    
    
}


@end

//
//  FilterMenuView.m
//  FleetRight
//
//  Created by Ranjit singh on 8/22/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import "FilterMenuView.h"
#import "BaseViewController.h"
#import "FilterEquipmentCategoryDo.h"
#import "FilterEquipmentSubCateogoryDo.h"


@implementation FilterMenuView



int tappedSecIndex=-1;
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:
                UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    FilterEquipmentCategoryDo *filterEquipmentCategoryDo= self.filterEquipmentCateoryList[indexPath.section];
    FilterEquipmentSubCateogoryDo *filterEquipmentSubCateogoryDo=  filterEquipmentCategoryDo.subcategory[indexPath.row];
    
    [cell.textLabel setText:filterEquipmentSubCateogoryDo.name];
    cell.textLabel.textColor = [UIColor grayColor];
    
   
    return cell;
    
}

//number of secions
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    if(self.filterEquipmentCateoryList!=nil)
    {
        return [self.filterEquipmentCateoryList count];
    }
    return 0;

}

//number of row in secion
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    FilterEquipmentCategoryDo *filterEquipmentCategoryDo= self.filterEquipmentCateoryList[section];
   
    if(filterEquipmentCategoryDo.subcategory!=nil)
    {
        return [filterEquipmentCategoryDo.subcategory count];
    }
    return 0;
}


//height for row
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tappedSecIndex!=-1 && tappedSecIndex==indexPath.section) {
        return 40;
    }
    return 0;
    
}

//height for section
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

#pragma mark - Creating View for TableView Section

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 280,38)];
    sectionView.tag=section;
//    NSLog(@">>Section %i",sectionView.tag);
    sectionView.backgroundColor = [UIColor whiteColor];
   
    UILabel *viewLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, self.tableView.frame.size.width-10, 36)];
    viewLabel.backgroundColor=[UIColor clearColor];
    viewLabel.textColor = [UIColor colorWithRed:(0/255.f) green:(122/255.f) blue:(255/255.f) alpha:1.0];
    viewLabel.font=[UIFont systemFontOfSize:15 weight:2];
    
    
    FilterEquipmentCategoryDo *filterEquipmentCategoryDo= [self.filterEquipmentCateoryList objectAtIndex:section];
    viewLabel.text=[NSString stringWithFormat:@"%@",filterEquipmentCategoryDo.name];
    [sectionView addSubview:viewLabel];
    
    
    /********** Add a image in Section view *******************/
    if(filterEquipmentCategoryDo.subcategory!=NULL && [filterEquipmentCategoryDo.subcategory count]>0)
    {
     
        UIImage *myImage = [UIImage imageNamed:@"arrow_right.png"];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:myImage];
        
        imageView.frame = CGRectMake(self.tableView.frame.size.width-15, 14, 7, 12);
        imageView.tag=-1;
        [sectionView addSubview:imageView];
        
         NSLog(@">>##tappedSecIndex section %i",section);
            //setting appropriate arrow and animating the same
            if(tappedSecIndex==section)
            {
                NSLog(@">>##tappedSecIndex11 %i",tappedSecIndex);
                //animate arrow
                [UIView animateWithDuration:0.4 animations:^(void) {
                   imageView.transform = CGAffineTransformMakeRotation(M_PI/2);
                }];
            }else{
                  NSLog(@">>##tappedSecIndex22 %i",tappedSecIndex);
                
                //animate arrow
                [UIView animateWithDuration:0.4 animations:^(void) {
                   imageView.transform = CGAffineTransformMakeRotation(0);
                }];
                
            }
    }
    
    
    /********** Add a custom Separator with Section view *******************/
    UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 37, self.tableView.frame.size.width, 1.3f)];
    separatorLineView.backgroundColor = [UIColor grayColor];
    separatorLineView.alpha=0.5f;
    [sectionView addSubview:separatorLineView];
    
    /********** Add UITapGestureRecognizer to SectionView   **************/
    
    UITapGestureRecognizer  *headerTapped   = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sectionHeaderTapped:)];
    [sectionView addGestureRecognizer:headerTapped];
    
    return  sectionView;
    
    
}
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //closing filteration
    [self.baseViewController animateClose:true];
    
    //loading specific subcateogry data
    
}

-(void) tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


- (void)sectionHeaderTapped:(UITapGestureRecognizer *)gestureRecognizer{
    
    //section view
    UIView *sectionView = gestureRecognizer.view;
    
    //get tapped index
     NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:sectionView.tag];


    //this condition will open the section
    if(tappedSecIndex!=indexPath.section)
    {
        tappedSecIndex=indexPath.section;
        
        //expanding filter view further
        [self.baseViewController animateOpen:false];
      
    }else{
        //this will close
        tappedSecIndex=-1;
        
        //expanding filter view further
        [self.baseViewController animateClose:false];
        
        //reload all category data
//        [self.baseViewController requestEquimentList];
    }
  
    
//   [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.row] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [self.tableView reloadData];
  
}

-(int) getTableHeight
{
    //default height
    int height=120;
    if(self.filterEquipmentCateoryList!=nil && [self.filterEquipmentCateoryList count]>0)
    {
         height= [self.filterEquipmentCateoryList count] * 40;
    }
    
    if(tappedSecIndex!=-1)
    {
        FilterEquipmentCategoryDo *filterEquipmentCategoryDo= self.filterEquipmentCateoryList[tappedSecIndex];
        if(filterEquipmentCategoryDo.subcategory!=nil && [filterEquipmentCategoryDo.subcategory count]>0)
        {
            int childHieght= [filterEquipmentCategoryDo.subcategory count] * 40;
            height=height+childHieght;
        }
    }
    return height;
    
}


@end

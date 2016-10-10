//
//  UIController.m
//  IosApplicationFrameworkProject
//
//  Created by Ranjit singh on 2/9/15.
//  Copyright (c) 2015 syslogic. All rights reserved.
//

#import "UIController.h"
#import "ViewController.h"
#import "ApplicationController.h"
#import "ViewFactory.h"

@implementation UIController
@synthesize UIStack;
- (id)init
{
    self = [super init];
    if (self) {
        
        self-> UIStack =  [[NSMutableArray alloc]init];
        
    }
    return self;
}


-(void)initialize
{
    
}

-(void)destory
{
    
}
-(void)popScreen:(int)viewControllerType
{
    @autoreleasepool {
        
        if (currentUIViewController!=nil) {
            
            
            //add to main view to make this screen visible.
            switch (viewControllerType) {
                case VCT_VIEW_CONTROLLER:{
                    [(UIViewController*)currentUIViewController dismissViewControllerAnimated:YES completion:^{[self onScreenPoped];}];
                }
                    break;
                case VCT_ROOT_NAVIGATION_CONTROLLER:{
                    [(UIViewController*)currentUIViewController dismissViewControllerAnimated:YES completion:^{[self onScreenPoped];}];
                    
                }
                    break;
                case VCT_CHILD_NAVIGATION_CONTROLLER:{
                    [((UIViewController*)currentUIViewController).navigationController popViewControllerAnimated:YES];
                    [self onScreenPoped];
                }
                    break;
                case VCT_CHILD_CUSTOM_NAVIGATION_CONTROLLER:{
                    [self popChildCustomNavigationScreen];
                }
                    break;
                    
                    
            }
            
        }
    }
}


-(void) enable
{
    
}

-(void) disbale
{
    
}

-(void) hideNotify
{
    
}

-(void) showNotify
{
    
}


-(void)setRootViewController:(UIViewController*)rootUiViewController{
    self->mainRootUIViewController = (id <AbstractViewController>)rootUiViewController;
    self->currentUIViewController = mainRootUIViewController;
}

-(UIViewController*)getRootViewController{
    return (UIViewController*)self->mainRootUIViewController;
}
-(UIViewController*)getCurrentUIViewController{
    return (UIViewController*)self->currentUIViewController;
}


-(void)pushScreen:(int)viewControllerType screenId:(int)screenId viewFactory:(ViewFactory*)viewFactory eventObject:(NSObject *)eventObject
{
    @autoreleasepool {
        
        UIViewController *viewController = (UIViewController*)[viewFactory getAbstractUIViewController:(screenId) eventObject:eventObject];
        
        switch (viewControllerType) {
            case VCT_VIEW_CONTROLLER:{
                [self pushNewScreen:(id <AbstractViewController>)viewController];
                break;
            }
            case VCT_ROOT_NAVIGATION_CONTROLLER:{
                [self pushNewNavigationScreen:(id <AbstractViewController>)viewController];
            }
                break;
                
            case VCT_CHILD_NAVIGATION_CONTROLLER:{
                [self pushChildNavigationScreen:(id <AbstractViewController>)viewController];
            }
            case VCT_ROOT_CUSTOM_NAVIGATION_CONTROLLER:{
                [self pushNewCustomNavigationScreen:(id <AbstractViewController>)viewController screenId:(int)screenId viewFactory:(ViewFactory*)viewFactory eventObject:eventObject];
            }
                break;
                
            case VCT_CHILD_CUSTOM_NAVIGATION_CONTROLLER:{
                [self pushCustomChildNavigationScreen:(id <AbstractViewController>)viewController screenId:(int)screenId];
            }
                break;
            default:
                break;
                
        }
        viewController = nil;
    }
    
    //pusihing the new screen into stack.
    //    [self pushNewScreen:screenId viewFactory:viewFactory];
}

/*
 * Pushes the new navigation screen controller initializing with rootview controller.
 */
-(void)pushNewCustomNavigationScreen:(id<AbstractViewController>)abstractViewController screenId:(int)screenId viewFactory:(ViewFactory*)viewFactory eventObject:(NSObject *)eventObject{
    //added this logic for temp.
    CustomNavigationViewController *customNavigationController = (CustomNavigationViewController*)[viewFactory getAbstractUIViewController:VF_JOB_LIST_CUSTOM_NAVIGATION_CONTROLLER_SCREEN eventObject:eventObject];
    
    [(UIViewController*)currentUIViewController  presentViewController:customNavigationController animated:YES completion:^{}];
    
    customNavigationController = nil;
}


/*
 * Pushes the new navigation screen controller initializing with rootview controller.
 */
-(void)pushNewNavigationScreen:(id<AbstractViewController>)uiViewController{
    @autoreleasepool {
        
        UINavigationController *uiNavigationController = [[UINavigationController alloc] initWithRootViewController:(UIViewController*)uiViewController];
        //replace the prev UI with current UI view.
        self->prevUIViewController = self->currentUIViewController;
        
        
        //set this view as a current view.
        self->currentUIViewController = uiViewController;
        
        //remove pre view if it contains
        if (prevUIViewController!=nil) {
            //        [prevUIViewController removeFromParentViewController];
        }
        
        
        [(UIViewController*)prevUIViewController  presentViewController:uiNavigationController animated:YES completion:^{[self onNewScreenPushed];}];
        uiNavigationController = nil;
        prevUIViewController = nil;
    }
}

/*
 * Pushes the child controller screen to navigation controller.
 */
-(void)pushCustomChildNavigationScreen:(id<AbstractViewController>)uiViewController screenId:(int)screenId{
    @autoreleasepool {
        
        //replace the prev UI with current UI view.
        self->prevUIViewController = self->currentUIViewController;
        
        
        //set this view as a current view.
        self->currentUIViewController = uiViewController;
        
        //Getting Previous Controller to get its parent navigation controller for launching next child controller.
        UIViewController *currentViewController = (UIViewController*)uiViewController;
        
        //here gets the custom navigation controller screen from View factory.
        CustomNavigationViewController *customNavigationController = [[ApplicationController getInstance] getViewFactory].jobListCustomNavigationViewController;
        currentViewController.view.frame = customNavigationController.bodyContainerView.bounds;
        
        //Set current screen Id to previous screen Id for backup.
        customNavigationController.previousScreenId = customNavigationController.currentScreenId;
        
        
        //Set screent Id to customNavigationController for launching it from Slider drawer.
        customNavigationController.currentScreenId = screenId;
        
        
        //as this is the custom navigation controller, so adding the child controller to root.
        [customNavigationController.bodyContainerView addSubview:currentViewController.view];
        [customNavigationController addChildViewController:currentViewController];
        [currentViewController didMoveToParentViewController:customNavigationController];
        //here have to launch the child screen.
        [self onNewScreenPushed];
        currentViewController = nil;
        customNavigationController = nil;
    }
}

/*
 * Pushes the child controller screen to navigation controller.
 */
-(void)pushChildNavigationScreen:(id<AbstractViewController>)uiViewController{
    
    //replace the prev UI with current UI view.
    self->prevUIViewController = self->currentUIViewController;
    
    
    //set this view as a current view.
    self->currentUIViewController = uiViewController;
    
    //Getting Previous Controller to get its parent navigation controller for launching next child controller.
    UIViewController *prevController = (UIViewController*)prevUIViewController;
    
    [prevController.navigationController pushViewController:(UIViewController*)currentUIViewController animated:YES];
    
    [self onNewScreenPushed];
    prevController = nil;
}

/*
 * Launches the new normal view controller.
 */
-(void)pushNewScreen:(id<AbstractViewController>)uiViewController{
    @autoreleasepool {
        NSLog(@"Before swipe : Current : %@,Prev: %@",currentUIViewController,prevUIViewController);
        
        //replace the prev UI with current UI view.
        self->prevUIViewController = self->currentUIViewController;
        
        //set this view as a current view.
        self->currentUIViewController = uiViewController;
        
        NSLog(@"After swipe: Current : %@,Prev: %@",currentUIViewController,prevUIViewController);
        
        [(UIViewController*)prevUIViewController  presentViewController:(UIViewController*)currentUIViewController animated:YES completion:^{[self onNewScreenPushed];}];
        
    }
}

/*
 * Removed the the child from its parent Custom Navigation Screen
 */
-(void) popChildCustomNavigationScreen{
    
    //Getting Previous Controller to get its parent navigation controller for launching next child controller.
    UIViewController *currentViewController = (UIViewController*)currentUIViewController;
    
    CustomNavigationViewController *customNavigationController = [[ApplicationController getInstance] getViewFactory].jobListCustomNavigationViewController;
    
    //Replace current screen Id to previous screen Id when we finish the current screen.
    customNavigationController.currentScreenId = customNavigationController.previousScreenId;
    
    //here removes current view from its parent container.
    [currentViewController.view removeFromSuperview];
    //finally calling the onscreenPopped
    int noOfChilds = [[customNavigationController.bodyContainerView subviews] count];
    if(noOfChilds ==0){
        //if now no of childs for the custom navigation controller are zero, then finishing this customviewcontroller as well.
        //        [customNavigationController dismissViewControllerAnimated:YES completion:nil];
        //        [[ApplicationController getInstance] getViewFactory].jobListCustomNavigationViewController = nil;
    }
    [self onScreenPoped];
    currentViewController = nil;
}

/*
 This method gets call on view controller is finished, i.e poped up.
 
 */
-(void) onScreenPoped{
    //calls the reInitialize callback for prev screen which is going to be in foreground.
    //    [prevUIViewController reInitialize];
    
    //remove the screen which need to be finished and making prev screen to front and top at stack.
    [UIStack removeObject:currentUIViewController];
    
    //Holds current executing controller which is require to finish and remove from stack.
    // id <AbstractViewController> tempAbstractViewController = currentUIViewController;
    
    //calls the enable callback for prev screen.
    //    [prevUIView enable];
    NSLog(@"Current : %@,Prev: %@",currentUIViewController,prevUIViewController);
    NSLog(@"After Current UI Removed: %u",[UIStack count]);
    
    //here calling the destroy method for removed view controller.
    [currentUIViewController destroy];
    currentUIViewController = prevUIViewController;
    
    NSInteger prevViewInd = [UIStack count]-2;
    
    if(prevViewInd>=0){
        prevUIViewController = [UIStack objectAtIndex:prevViewInd];
    }
    NSLog(@"After Pop Up : %u",[UIStack count]);
    
    [currentUIViewController onTopScreenFinished];
    
}
/*
 This method gets call on view controller is added, i.e pushed.
 
 */
-(void) onNewScreenPushed{
    //call the initialize call back of current UIView
    //    [currentUIViewController initialize];
    
    
    //call enable callback of current UIView as it set to the Main View.
    //    [currentUIViewController enable];
    
    
    //add this view to stack at the top position.
    [self->UIStack addObject:currentUIViewController];
    NSLog(@"Stack Size: %u",[UIStack count]);
}

/*
 * Method to release UI controller stack on logout
 */
-(void)clearUIStack{
    @autoreleasepool {
        
        for (int i=[UIStack count]-1; i>=0; i--) {
            NSLog(@"UI stack count %lu",(unsigned long)[UIStack count]);
            
            id <AbstractViewController> abstractViewController = [UIStack objectAtIndex:i];
            [self popScreen:abstractViewController.viewControllerType];
            
            NSLog(@"View Controller Type in UI Stack %d",abstractViewController.viewControllerType);
        }
    }
}

@end

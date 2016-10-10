//
//  ChatViewController.m
//  FleetRight
//
//  Created by test on 12/09/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import "ChatViewController.h"
#import "Utils.h"

@interface ChatViewController ()

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeInstance];
    [self initializeViews];
    [self registerForKeyboardNotifications];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [self initFilterView];
}

/*
 * Method to initialize views
 */
-(void)initializeInstance{
    [super initializeInstance];
    
    
    [_scrollView setContentSize:CGSizeMake(_parentView.frame.size.width, _parentView.frame.size.height)];
    
    
    [self.actionBarHeaderView addSubview: [self loadActionBarView]];
    activeTextView.delegate = self;
    
    tempArray = [[NSMutableArray alloc]initWithObjects:
                 @"1......Since the alien army vastly outnumbers the team, players must use the post-apocalyptic world to their advantage, such as seeking cover behind dumpsters, pillars, cars, rubble, and other objects.",
                 @"Hello",
                 @"2......Since the alien army vastly outnumbers the team, players must use the post-apocalyptic world to their advantage, such as seeking cover behind dumpsters, pillars, cars, rubble, and other objects.Since the alien army vastly outnumbers the team, players must use the post-apocalyptic world to their advantage, such as seeking cover behind dumpsters, pillars, cars, rubble, and other objects.",
                 @"3.....Since the alien army vastly outnumbers the team, players must use the post-apocalyptic world to their advantage, such as seeking cover behind dumpsters, pillars, cars, rubble, and other objects.Since the alien army vastly outnumbers the team, players must use the post-apocalyptic world to their advantage, such as seeking cover behind dumpsters, pillars, cars, rubble, and other objects.Since the alien army vastly outnumbers the team, players must use the post-apocalyptic world to their advantage, such as seeking cover behind dumpsters, pillars, cars, rubble, and other objects.",
                 @"4.....Since the alien army vastly outnumbers the team, players must use the post-apocalyptic world to their advantage, such as seeking cover behind dumpsters, pillars, cars, rubble, and other objects.Since the alien army vastly outnumbers the team, players must use the post-apocalyptic world to their advantage, such as seeking cover behind dumpsters, pillars, cars, rubble, and other objects.Since the alien army vastly outnumbers the team, players must use the post-apocalyptic world to their advantage, such as seeking cover behind dumpsters, pillars, cars, rubble, and other objects.Since the alien army vastly outnumbers the team, players must use the post-apocalyptic world to their advantage, such as seeking cover behind dumpsters, pillars, cars, rubble, and other objects. 4.....Since the alien army vastly outnumbers the team, players must use the post-apocalyptic world to their advantage, such as seeking cover behind dumpsters, pillars, cars, rubble, and other objects.Since the alien army vastly outnumbers the team, players must use the post-apocalyptic world to their advantage, such as seeking cover behind dumpsters, pillars, cars, rubble, and other objects.Since the alien army vastly outnumbers the team, players must use the post-apocalyptic world to their advantage, such as seeking cover behind dumpsters, pillars, cars, rubble, and other objects.Since the alien army vastly outnumbers the team, players must use the post-apocalyptic world to their advantage, such as seeking cover behind dumpsters, pillars, cars, rubble, and other objects.",
                 nil];
    
}

-(void)initializeViews{
    [activeTextView resignFirstResponder];
    [Utils setBorderColourToView:self.typeMessageTextView colour:[UIColor lightGrayColor] ];
    
    //Ad placehodel in comment textview
    _typeMessageTextView.text = @"Your Response....";
    _typeMessageTextView.textColor = [UIColor lightGrayColor];
    _typeMessageTextView.delegate = self;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [tempArray count];
    //return 10;
}

int textLabelHeight=0;


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *simpleTableIdentifier = @"ChatTableViewCell";
    static NSString *simpleTableIdentifierForLeftCell = @"ChatTableViewCellLeft";
    
    if(indexPath.row%2==0)
    {
        ChatTableViewCellLeft *cellLeft = (ChatTableViewCellLeft *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifierForLeftCell];
        if (cellLeft == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:simpleTableIdentifierForLeftCell owner:self options:nil];
            cellLeft = [nib objectAtIndex:0];
        }
        
    
        //setting chat text
        cellLeft.chatTextLabel.text = [tempArray objectAtIndex:indexPath.row];
        [cellLeft.chatTextLabel sizeToFit];
        
        textLabelHeight=cellLeft.chatTextLabel.contentSize.height;
        
//        if(textLabelHeight<51)
//        {
//            textLabelHeight=51;
//        }
//        
//        CGRect frame2 = cellLeft.frame;
//        frame2.size.height= textLabelHeight;
//        cellLeft.frame= frame2;
        
    
        return cellLeft;
        
    }else{
        
        ChatTableViewCell *cell = (ChatTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ChatTableViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
      
        
        //setting chat text
        cell.chatTextLabel.text = [tempArray objectAtIndex:indexPath.row];
        [cell.chatTextLabel sizeToFit];
        
        textLabelHeight=cell.chatTextLabel.contentSize.height;
        
        
        CGRect frame = cell.chatTextLabel.frame;
        frame.origin.x= cell.chatImageView.frame.origin.x-(cell.chatTextLabel.contentSize.width+10);
        cell.chatTextLabel.frame= frame;
        
   
      

//        if(textLabelHeight<51)
//        {
//            textLabelHeight=51;
//        }
//        
//        CGRect frame2 = cell.frame;
//        frame2.size.height= textLabelHeight;
//        cell.frame= frame2;
        
        
        
        NSLog(@">>width @%i",textLabelHeight);
        return cell;
    }
    
    
    
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    
}



//-(CGFloat)heightForText:(NSString*)text withFont:(UIFont *)font andWidth:(CGFloat)width
//{
//    CGSize constrainedSize = CGSizeMake(width, MAXFLOAT);
//    
//    NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil];
//    
//    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:text attributes:attributesDictionary];
//    
//    CGRect requiredHeight = [string boundingRectWithSize:constrainedSize options:NSStringDrawingUsesLineFragmentOrigin context:nil];
//    
//    if (requiredHeight.size.width > width) {
//        requiredHeight = CGRectMake(0,0,width, requiredHeight.size.height);
//    }
//    return requiredHeight.size.height;
//}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    int height=textLabelHeight;
    if(height>51)
    {
        return height;
    }else{
        return 51;
    }
    
}



//****************** TEXTVIEW CALLBACK METHODS ******************//

- (void)textViewDidBeginEditing:(UITextView *)textView{
    activeTextView = textView;
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    activeTextView = nil;
}

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    if (textView ==  _typeMessageTextView) {
        _typeMessageTextView.text = @"";
        _typeMessageTextView.textColor = [UIColor blackColor];
    }
    
    return YES;
}

-(void) textViewDidChange:(UITextView *)textView
{
    if (textView ==  _typeMessageTextView) {
        if(_typeMessageTextView.text.length == 0){
            _typeMessageTextView.textColor = [UIColor lightGrayColor];
            _typeMessageTextView.text = @"Your Response....";
            [_typeMessageTextView resignFirstResponder];
        }
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    // Any new character added is passed in as the "text" parameter
    if ([text isEqualToString:@"\n"]) {
        // Be sure to test for equality using the "isEqualToString" message
        [textView resignFirstResponder];
        
        // Return FALSE so that the final '\n' character doesn't get added
        return FALSE;
    }
    // For any other character return TRUE so that the text gets added to the view
    return TRUE;
}


//****************** SCREEN SCROLL ON KEYBOARD OPEN ******************//
/*
 * Method to ajust the height of screen when keyboard is open
 */
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    _scrollView.contentInset = contentInsets;
    _scrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your app might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, _footerView.frame.origin) ) {
        [self.scrollView scrollRectToVisible:_footerView.frame animated:YES];
    }
    
}


// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    _scrollView.contentInset = contentInsets;
    _scrollView.scrollIndicatorInsets = contentInsets;
}



- (IBAction)onSendBtnClick:(id)sender {
    
    NSString *text=self.typeMessageTextView.text;
    
    if(text.length>0)
    {
        [tempArray addObject:text];
        self.typeMessageTextView.text=@"";
        [self.chatTableView reloadData];
        [self scrollTableViewToBtm];
        

    }
}

-(void)scrollTableViewToBtm{
    
//    double delayInSeconds = 0.005;
//    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
//    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    
        CGFloat yOffset = 0;
        
        if (self.chatTableView.contentSize.height > self.chatTableView.bounds.size.height) {
            yOffset = self.chatTableView.contentSize.height - self.chatTableView.bounds.size.height;
            [self.chatTableView setContentOffset:CGPointMake(0, yOffset) animated:NO];
       
        }
//    });
    
}
@end

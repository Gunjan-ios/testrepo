//
//  GISAddLayersViewController.m
//  TestSpatialite
//
//  Created by Gaurav on 30/07/19.
//  Copyright © 2019 Gaurav. All rights reserved.
//

#import "GISAddLayersViewController.h"

@interface GISAddLayersViewController ()<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource> {
    UIPickerView *pickerDataType;
    UITextField *txtFieldDataType;
}

@property(nonatomic, strong) UITextField *txtFieldName;

@end

@implementation GISAddLayersViewController
@synthesize txtFieldName;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
    [self initDesign];
    
}

#pragma mark - actions
-(void)btnTapped:(id)sender {
    [self.view removeFromSuperview];
    
}

-(void)btnSave:(id)sender {
    [self.view removeFromSuperview];
}

-(void)btnAddFields:(id)sender {
   
}

-(void)doneClickForDataType:(id)sender {
    [txtFieldDataType resignFirstResponder];
}


-(void)initDesign {
 
    int yPosition = 70;
    const int labelWidth = 180;
    const int textFieldWidth = 150;
    const int spacing = 20;
    
    UILabel *lblName = [[UILabel alloc] initWithFrame:CGRectMake(10, yPosition, labelWidth, 30)];
    lblName.text = @"Name:";
    [self.view addSubview:lblName];
    
    self.txtFieldName = [[UITextField alloc] initWithFrame:CGRectMake(labelWidth + spacing, yPosition, textFieldWidth, 30)];
    self.txtFieldName.backgroundColor = [UIColor lightGrayColor];
    self.txtFieldName.delegate = self;
    self.txtFieldName.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:self.txtFieldName];
    
    yPosition += 50;
    
    UILabel *lblType = [[UILabel alloc] initWithFrame:CGRectMake(10, yPosition, labelWidth, 30)];
    lblType.text = @"Type:";
    [self.view addSubview:lblType];
    
    pickerDataType = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 50, 100, 150)];
    [pickerDataType setDataSource: self];
    [pickerDataType setDelegate: self];
    pickerDataType.showsSelectionIndicator = YES;
    
    UIToolbar *toolBar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,320,44)];
    [toolBar setBarStyle:UIBarStyleDefault];
    
    UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                      style:UIBarButtonItemStyleDone target:self action:@selector(doneClickForDataType:)];
    
    UIBarButtonItem *barButtonSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    toolBar.items = @[barButtonSpace, barButtonDone];
    barButtonDone.tintColor=[UIColor blackColor];
    
    txtFieldDataType = [[UITextField alloc] initWithFrame:CGRectMake(labelWidth + spacing, yPosition, textFieldWidth, 30)];
    txtFieldDataType.backgroundColor = [UIColor lightGrayColor];
    txtFieldDataType.delegate = self;
    txtFieldDataType.returnKeyType = UIReturnKeyDone;
    txtFieldDataType.inputView = pickerDataType;
    txtFieldDataType.inputAccessoryView = toolBar;
    [self.view addSubview:txtFieldDataType];
    
    yPosition += 50;
    
    UILabel *lblAddFields = [[UILabel alloc] initWithFrame:CGRectMake(10, yPosition, labelWidth, 30)];
    lblAddFields.text = @"Add Fields:";
    [self.view addSubview:lblAddFields];
    
    UIButton *btnAddFields = [[UIButton alloc] initWithFrame:CGRectMake(labelWidth + spacing, yPosition, textFieldWidth, 30)];
    [btnAddFields setBackgroundColor:[UIColor grayColor]];
    [btnAddFields setTitle:@"+" forState:UIControlStateNormal];
    [btnAddFields addTarget:self action:@selector(btnAddFields:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnAddFields];
    
    yPosition += 80;
    
    UIButton *btnSave = [[UIButton alloc] initWithFrame:CGRectMake(100, yPosition, 100, 40)];
    [btnSave setBackgroundColor:[UIColor lightGrayColor]];
    [btnSave setTitle:@"Save" forState:UIControlStateNormal];
    [btnSave addTarget:self action:@selector(btnSave:) forControlEvents:UIControlEventTouchUpInside];
    btnSave.center = CGPointMake((SCREEN_WIDTH/2), yPosition + 25);
    [self.view addSubview:btnSave];
    
}

#pragma mark - pickerview delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 3;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return @"Data";
}


@end

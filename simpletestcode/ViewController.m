//
//  ViewController.m
//  simpletestcode
//
//  Created by Palash Borhan Uddin on 2018-07-12.
//  Copyright © 2018 AnyConnect. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.testbutton.layer.cornerRadius = 12;
	self.testbutton.backgroundColor = [UIColor blueColor];
	self.testbutton.titleLabel.textColor = [UIColor whiteColor];
	self.testbutton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:15.0];
	self.testbutton.tintColor = [UIColor whiteColor];
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)handleButtonClick:(id)sender {
	dispatch_async(dispatch_get_main_queue(), ^{
		self.testlabel.textColor = [UIColor blueColor];
		[self messageAlert:@"Welcome to AnyConnect test!" Message:@""];
	});
}

- (void) messageAlert: (NSString*) title Message: (NSString*) errorMessage {
	dispatch_async(dispatch_get_main_queue(), ^{
		
		UIAlertController* alert = [UIAlertController alertControllerWithTitle:title
																	   message:errorMessage
																preferredStyle:UIAlertControllerStyleAlert];

		UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault
															  handler:^(UIAlertAction * action) {}];
		
		[alert addAction:defaultAction];
		[self presentViewController:alert animated:YES completion:nil];
	});
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


@end

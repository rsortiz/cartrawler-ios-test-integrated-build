//
//  ViewController.m
//  CarTrawlerSDKIntegrated
//
//  Created by Rafael Ortiz on 17/09/2019.
//  Copyright © 2019 CarTrawler. All rights reserved.
//

#import "ViewController.h"
#import "CarTrawlerSDK/CarTrawlerSDK.h"

@interface ViewController () <CarTrawlerSDKDelegate>

@property (nonatomic, strong) CarTrawlerSDK *sdk;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.sdk =  [CarTrawlerSDK sharedInstance];
    
    [[UINavigationBar appearance] setTintColor:[UIColor redColor]];
    [[UINavigationBar appearance] setBarTintColor:[UIColor redColor]];
    
    [[UINavigationBar appearance] setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[UIImage imageNamed:@"2"]];
}

- (IBAction)showPresentStandAlone {
    [self.sdk presentStandAloneFromViewController:self
                                         clientID:@"313415"
                                      countryCode:nil
                                     currencyCode:@"EUR"
                                     languageCode:@"es"
                                       passengers:nil];
}

- (IBAction)showPresentStandAloneWithDeeplink {
    [self.sdk presentStandAloneFromViewController:self
                                         clientID:@"313415"
                                      countryCode:nil
                                     currencyCode:@"EUR"
                                     languageCode:@"es"
                                       pickupDate:[NSDate dateWithTimeIntervalSinceNow:86400]
                                      dropOffDate:nil
                                         IATACode:nil
                                 pickupLocationID:@"11"
                                dropOffLocationID:@"11"
                                  pinnedVehicleID:nil
                                       passengers:nil];
}

/**
 Called when the user chooses to add the vehicle to their basket
 
 @param request A dictionary containing information about the vehicle and the Cartrawler OTA payment request
 @param vehicle The vehicle that was selected
 */

/**
 Called when the user taps on the cross sell card
 */
- (void)didTapCrossSellCard {
    NSLog(@"didTapCrossSellCard");
}

/**
 Called when the vehicles have been fetched and the best daily rate has been calculated
 
 @param price the best daily rate
 @param currency the currency
 */
- (void)didReceiveBestDailyRate:(nonnull NSNumber *)price
                       currency:(nonnull NSString *)currency {
    NSLog(@"didReceiveBestDailyRate: %@ %@", price, currency);
}

/**
 Called when the call to fetch vehicles fails and the best daily rate cannot be calculated
 */
- (void)didFailToReceiveBestDailyRate {
    NSLog(@"didFailToReceiveBestDailyRate");
}

#pragma Mark - GroundTransportation

/**
 Called when the user taps on the cross sell card
 */
- (void)didTapGroundTransportationCard {
    NSLog(@"didTapGroundTransportationCard");
}

/**
 Called when the vehicles have been fetched and the best daily rate has been calculated
 
 @param price the best daily rate
 @param currency the currency
 */
- (void)didReceiveGroundTransportationBestDailyRate:(nonnull NSNumber *)price
                                           currency:(nonnull NSString *)currency {
    NSLog(@"didReceiveGroundTransportationBestDailyRate %@ %@", price, currency);
}

/**
 Called when the call to fetch vehicles fails and the best daily rate cannot be calculated
 */
- (void)didFailToReceiveGroundTransportationBestDailyRate {
    NSLog(@"didFailToReceiveGroundTransportationBestDailyRate");
}

- (void)didFailToReceiveBestDailyRate:(nonnull NSError *)error {
    NSLog(@"didFailToReceiveBestDailyRate");
}

- (void)didProduceInPathPaymentRequest:(nonnull NSDictionary *)request vehicle:(nonnull CTInPathVehicle *)vehicle
                        paymentDetails:(nonnull Payment *)paymentDetails {
    NSLog(@"didProduceInPathPaymentRequest: request - %@ | vehicle: %@ | paymentDetails: %@", request, vehicle, paymentDetails);
}

@end

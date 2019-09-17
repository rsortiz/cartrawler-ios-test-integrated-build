//
//  PresentViewController.swift
//  CarTrawlerSDKIntegrated
//
//  Created by Rafael Ortiz on 17/09/2019.
//  Copyright © 2019 CarTrawler. All rights reserved.
//

import UIKit
import CarTrawlerSDK

class PresentViewController: UIViewController {
    
    @IBOutlet var widgetView: UIView!
    @IBOutlet var stackWidgetView: UIStackView!
    
    var simpleWidget: CTWidgetContainer!
    var bestPriceWidget: CTWidgetContainer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let widgetStyle = CTWidgetStyle()
        self.simpleWidget = CarTrawlerSDK.sharedInstance().getWidget(status: .simple,
                                                                     style: widgetStyle,
                                                                     delegate: self)
        
        self.bestPriceWidget = CarTrawlerSDK.sharedInstance().getWidget(status: .bestPrice,
                                                                        style: widgetStyle,
                                                                        delegate: self)
        
        self.stackWidgetView.insertArrangedSubview(self.simpleWidget, at: 0)
        self.stackWidgetView.insertArrangedSubview(self.bestPriceWidget, at: 1)
        
        let params = CTAPIQueryParams()
        params.clientID = "303436"
        params.pickupDate = Date(timeIntervalSinceNow: 86400)
        params.iataCode = "DUB"
        params.delegate = self
        
        CarTrawlerSDK.sharedInstance().requestBestDailyRate(params)
    }
    
    @IBAction func presentStandAlone() {
        //        let passenger = CTPassenger(firstName: "Rafa", lastName: "Ortiz", addressLine1: "address", addressLine2: nil, city: "city", postcode: "postcode", countryCode: "IE", age: 18, email: nil, phone: nil, phoneCountryPrefix: nil, isPrimaryDriver: true)

        
        let context = CTContext.initWithClientID("313415",
                                                 countryCode: nil,
                                                 currencyCode: nil,
                                                 languageCode: nil,
                                                 passengers: nil)
        //        let context = CTContext(clientID: "642619", flow: .standAlone)
        //        context.pickupDate = Date(timeIntervalSinceNow: 86400 * 1)
        //        context.dropOffDate = Date(timeIntervalSinceNow: 86400 * 3)
        //        context.pickupLocation = "DUB"
        CarTrawlerSDK.sharedInstance().present(from: self, context: context)
    }
    
    
    @IBAction func clearStorage() {
        CarTrawlerSDK.sharedInstance().clearStorage { (error) in
            if error != nil {
                print("Error")
            } else {
                print("Success")
            }
        }
    }
    
    @IBAction func presentStandAloneWithDeeplink() {
        let context = CTContext(clientID: "642619", flow: .standAlone)
        context.pickupDate = Date(timeIntervalSinceNow: 3600)
        context.dropOffDate = Date(timeIntervalSinceNow: 3600)
        context.pickupLocation = "DUB"
        CarTrawlerSDK.sharedInstance().present(from: self, context: context)
    }
    
    @IBAction func presentInPath() {
        CarTrawlerSDK.sharedInstance().initialiseInPath(withClientID: "105614",
                                                        currency: "EUR",
                                                        customerCountry: "IE",
                                                        languageCode: "EN",
                                                        iataCode: "DUB",
                                                        pickupDate: Date(timeIntervalSinceNow: 86400),
                                                        return: nil,
                                                        pinnedVehicleID: nil,
                                                        flightNumber: nil,
                                                        passengers: nil,
                                                        delegate: self)
        
        let cardView = CarTrawlerSDK.sharedInstance().getRentalCard()
        self.widgetView.addSubview(cardView);
        
        self.view.addConstraints([NSLayoutConstraint(item: cardView, attribute: .top, relatedBy: .equal, toItem: widgetView, attribute: .top, multiplier: 1, constant: 0),
                                  NSLayoutConstraint(item: cardView, attribute: .bottom, relatedBy: .equal, toItem: widgetView, attribute: .bottom, multiplier: 1, constant: 0),
                                  NSLayoutConstraint(item: cardView, attribute: .left, relatedBy: .equal, toItem: widgetView, attribute: .left, multiplier: 1, constant: 0),
                                  NSLayoutConstraint(item: cardView, attribute: .right, relatedBy: .equal, toItem: widgetView, attribute: .right, multiplier: 1, constant: 0)])
        CarTrawlerSDK.sharedInstance().presentInPath(from: self)
    }
    
}

extension PresentViewController: CarTrawlerSDKDelegate {
    func didProduce(inPathPaymentRequest request: [AnyHashable : Any], vehicle: CTInPathVehicle, paymentDetails: Payment) {
        print("didProduce")
    }
    
    func didFailToReceiveBestDailyRate(error: Error) {
        print("didFailToReceiveBestDailyRate")
    }
    
    func didReceiveBestDailyRate(_ price: NSNumber, currency: String) {
        print("didReceiveBestDailyRate")
    }
}

extension PresentViewController: CTWidgetContainerDelegate {
    
    func didTapView(_ container: CTWidgetContainer) {
        self.presentStandAlone()
        print("didTapView")
    }
    
    func didTapAddCarHire(_ container: CTWidgetContainer) {
        print("didTapAddCarHire")
        self.presentStandAlone()
    }
    
    func didTapRemoveButton(_ container: CTWidgetContainer) {
        print("didTapRemoveButton")
        var status = CTWidgetStatus.simple
        
        if (container == self.bestPriceWidget) {
            status = CTWidgetStatus.bestPrice
        }
        
        container.setStatus(status)
    }
    
    func vehicleSelected(_ vehicle: CTVehicleDetails) {
        self.bestPriceWidget.setVehicle(vehicle)
        self.bestPriceWidget.setStatus(.vehicle)
        
        self.simpleWidget.setStatus(.simpleAddedCar)
        print("vehicleSelected")
    }
    
}

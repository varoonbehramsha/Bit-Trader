//
//  BTOrderTicketPresenter.swift
//  Bit Trader
//
//  Created by Varoon Behramsha on 17/01/20.
//  Copyright © 2020 Varoon Behramsha. All rights reserved.
//

import Foundation
import UIKit



protocol OrderTicketPresenterProtocol
{
	var sellingPrice : NSAttributedString {get}
	var buyingPrice : NSAttributedString {get}
	var spread : String {get}
	func unitsFor(amount: Double) -> String
	func amountFor(units:Double) -> String
	func loadData(_ completionHandler:@escaping (_ success:Bool,_ statusMessage:String)->())
}

class BTOrderTicketPresenter : OrderTicketPresenterProtocol
{
	private var price : BTPrice?
	private var priceService : BTPriceService!
	
	private var numberFormatter : NumberFormatter
	
	
	var sellingPrice: NSAttributedString
	{
		guard self.price != nil else
		{
			return NSAttributedString()
		}
		
		let number = NSNumber(floatLiteral: self.price!.sellingPrice)
		let priceString = self.numberFormatter.string(from: number)!
		let lhsAttributes = [NSAttributedString.Key.font:BTFont.pricePrimaryFont]
		let rhsAttributes : [NSAttributedString.Key : Any] = [NSAttributedString.Key.font:BTFont.priceSecondaryFont]
		let atrString = NSMutableAttributedString(string: priceString, attributes: lhsAttributes)
		atrString.addAttributes(rhsAttributes, range: NSRange(location: priceString.count-3, length: 3))
		return atrString
	}
	
	var buyingPrice: NSAttributedString
	{
		guard self.price != nil else
		{
			return NSAttributedString()
		}
		
		let number = NSNumber(floatLiteral: self.price!.buyingPrice)
		let priceString = self.numberFormatter.string(from: number)!
		let lhsAttributes = [NSAttributedString.Key.font:BTFont.pricePrimaryFont]
		let rhsAttributes : [NSAttributedString.Key : Any] = [NSAttributedString.Key.font:BTFont.priceSecondaryFont]
		let atrString = NSMutableAttributedString(string: priceString, attributes: lhsAttributes as [NSAttributedString.Key : Any])
		atrString.addAttributes(rhsAttributes, range: NSRange(location: priceString.count-3, length: 3))
		return atrString
	}
	
	
	
	var spread: String
	{
		guard self.price != nil else
		{
			return ""
		}
		
		return "\(self.price!.buyingPrice - self.price!.sellingPrice)"
	}
	
	init(priceService:BTPriceService) {
		self.priceService = priceService
		
		//Initialise number formatter
		let numberFormatter = NumberFormatter()
		numberFormatter.numberStyle = .decimal
		numberFormatter.minimumFractionDigits = 2
		self.numberFormatter = numberFormatter
	}
	
	
	func amountFor(units: Double) -> String {
		
		guard self.price != nil else
		{
			return ""
		}
		
		return String(format: "%.2f",self.price!.buyingPrice * units)
	}
	
	func unitsFor(amount: Double) -> String {
		guard self.price != nil else
		{
			return ""
		}
		
		return String(format: "%.2f", amount/self.price!.buyingPrice)
	}
	
	func loadData(_ completionHandler: @escaping (Bool,String) -> ()) {
		self.priceService.getBitcoinPrices { (successful, statusMessage, prices) in
			if successful
			{
				guard prices != nil else
				{
					completionHandler(false,"Prices are missing in response")
					return
				}
				
				self.price = prices!.gbp
			}
			completionHandler(successful,statusMessage)
		}
	}
}

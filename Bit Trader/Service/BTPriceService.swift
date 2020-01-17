//
//  BTPriceService.swift
//  Bit Trader
//
//  Created by Varoon Behramsha on 17/01/20.
//  Copyright © 2020 Varoon Behramsha. All rights reserved.
//

import Foundation

protocol PriceService : class
{
	func getBitcoinPrices(_ completionHandler: @escaping (_ successful:Bool,_ statusMessage:String,_ prices:BTBitcoinPrices?)->())
}

class BTPriceService : PriceService
{
	private var networkManager : NetworkManager<BlockchainAPI>
	
	init(networkManager:NetworkManager<BlockchainAPI>) {
		self.networkManager = networkManager
	}
	
	func getBitcoinPrices(_ completionHandler: @escaping (_ successful:Bool,_ statusMessage:String,_ prices:BTBitcoinPrices?)->())
	{
		self.networkManager.router.request(.ticker) { (data, response, error) in
			guard error == nil else
			{
				completionHandler(false,error.debugDescription,nil)
				return
			}
			
			if let response = response as? HTTPURLResponse
			{
				let result = self.networkManager.handleNetworkResponse(response)
				
				switch result
				{
				case .success:
					guard let responseData = data else {
						completionHandler(false,"Ticker API falied to return data.",nil)
						return
					}
					do {
						
						let bitcoinPrices = try JSONDecoder().decode(BTBitcoinPrices.self, from: responseData)
						completionHandler(true,"Success",bitcoinPrices)
					}catch {
						print(error)
						completionHandler(false,"Failed to decode data in Ticker API",nil)
						
					}
				case .failure(let failureMessage):
					completionHandler(false,"Ticker API failed with message:\n \(failureMessage)",nil)
					
				}
			}
			
			
		}
	}
}

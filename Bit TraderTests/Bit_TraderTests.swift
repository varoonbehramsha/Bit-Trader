//
//  Bit_TraderTests.swift
//  Bit TraderTests
//
//  Created by Varoon Behramsha on 17/01/20.
//  Copyright © 2020 Varoon Behramsha. All rights reserved.
//

import XCTest
@testable import Bit_Trader

class Bit_TraderTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


	/// Tests if the BlockchainAPI endpoint returns valid data for the ticker API.
	func testTickerAPI()
	{
		let expectation = self.expectation(description: "Ticker API returns valid response")
		let networkManager = NetworkManager<BlockchainAPI>()
		networkManager.router.request(.ticker) { (data, response, error) in
			if error == nil
			{
				guard data != nil else
				{
					XCTFail("Data missing")
					expectation.fulfill()
					return
				}
				
				do
				{
					let responseJSON = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
					print(responseJSON)
					expectation.fulfill()
				}
				catch{
					XCTFail("Failed to make JSON object from response data")
					expectation.fulfill()
				}
			}else
			{
				XCTFail("API failed")
				expectation.fulfill()
			}
		}
		
		waitForExpectations(timeout: 5, handler: nil)
		
	}
	
	/// Tests the getBitcoinPrices method in BTPriceService.
	func testGetBitcoinPrices()
	{
		let expectation = self.expectation(description: "getBitcoinPrices() returns valid data")

		let networkManager = NetworkManager<BlockchainAPI>()
		
		let priceService = BTPriceService(networkManager: networkManager)
		
		priceService.getBitcoinPrices { (successful, statusMessage, bitcoinPrices) in
			
			guard successful else {
		
				XCTFail(statusMessage)
				expectation.fulfill()
				return
			}
			
			if let prices = bitcoinPrices {
			
				print(prices)
				expectation.fulfill()
				
			}else
			{
				XCTFail(statusMessage)
				expectation.fulfill()
			}
		}
		waitForExpectations(timeout: 5, handler: nil)
	}
	
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

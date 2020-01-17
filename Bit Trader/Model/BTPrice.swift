//
//  BTPrice.swift
//  Bit Trader
//
//  Created by Varoon Behramsha on 17/01/20.
//  Copyright © 2020 Varoon Behramsha. All rights reserved.
//

import Foundation

struct BTPrice
{
	var delayedMarketPrice : Double
	var recentMarketPrice : Double
	var buyingPrice : Double
	var sellingPrice : Double
	var symbol : String
}

extension BTPrice : Codable
{
	enum CodingKeys : String,CodingKey
	{
		case delayedMarketPrice = "15m"
		case recentMarketPrice = "last"
		case buyingPrice = "buy"
		case sellingPrice = "sell"
		case symbol
	}
}

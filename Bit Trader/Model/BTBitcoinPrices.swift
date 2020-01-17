//
//  BTBitcoinPrices.swift
//  Bit Trader
//
//  Created by Varoon Behramsha on 17/01/20.
//  Copyright © 2020 Varoon Behramsha. All rights reserved.
//

import Foundation

struct BTBitcoinPrices
{
	var usd : BTPrice
	var jpy : BTPrice
	var cny : BTPrice
	var gbp : BTPrice
	
}

extension BTBitcoinPrices : Codable
{
	enum CodingKeys : String, CodingKey
	{
		case usd = "USD"
		case jpy = "JPY"
		case cny = "CNY"
		case gbp = "GBP"
	}
}

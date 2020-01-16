//
//  BlockchainAPI.swift
//  Bit Trader
//
//  Created by Varoon Behramsha on 17/01/20.
//  Copyright © 2020 Varoon Behramsha. All rights reserved.
//

import Foundation

enum BlockchainAPI
{
	case ticker
}

extension BlockchainAPI : EndPointType
{
	var baseURL: URL {
		return URL(string:"https://blockchain.info")!
	}
	
	var path: String {
		switch self {
		case .ticker:
			return "/ticker"
		
		}
	}
	
	var httpMethod: HTTPMethod {
		switch self {
		case .ticker:
			return HTTPMethod.get
		
		}
	}
	
	var task: HTTPTask {
		switch self {
		case .ticker:
			return HTTPTask.request
		
		}
	}
	
	var headers: HTTPHeaders? {
		switch self {
		case .ticker:
			return nil
		
		}
	}
	
	
}

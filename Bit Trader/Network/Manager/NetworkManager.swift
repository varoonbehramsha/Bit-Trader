//
//  NetworkManager.swift
//  Varoon Behramsha
//
//  Created by Varoon Behramsha on 10/11/19.
//  Copyright © 2019 Varoon Behramsha. All rights reserved.
//

import Foundation

struct NetworkManager<EndPoint:EndPointType>
{
      //var environment : NetworkEnvironment = .production
	 //var authToken :String?
	var router = Router<EndPoint>()
	
//	init(authToken:String?) {
//		self.authToken = authToken
//	}
	
     func handleNetworkResponse(_ response:HTTPURLResponse) -> Result<String>{
        switch response.statusCode
        {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
}

enum NetworkResponse:String
{
    case success
    case authenticationError = "Authentication Failed"
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request Failed."
    case noData = "Response returned with no data."
    case unableToDecode = "Could not decode the response."
}

enum Result<String>{
    case success
    case failure(String)
}

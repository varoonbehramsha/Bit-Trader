//
//  EndPoint.swift
//  Varoon Behramsha
//
//  Created by Varoon Behramsha on 10/11/19.
//  Copyright © 2019 Varoon Behramsha. All rights reserved.
//

import Foundation

protocol EndPointType
{
    var baseURL : URL {get}
    var path : String {get}
    var httpMethod : HTTPMethod {get}
    var task : HTTPTask {get}
    var headers : HTTPHeaders? {get}
    
}

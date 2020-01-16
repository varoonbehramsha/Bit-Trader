//
//  ParameterEncoding.swift
//  Varoon Behramsha
//
//  Created by Varoon Behramsha on 10/11/19.
//  Copyright © 2019 Varoon Behramsha. All rights reserved.
//

import Foundation

public typealias Parameters = [String:Any]

public protocol ParameterEncoder {
    static func encode(urlRequest:inout URLRequest, with parameters:Parameters) throws
}

//
//  JSONParameterEncoding.swift
//  Varoon Behramsha
//
//  Created by Varoon Behramsha on 10/11/19.
//  Copyright © 2019 Varoon Behramsha. All rights reserved.
//

import Foundation

public struct JSONParameterEncoding: ParameterEncoder{
    public static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        do
        {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            urlRequest.httpBody = jsonData
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil
            {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
        }catch
        {
            throw NetworkError.encodingFailed
        }
    }
}

//
//  NetworkRouter.swift
//  Varoon Behramsha
//
//  Created by Varoon Behramsha on 10/11/19.
//  Copyright © 2019 Varoon Behramsha. All rights reserved.
//

import Foundation

public typealias NetworkRouterCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?)->()

protocol NetworkRouter: class {
    associatedtype EndPoint:EndPointType
    func request(_ route:EndPoint,completion: @escaping NetworkRouterCompletion)
	func uploadRequest(_ route:EndPoint,_ data:Data, completion:@escaping NetworkRouterCompletion)
    func cancel()
}

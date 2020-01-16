//
//  NetworkError.swift
//  Varoon Behramsha
//
//  Created by Varoon Behramsha on 10/11/19.
//  Copyright © 2019 Varoon Behramsha. All rights reserved.
//

import Foundation

public enum NetworkError : String,Error
{
    case parametersNil = "Parameters were nil."
    case encodingFailed = "Failed to encode paramters."
    case missingURL = "URL is nil"
}

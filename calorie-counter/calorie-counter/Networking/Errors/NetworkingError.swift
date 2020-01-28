//
//  NetworkingError.swift
//  divco
//
//  Created by Irina Butaru on 20/08/2019.
//  Copyright © 2019 Irina Butaru. All rights reserved.
//

import Foundation

enum NetworkingError: Error {
    case offline
    case unknownStatus
    case unknown
}

extension NetworkingError {
    var message: String? {
        switch self {
        case .offline:
            return "No internet connection"
        case .unknown:
            return "Unknown Error"
        case .unknownStatus:
            return "Unknown Error"
        }
    }
}

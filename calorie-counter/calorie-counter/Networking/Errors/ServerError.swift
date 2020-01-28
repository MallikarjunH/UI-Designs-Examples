//
//  ServerError.swift
//  divco
//
//  Created by Irina Butaru on 19/08/2019.
//  Copyright © 2019 Irina Butaru. All rights reserved.
//

import UIKit

protocol ServerError: Error {
    var serverMesssage: String? { get }
}

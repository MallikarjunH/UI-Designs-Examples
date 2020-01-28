//
//  PromiseError.swift
//  divco
//
//  Created by Irina Butaru on 22/08/2019.
//  Copyright © 2019 Irina Butaru. All rights reserved.
//

import Foundation
import PromiseKit

enum PromiseError: CancellableError {
    case cancelled
    var isCancelled: Bool { return true}
}

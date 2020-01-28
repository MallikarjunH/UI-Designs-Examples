//
//  AppDelegate+PromiseKit.swift
//  divco
//
//  Created by Irina Butaru on 20/08/2019.
//  Copyright © 2019 Irina Butaru. All rights reserved.
//

import Foundation
import PromiseKit

extension AppDelegate {
    func setupPromiseKit() {
        PromiseKit.conf.Q.map = .global(qos: .background)
        PromiseKit.conf.Q.return = .global(qos: .background)
    }
}

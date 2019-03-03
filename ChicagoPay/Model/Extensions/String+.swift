//
//  String+.swift
//  ChicagoPay
//
//  Created by Matt Deuschle on 3/3/19.
//  Copyright © 2019 Matt Deuschle. All rights reserved.
//

import Foundation

extension String {
    var dollars: String {
        let double = Double(self) ?? 0.0
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.currency
        return numberFormatter.string(from: NSNumber(value: double)) ?? ""
    }
}

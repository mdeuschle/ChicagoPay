//
//  Result.swift
//  ChicagoPay
//
//  Created by Matt Deuschle on 2/28/19.
//  Copyright © 2019 Matt Deuschle. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error?)
}

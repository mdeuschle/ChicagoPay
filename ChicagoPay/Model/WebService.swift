//
//  WebService.swift
//  ChicagoPay
//
//  Created by Matt Deuschle on 2/27/19.
//  Copyright © 2019 Matt Deuschle. All rights reserved.
//

import Foundation

struct WebService {
    static let shared = WebService()
    private init() {}
    
    func downloadSalaries(completion: @escaping (Bool, [Salary]?) -> Void) {
        
        
    }
}

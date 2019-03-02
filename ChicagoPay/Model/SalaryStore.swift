//
//  SalaryStore.swift
//  ChicagoPay
//
//  Created by Matt Deuschle on 2/28/19.
//  Copyright © 2019 Matt Deuschle. All rights reserved.
//

import Foundation

struct SalaryStore {
    func downloadSalaries(completion: @escaping ([Salary]?) -> Void) {
        WebService.shared.dataTask { result in
            switch result {
            case let .success(data):
                let json = try? JSONDecoder().decode([Salary].self, from: data)
                completion(json)
            case .failure:
                completion(nil)
            }
        }
    }
}

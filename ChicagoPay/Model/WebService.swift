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
    func dataTask(completion: @escaping (Result<Data>) -> Void) {
        let urlString = "https://data.cityofchicago.org/resource/xzkq-xp2w.json?$limit=5&$$app_token=LFuu36jqve2Td9BWBffSS1iJm"
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            let result: Result<Data>
            if data != nil && error == nil {
                result = .success(data!)
            } else {
                result = .failure(error)
            }
            completion(result)
        }
        task.resume()
    }
}



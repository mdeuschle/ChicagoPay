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
    func dataTask(for salaryType: SalaryType,
                  sortType: SortType,
                  completion: @escaping (Result<Data>) -> Void) {
        guard let url = url(for: salaryType, sortType: sortType) else { return }
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
    
    func url(for salaryType: SalaryType, sortType: SortType) -> URL? {
        let urlString: String
        let salaryTypeString: String
        let endpoint: String
        let baseString = "https://data.cityofchicago.org/resource/xzkq-xp2w.json?$$app_token=LFuu36jqve2Td9BWBffSS1iJm&$limit=5000&salary_or_hourly="
        switch salaryType {
        case .salary:
            salaryTypeString = "Salary"
        case .hourly:
            salaryTypeString = "Hourly"
        }
        switch sortType {
        case .name:
            endpoint = "&$order=name%20"
        case .title:
            endpoint = "&$order=job_titles%20"
        case .salary:
            if salaryType == .salary {
                endpoint = "&$order=annual_salary%20DESC"
            } else {
                endpoint = "&$order=hourly_rate%20DESC"
            }
        }
        urlString = baseString + salaryTypeString + endpoint
        return URL(string: urlString)
    }
}




//
//  Salary.swift
//  ChicagoPay
//
//  Created by Matt Deuschle on 2/27/19.
//  Copyright © 2019 Matt Deuschle. All rights reserved.
//

import Foundation

struct Salary: Decodable {
    let annual_salary: String?
    let department: String?
    let full_or_part_time: String?
    let job_titles: String?
    let name: String?
    let salary_or_hourly: String?
}

//"annual_salary": "101442.00",
//"department": "POLICE",
//"full_or_part_time": "F",
//"job_titles": "SERGEANT",
//"name": "AARON,  JEFFERY M",
//"salary_or_hourly": "Salary"

//
//  RootCell.swift
//  ChicagoPay
//
//  Created by Matt Deuschle on 3/2/19.
//  Copyright © 2019 Matt Deuschle. All rights reserved.
//

import UIKit

class RootCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var jobTitleLabel: UILabel!
    @IBOutlet weak var salaryLabel: UILabel!
    
    func configure(for salaryType: SalaryType, salary :Salary) {
        nameLabel.text = salary.name?.lowercased().capitalized
        jobTitleLabel.text = salary.job_titles?.lowercased().capitalized
        let salaryLabelText: String?
        if salaryType == .salary {
            salaryLabelText = salary.annual_salary?.dollars
        } else {
            salaryLabelText = salary.hourly_rate?.dollars
        }
        salaryLabel.text = salaryLabelText
    }
}

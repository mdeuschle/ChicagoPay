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
    
    func configure(_ salary :Salary) {
        nameLabel.text = salary.name?.lowercased().capitalized
        jobTitleLabel.text = salary.job_titles?.lowercased().capitalized
        salaryLabel.text = salary.annual_salary?.dollars
    }
}

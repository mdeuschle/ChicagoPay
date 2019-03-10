//
//  DetailVC.swift
//  ChicagoPay
//
//  Created by Matt Deuschle on 3/9/19.
//  Copyright © 2019 Matt Deuschle. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {
    
    @IBOutlet weak var annualSalaryLabel: UILabel!
    @IBOutlet weak var departmentLabel: UILabel!
    @IBOutlet weak var fullOrPartTimeLabel: UILabel!
    @IBOutlet weak var jobTitlesLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var salaryOrHourlyLabel: UILabel!
    @IBOutlet weak var hourlyRateLabel: UILabel!
    @IBOutlet weak var salaryStackView: UIStackView!
    @IBOutlet weak var hourlyStackView: UIStackView!
    
    var salary: Salary?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureLabelText()
        configureLabelVisibility()
    }
    
    private func configureLabelText() {
        annualSalaryLabel.text = salary?.annual_salary
        departmentLabel.text = salary?.department
        fullOrPartTimeLabel.text = salary?.full_or_part_time
        jobTitlesLabel.text = salary?.job_titles
        nameLabel.text = salary?.name
        salaryOrHourlyLabel.text = salary?.salary_or_hourly
        hourlyRateLabel.text = salary?.hourly_rate
    }
    
    private func configureLabelVisibility() {
        if salary?.annual_salary != nil {
            hourlyStackView.isHidden = true
        } else {
            salaryStackView.isHidden = true
        }
    }
}

//
//  RootVC.swift
//  ChicagoPay
//
//  Created by Matt Deuschle on 2/26/19.
//  Copyright © 2019 Matt Deuschle. All rights reserved.
//

import UIKit

class RootVC: UITableViewController {
    
    let store = SalaryStore()
    private var salaries = [Salary]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Chicago Pay"
        self.store.downloadSalaries { [weak self] salaries in
            DispatchQueue.main.async {
                if let salaries = salaries {
                    self?.salaries = salaries
                }
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return salaries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.accessoryType = .disclosureIndicator
        cell.backgroundColor = #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1)
        let salary = salaries[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.textLabel?.text = salary.name
        cell.detailTextLabel?.textColor = #colorLiteral(red: 0.4508578777, green: 0.9882974029, blue: 0.8376303315, alpha: 1)
        cell.detailTextLabel?.text = salary.annual_salary
        return cell
    }
}

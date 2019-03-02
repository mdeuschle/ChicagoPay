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
        let salary = salaries[indexPath.row]
        cell.textLabel?.text = salary.name
        cell.detailTextLabel?.text = salary.annual_salary
        return cell
    }
    
}

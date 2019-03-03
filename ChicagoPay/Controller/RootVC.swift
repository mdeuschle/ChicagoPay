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
        downloadSalaries()
        configureTableView()
    }
    
    private func configureTableView() {
        let nib = UINib(nibName: "RootCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "RootCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80.0
    }
    
    private func downloadSalaries() {
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
        return salaries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RootCell", for: indexPath) as? RootCell else {
            return UITableViewCell()
        }
        let salary = salaries[indexPath.row]
        cell.configure(salary)
        return cell
    }
}

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
    private var salaryType = SalaryType.salary
    
    private var salaries = [Salary]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Chicago Pay"
        downloadSalaries(for: .salary)
        configureTableView()
        configureSearchBar()
    }

    private func configureSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.showsScopeBar = true
        searchController.searchBar.scopeButtonTitles = ["Salary", "Hourly"]
        searchController.searchBar.setText(color: .white)
        searchController.searchBar.tintColor = .darkGray
        UISegmentedControl.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationItem.searchController = searchController
    }
    
    private func configureTableView() {
        let nib = UINib(nibName: "RootCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "RootCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80.0
    }
    
    private func downloadSalaries(for salaryType: SalaryType) {
        self.store.downloadSalaries(for: salaryType) { [weak self] salaries in
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
        cell.configure(for: salaryType, salary: salary)
        return cell
    }
}

extension RootVC: UISearchResultsUpdating, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        searchController.searchBar.setText(color: .white)
//        searchController.searchBar.tintColor = color?.dark.contrast
//        if let text = searchController.searchBar.text, !text.isEmpty {
//            departmentTitles = PayrollService.departmentTitles(for: payrolls).filter {
//                $0.lowercased().contains(text.lowercased())
//            }
//        } else {
//            departmentTitles = PayrollService.departmentTitles(for: payrolls)
//        }
    }
}

extension RootVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        salaryType = SalaryType(rawValue: selectedScope) ?? .salary
        downloadSalaries(for: salaryType)
    }
}

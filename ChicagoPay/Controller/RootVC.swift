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
    lazy var salaryType = SalaryType.salary
    private var isFiltering = false
    private var isSearchContollerHidden = true
    private var salaries = [Salary]() {
        didSet {
            tableView.reloadData()
        }
    }
    private var filteredSalaries = [Salary]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    private lazy var spinner: UIActivityIndicatorView = {
        let _spinner = UIActivityIndicatorView(style: .whiteLarge)
        let point = CGPoint(x: view.bounds.midX,
                            y: view.bounds.midY / 2)
        _spinner.center = point
        return _spinner
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Chicago Pay"
        configureTableView()
        configureSearchBar()
        view.addSubview(spinner)
        downloadSalaries(for: .salary) { }
        self.definesPresentationContext = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchController.searchBar.isHidden = false
    }
    
    private var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.showsScopeBar = true
        searchController.searchBar.scopeButtonTitles = ["Salary", "Hourly"]
        searchController.searchBar.setText(color: .white)
        searchController.searchBar.tintColor = .darkGray
        return searchController
    }()
    
    private func configureSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        UISegmentedControl.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    private func configureTableView() {
        let nib = UINib(nibName: "RootCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "RootCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80.0
    }
    
    private func downloadSalaries(for salaryType: SalaryType,
                                  completion: @escaping () -> Void) {
        salaries = [Salary]()
        filteredSalaries = [Salary]()
        spinner.startAnimating()
        tableView.allowsSelection = false
        self.store.downloadSalaries(for: salaryType) { [weak self] salaries in
            DispatchQueue.main.async {
                if let salaries = salaries {
                    self?.salaries = salaries
                    self?.spinner.stopAnimating()
                    self?.tableView.allowsSelection = true
                    completion()
                }
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? filteredSalaries.count : salaries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RootCell", for: indexPath) as? RootCell else {
            return UITableViewCell()
        }
        let row = indexPath.row
        let salary = isFiltering ? filteredSalaries[row] : salaries[row]
        cell.configure(for: salaryType, salary: salary)
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        let salary = isFiltering ? filteredSalaries[row] : salaries[row]
        let detailVC = DetailVC(salary: salary)    
        navigationController?.pushViewController(detailVC, animated: true)
        searchController.searchBar.isHidden = true
    }
}

extension RootVC: UISearchResultsUpdating, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        searchController.searchBar.setText(color: .white)
        if let text = searchController.searchBar.text, !text.isEmpty {
            let trimmedText = text.lowercased().trimmingCharacters(in: .whitespaces)
            isFiltering = true
            filteredSalaries = salaries.filter {
                $0.name?.lowercased().contains(trimmedText) ?? false
            }
        } else {
            isFiltering = false
            downloadSalaries(for: salaryType) { }
        }
    }
}

extension RootVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        salaryType = SalaryType(rawValue: selectedScope) ?? .salary
        downloadSalaries(for: salaryType) {
            if let text = searchBar.text, !text.isEmpty {
                let trimmedText = text.lowercased().trimmingCharacters(in: .whitespaces)
                self.isFiltering = true
                self.filteredSalaries = self.salaries.filter {
                    $0.name?.lowercased().contains(trimmedText) ?? false
                }
            } else {
                self.isFiltering = false
            }
        }
    }
}


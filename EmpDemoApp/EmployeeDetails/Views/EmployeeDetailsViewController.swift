//
//  EmployeeDetailsViewController.swift
//  EmpDemoApp
//
//  Created by Nitesh on 29/04/22.
//

import UIKit

class EmployeeDetailsViewController: UIViewController {
    
    @IBOutlet weak var employeeTableView: UITableView!
    
    private var employeeDetailsViewModel: EmployeeDetailsViewModel = EmployeeDetailsViewModel()
    fileprivate var employees: [EmployeeDetails] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpUI()
    }
    
    private func setUpUI(){
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Employees"
        self.employeeDetailsViewModel.employees.bind {[weak self] employees in
            guard let weakSelf = self else { return }
            print(employees.count)
            weakSelf.employees = employees
            DispatchQueue.main.async {
                weakSelf.employeeTableView.reloadData()
            }
        }
    }
    
}

extension EmployeeDetailsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.employees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EmployeeTableViewCell.cellIdentifier, for: indexPath) as! EmployeeTableViewCell
        cell.employee = self.employees[indexPath.row]
        return cell
    }
    
}

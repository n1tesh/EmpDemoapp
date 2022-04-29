//
//  EmployeeDetailsViewModel.swift
//  EmpDemoApp
//
//  Created by Nitesh on 29/04/22.
//

import Foundation

final class EmployeeDetailsViewModel {
    
    
    private(set) var errorMessage: Box<String?> = Box(nil)
    private(set) var employees: Box<[EmployeeDetails]> = Box([EmployeeDetails]())
    
    init() {
        getAllEmployees()
    }
    
    func getAllEmployees() {
        guard ConnectionManager.shared.hasConnectivity() else{
            self.fetchSavedEmployees()
            return
        }
        guard let url = URL(string: "http://measervicetest.erpguru.in/service.asmx/getAllMemberListForMenu?MemberId=347") else { return }
        
        NetworkManager.shared.getfetchData(url: url) { (result: Result<Root<[EmployeeDetails]>, APIError>) in
            switch result {
            case .success(let employees):
                guard let employees = employees.data else { return }
                for emp in employees{
                    CoreDataManager.shared.saveAllEmp(employeeDetails: emp)
                }
                self.fetchSavedEmployees()
            case .failure(let failure):
                self.errorMessage.value = failure.message
            }
        }
    }
    
    private func fetchSavedEmployees(){
        CoreDataManager.shared.getAllEmployees { result in
            switch result{
            case .success(let employees):
                self.employees.value = employees.map({ employee in
                    return EmployeeDetails(memberID: Int(employee.memberID), memberName: employee.memberName ?? "")
                })
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

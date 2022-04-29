//
//  CoreDataManager.swift
//  EmpDemoApp
//
//  Created by Nitesh on 29/04/22.
//

import Foundation
import CoreData

final class CoreDataManager {

    static let shared = CoreDataManager()
    
    private init() {}
    
    enum DatabaseError : Error{
        case failedToSaveWithOutAnyChanges
        case failedToSave
        case failedFetchData
        case failedToDeleteData
        case failedToUpdate
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let persistentContainer = NSPersistentContainer(name: "EmpDemoApp")
        persistentContainer.loadPersistentStores { (_, err) in
            guard let err = err else {
                return
            }
            print(err.localizedDescription)
        }
        return persistentContainer
    }()

    fileprivate var moc: NSManagedObjectContext {
        self.persistentContainer.viewContext
    }

    private func getAll<T: NSManagedObject>(completion: @escaping (Result<[T],Error>)-> Void){
        do {
            let fetchRequest = NSFetchRequest<T>(entityName: "\(T.self)")
            let data =  try self.moc.fetch(fetchRequest)
            completion(.success(data))
        } catch {
            print(error)
            completion(.failure(DatabaseError.failedFetchData))
        }
    }
    
    
    
    

    private func save(completion: @escaping (Result<Bool,Error>)-> Void) {
        guard self.moc.hasChanges else {
            completion(.failure(DatabaseError.failedToSaveWithOutAnyChanges))
            return
        }
        do {
            try self.moc.save()
            completion(.success(true))
        } catch {
            print(error)
            completion(.failure(DatabaseError.failedToSave))
        }
    }

}

extension CoreDataManager{
    
    func getAllEmployees(completion: @escaping (Result<[Employee],Error>)-> Void) {
        CoreDataManager.shared.getAll(completion: completion)
    }
    
    
    func saveAllEmp(employeeDetails: EmployeeDetails){
        var employee = Employee()
        let fetchRequest = NSFetchRequest<Employee>(entityName: String(describing: Employee.self))
        fetchRequest.predicate = NSPredicate(format: "memberID = %i", employeeDetails.memberID)
        let results = try? moc.fetch(fetchRequest)
        if results?.count == 0 {
           // here you are inserting
            employee = Employee(context: moc)
        } else {
           // here you are updating
            if let result = results?.first{
                employee = result
            }
        }

        employee.memberID = Int32(employeeDetails.memberID)
        employee.memberName = employeeDetails.memberName
        do {
            try self.moc.save()
//            completion(.success(true))
        } catch {
            print(error)
//            completion(.failure(DatabaseError.failedToSave))
        }
        
    }
    
}

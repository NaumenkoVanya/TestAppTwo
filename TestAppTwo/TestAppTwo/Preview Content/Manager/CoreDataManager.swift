//
//  CoreDataManager.swift
//  TestAppTwo
//
//  Created by Ваня Науменко on 3.04.25.
//

// CoreDataManager.swift
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "UserModel")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func createUser(email: String, password: String) {
        let user = User(context: context)
        user.email = email
        user.password = password
        saveContext()
    }
    
    func fetchUsers() -> [User] {
        let request: NSFetchRequest<User> = User.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            print("Error fetching users: \(error)")
            return []
        }
    }
    
    func deleteUser(_ user: User) {
        context.delete(user)
        saveContext()
    }
    
    func findUser(email: String) -> User? {
        let request: NSFetchRequest<User> = User.fetchRequest()
        request.predicate = NSPredicate(format: "email == %@", email)
        do {
            return try context.fetch(request).first
        } catch {
            print("Error finding user: \(error)")
            return nil
        }
    }
}

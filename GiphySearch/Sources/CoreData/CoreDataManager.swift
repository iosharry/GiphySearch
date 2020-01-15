//
//  CoreDataManager.swift
//  GiphySearch
//
//  Created by gwangyonglee on 2020/01/12.
//  Copyright © 2020 gwangyonglee. All rights reserved.
//

import CoreData

final class CoreDataManager {
	static let shared = CoreDataManager()
	static let modelName = "FavoriteGiphy"
	static let entityName = "FavoriteGiphyData"
	
	lazy var storeContainer: NSPersistentContainer = {
		let container = NSPersistentContainer(name: CoreDataManager.modelName)
		container.loadPersistentStores { (storeDescription, error) in
			if let error = error as NSError? {
				print("\(#function) -> Unresolved error \(error), \(error.userInfo)")
			}
		}
		return container
	}()
	
	lazy var managedContext: NSManagedObjectContext = {
		return self.storeContainer.viewContext
	}()
	
	func saveContext() {
		guard managedContext.hasChanges else { return }
		do {
			try managedContext.save()
		} catch let error as NSError {
			print("\(#function) -> \(error.localizedDescription)")
		}
	}
}

extension CoreDataManager {
	func fetch() -> [NSManagedObject] {
		let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: CoreDataManager.entityName)
		let sortDescriptor = NSSortDescriptor(key: "timestamp", ascending: false)
		fetchRequest.sortDescriptors = [sortDescriptor]
		do {
			let results = try managedContext.fetch(fetchRequest)
			return results
        } catch let error as NSError {
			print("Unresolved error \(error), \(error.userInfo)")
        }
        return []
	}
	
    func save(_ giphyModel: GiphyModel, completionHandler: ((Bool) -> Void)) {
		let favoriteGiphy = FavoriteGiphyData(context: managedContext)
        favoriteGiphy.id = giphyModel.id
        favoriteGiphy.url = giphyModel.url
        favoriteGiphy.width = giphyModel.width
        favoriteGiphy.height = giphyModel.height
		favoriteGiphy.timestamp = Date()
		
		guard managedContext.hasChanges else { return }
		do {
			try managedContext.save()
			completionHandler(true)
		} catch {
			let nserror = error as NSError
			completionHandler(false)
			print("\(#function) -> Unresolved error \(nserror), \(nserror.userInfo)")
		}
	}
	
	func delete(id: String, completionHandler: ((Bool) -> Void)) {
		let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: CoreDataManager.entityName)
		let predicate = NSPredicate(format: "id == %@", id)
		fetchRequest.predicate = predicate
		do {
			let results = try managedContext.fetch(fetchRequest)
			if let result = results.first {
				managedContext.delete(result)
				completionHandler(true)
			}
		} catch {
			completionHandler(false)
		}
	}
}

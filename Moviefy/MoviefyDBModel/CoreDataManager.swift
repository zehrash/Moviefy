//
//  File.swift
//  Moviefy
//
//  Created by Zehra Iliyaz on 10.03.21.
//

import Foundation
import CoreData

class CoreDataManager {
    
    
    static let sharedManager = CoreDataManager()
    private init() {}
    
    
    
    lazy var persistentContainer: NSPersistentContainer = {
       
       let container = NSPersistentContainer(name: "CoreDataMoviefy")
       
       
       container.loadPersistentStores(completionHandler: { (storeDescription, error) in
         
         if let error = error as NSError? {
           fatalError("Unresolved error \(error), \(error.userInfo)")
         }
       })
       return container
     }()
    
   private func saveContext () {
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        if context.hasChanges {
          do {
            try context.save()
          } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
          }
        }
      }

    public func insertUser (user:User){
        
            let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
            
        let entity = NSEntityDescription.entity(forEntityName: "Users",
                                                in: managedContext)!
        
        let userSample = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        
        userSample.setValue(user.email, forKeyPath: "user_id")
        userSample.setValue(user.username, forKeyPath: "username")
        userSample.setValue(user.email, forKeyPath: "email")
        userSample.setValue(user.password, forKeyPath: "password")
     
        do {
          try managedContext.save()
        } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
        }
      }

    
    public func saveToWatchLater(username:String,movie:MovieModel){
        
            let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
            
        let entity = NSEntityDescription.entity(forEntityName: "User_watch_later",
                                                in: managedContext)!
        
        let sample = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        
        sample.setValue(movie.id, forKeyPath: "movie_id")
        sample.setValue(username, forKeyPath: "username")
     
        do {
          try managedContext.save()
            insertMovie(movieModel: movie, backdropImage: movie.backdropImage!, posterImage: movie.posterImage!)
        } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
        }
      }

    public func saveToWatchedList(username:String, movie:MovieModel){
        
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
            
        let entity = NSEntityDescription.entity(forEntityName: "User_watched_list",
                                                in: managedContext)!
        
        let sample = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        
        sample.setValue(movie.id, forKeyPath: "movie_id")
        sample.setValue(username, forKeyPath: "username")
        
        do {
          try managedContext.save()
            insertMovie(movieModel: movie, backdropImage: movie.backdropImage!, posterImage: movie.posterImage!)
        } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
        }
      }
    
    
    
    func insertMovie( movieModel:MovieModel, backdropImage:Data, posterImage:Data) {
        
    
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
    
        let entity = NSEntityDescription.entity(forEntityName: "Movie_details",
                                                in: managedContext)!
        
        let movie = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
  
        movie.setValue(movieModel.title, forKeyPath: "title")
        movie.setValue(movieModel.id, forKeyPath: "movie_id")
        movie.setValue(movieModel.overview, forKeyPath: "overview")
        movie.setValue(movieModel.releaseDate, forKeyPath: "releaseDate")
        movie.setValue(movieModel.voteAverage, forKeyPath: "voteAverage")
        movie.setValue(backdropImage, forKeyPath: "backdropImage")
        movie.setValue(posterImage, forKeyPath: "posterImage")
    
        do {
          try managedContext.save()
        } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
        }
      }
    
    
    func fetchWatchedListMovies(username:String)->[Movie_details?]{
        var movies = [Movie_details?]()
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User_watched_list")
        fetchRequest.predicate = NSPredicate(format: "username == %@" ,username)
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            for i in result {
                movies.append(contentsOf: fetchMovieFromDB(movieID: Int((i as! User_watched_list).movie_id))!)
            }
            return movies
        }catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return movies
          }
    }
    

    
    func fetchMovieFromDB(movieID:Int) -> [Movie_details]?{
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Movie_details")
    
        fetchRequest.predicate = NSPredicate(format: "movie_id == %d" ,movieID)
            do {
                let result = try managedContext.fetch(fetchRequest)
                return (result as? [Movie_details])!
            }catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
                return nil
              }
    
    }
    
    
}

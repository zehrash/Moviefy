//
//  File.swift
//  Moviefy
//
//  Created by Zehra Iliyaz on 10.03.21.
//
// swiftlint:disable force_cast
// swiftlint:disable trailing_whitespace
import Foundation
import CoreData

class CoreDataManager {
    
    static let sharedManager = CoreDataManager()
    private init() {}
  
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "CoreDataMoviefy")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
       
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    func insertUser(user:User) {
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
       
        let userEntity = Users(context: managedContext)
        
        userEntity.email = user.email
        userEntity.password = user.password
        userEntity.username = user.username
        userEntity.isLogged = true
   //     print(userEntity.email, userEntity.password, userEntity.username, userEntity.isLogged)
        self.saveContext()
    }
    
   
    func saveToWatchLater(username: String, movie: MovieModel) {
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        let movieDetails = MovieDetails (context: managedContext)
        movieDetails.movieID = Int32(movie.id)
        movieDetails.title = movie.title
        movieDetails.releaseDate = movie.releaseDate
        movieDetails.overview = movie.overview
        movieDetails.voteAverage = movie.voteAverage
        movieDetails.backdropImage = movie.backdropImage
        movieDetails.posterImage = movie.posterImage
        
        let user = fetchUser(username: username)

        let watchLaterMovies = WatchLaterList(context: managedContext)
        watchLaterMovies.movieList = movieDetails
        watchLaterMovies.user = user
        
        self.saveContext()
    }

    public func saveToWatchedList(username: String, movie: MovieModel){
        
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
            
        let movieDetails = MovieDetails(context: managedContext)
        movieDetails.movieID = Int32(movie.id)
        movieDetails.title = movie.title
        movieDetails.releaseDate = movie.releaseDate
        movieDetails.overview = movie.overview
        movieDetails.voteAverage = movie.voteAverage
        movieDetails.backdropImage = movie.backdropImage
        movieDetails.posterImage = movie.posterImage
        
        let user = fetchUser(username: username)
        
        let watchedMovies = WatchedList(context: managedContext)
        watchedMovies.movieList = movieDetails
        watchedMovies.user = user
        
        self.saveContext()
      }
  
    func fetchWatchedListMovies(username: String) -> [MovieModel] {
     
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "WatchedList")
        fetchRequest.predicate = NSPredicate(format: "user.username == %@", username)
        
        do {
            let result = try managedContext.fetch(fetchRequest) as! [WatchedList]
           
            let lists = result.compactMap {
                (watchedList: WatchedList) -> MovieModel? in
                guard let movie = watchedList.movieList else{
                    return nil
                }
                
                return MovieModel(id: Int(movie.movieID), title: movie.title ?? "", backdropPath: nil, posterPath: nil,
                                  overview: movie.overview ?? "", releaseDate: movie.releaseDate ?? "", voteAverage: 0.0,
                                  backdropImage: movie.backdropImage, posterImage: movie.posterImage)
            }
            return lists
            
        }catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
          }
    }
    
    func fetchWatchLaterListMovies(username: String) -> [MovieModel] {
   
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "WatchLaterList")
        fetchRequest.predicate = NSPredicate(format: "user.username == %@",username)
        
        do {
            let result = try managedContext.fetch(fetchRequest) as! [WatchLaterList]
            let lists = result.compactMap {
                (watchedList: WatchLaterList) -> MovieModel? in
                guard let movie = watchedList.movieList else{
                    return nil
                }
                return MovieModel(id: Int(movie.movieID), title: movie.title ?? "", backdropPath: nil, posterPath: nil,
                                  overview: movie.overview ?? "", releaseDate: movie.releaseDate ?? "", voteAverage: 0.0,
                                  backdropImage: movie.backdropImage, posterImage: movie.posterImage)
            }
            return lists
            
        }catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
          }
    }
    
    func fetchUser(username: String) -> Users? {
        
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Users")
        fetchRequest.predicate = NSPredicate(format: "username == %@" ,username)
       
        do {
            let result = try managedContext.fetch(fetchRequest) as! [Users]
            /*
            let lists = result.compactMap{ (users: Users) -> User? in
            
                let user = User.shared
                user.setUser(username: users.username ?? "", email: users.email ?? "", password: users.password ?? "")
              return user
               // return User(username: users.username ?? "", email: users.email ?? "", password: users.password ?? "")

            }
            return lists.first
 */
            return result.first
        }catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
          }
    }
    func isLoggedIn(username: String) -> Bool{
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Users")
        fetchRequest.predicate = NSPredicate(format: "username == %@", username)
        
        do {
            let result = try managedContext.fetch(fetchRequest) as! [Users]
            /*
            let lists = result.compactMap{ (users: Users) -> User? in
            
                
                let user = User.shared
                user.setUser(username: users.username ?? "", email: users.email ?? "", password: users.password ?? "")
              return user
                //return User(username: users.username ?? "", email: users.email ?? "", password: users.password ?? "")

            }
            return lists.first.isLogged
 */
            return ((result.first?.isLogged) != nil)
        }catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return false
          }
    
    }
    
    func fetchLoggedInUser() -> User?{
        
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Users")
        let status = true
        fetchRequest.predicate = NSPredicate(format: "isLogged == %d", status)
               
        do {
            let result = try managedContext.fetch(fetchRequest) as! [Users]
            let lists = result.compactMap{ (users: Users) -> User? in
             
                let user = User.shared
                user.setUser(username: users.username ?? "", email: users.email ?? "", password: users.password ?? "")
              return user
                //return User(username: users.username ?? "", email: users.email ?? "", password: users.password ?? "")

            }
            return lists.first
        }catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
          }
    }
    
    func updateUser (username: String, isLoggedIn: Bool){
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Users")
        fetchRequest.predicate = NSPredicate(format: "username == %@", username)
        do {
            let result = try managedContext.fetch(fetchRequest) as! [Users]
            let user = result.first
            user?.isLogged = isLoggedIn
            
            self.saveContext()
        }catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
          }
    }
}

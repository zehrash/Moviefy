//
//  CoreDataHelper.swift
//  Moviefy
//
//  Created by Zehra Iliyaz on 23.03.21.
//

import Foundation
class CoreDataHelper{
    
    var user = User.shared
    
    func addUser(username: String, email: String, password: String, logged: Bool){
        self.user.setUser(username: username, email: email, password: password)
        print(user.username, user.email, user.password)
        CoreDataManager.sharedManager.insertUser(user: self.user)
    }
    
    func isUserSignedIn(user: User){
        
    }
    func isUserLoggedIn(username: String)->Bool {
        let isLoggedIn = CoreDataManager.sharedManager.isLoggedIn(username: username)
        return isLoggedIn
    }
    
    func updateLogIn(username: String, isLoggedIn: Bool) {
        CoreDataManager.sharedManager.updateUser(username: username, isLoggedIn: isLoggedIn)
    }
    
    func getLoggedInUser() -> User? {
        return CoreDataManager.sharedManager.fetchLoggedInUser()
    }
    
    func addToWatchLater(movie: MovieModel) {
        CoreDataManager.sharedManager.saveToWatchLater(username: self.user.username, movie: movie)
    }

    func addToWatched(movie: MovieModel) {
        print(user.username, user.email, user.password)
        CoreDataManager.sharedManager.saveToWatchedList(username: self.user.username, movie: movie)
    }
    func getWatchedList() -> [MovieModel]{
        return CoreDataManager.sharedManager.fetchWatchedListMovies(username: user.username)

    }
    func getWatchLaterList() -> [MovieModel]{
       return CoreDataManager.sharedManager.fetchWatchLaterListMovies(username: user.username)
    }
    
}

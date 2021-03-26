//
//  User.swift
//  Moviefy
//
//  Created by Zehra Iliyaz on 10.02.21.
//

import Foundation

class User{
    static let shared = User()
    
    public var username: String = ""
    public var email: String = ""
    public var password: String = ""
    
    
    private init(){}
    
    func setUser (username:String, email:String, password:String) {
        self.username = username
        self.email = email
        self.password = password
    }
}

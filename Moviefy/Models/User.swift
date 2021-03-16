//
//  User.swift
//  Moviefy
//
//  Created by Zehra Iliyaz on 10.02.21.
//

import Foundation

class User{
    
    public let id: Int
    public let username: String
    public let email: String
    public let password: String
    
    
    init(id:Int, username:String, email:String, password:String) {
        self.id = id
        self.username = username
        self.email = email
        self.password = password
    }
    
}

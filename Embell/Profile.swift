//
//  Profile.swift
//  Embell
//
//  Created by Jonathon F Vega on 3/13/17.
//  Copyright © 2017 Jonathon Vega. All rights reserved.
//

import Foundation

class Profile {
    let userID: String
    let name: String
    let email: String
    
    init(userID:String, name:String, email:String) {
        self.userID = userID
        self.name = name
        self.email = email
    }
    
    /*let getName: String = {
        return name
    }()*/
}

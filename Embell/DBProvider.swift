//
//  DBProvider.swift
//  Embell
//
//  Created by Jonathon F Vega on 3/12/17.
//  Copyright © 2017 Jonathon Vega. All rights reserved.
//

import Foundation
import FirebaseDatabase

class DBProvider {
    
    private static let _instance = DBProvider()
    
    private init() {}
    
    static var Instance: DBProvider {
        return _instance
    }
    
    var dbRef: FIRDatabaseReference {
        return FIRDatabase.database().reference()
    }
    
    
    var userRef: FIRDatabaseReference {
        return dbRef.child(Constants.USERS)
    }
    
    var messageRef: FIRDatabaseReference {
        return dbRef.child(Constants.MESSAGES)
    }
    
    func saveUser(withID: String, email: String, password: String) {
        let data: Dictionary<String, Any> = [Constants.EMAIL: email, Constants.PASSWORD: password]
        
        userRef.child(withID).setValue(data)
    }
}

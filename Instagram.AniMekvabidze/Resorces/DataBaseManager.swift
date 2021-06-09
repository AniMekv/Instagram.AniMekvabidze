//
//  DataBaseManager.swift
//  Instagram.AniMekvabidze
//
//  Created by Mac User on 5/29/21.
//

import FirebaseDatabase
//import UIKit
//import Foundation

public class DatabaseManager {
    static let shared  = DatabaseManager()
    
    private let database = Database.database().reference()
    
    
    // MARK: - Public
    
    /// Check is username and email i available
    /// - Parameters
    ///   - email: String representing email
    ///     - username:  String representing username
    public func canCreateNewUser(email: String, username: String, completion: (Bool) -> Void) {
        completion(true)
    
        
    }
    
    /// Inserts new user data to database
    /// - Parameters
    ///   - email: String representing email
    ///     - username:  String representing username
    ///     - complition: Asynccallback for result  if database entry succeded
    public func insertNewUser(email: String, username: String, completion: @escaping (Bool) -> Void) {
        let key = email.safeDataBaseKey()
        database.child(key).setValue(["username": username]) { error, _ in
            if error == nil {
                // successed
                completion(true)
                return
            }
            else {
                //failed
                completion(false)
                return
            }
        }
    }
}
    
    //  we can't have key in database period, therefore i create a safe email
    // MARK: -Private
    
    private func safeKey() {
        
    }
 


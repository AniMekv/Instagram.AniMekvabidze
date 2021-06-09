//
//  AuthManager.swift
//  Instagram.AniMekvabidze
//
//  Created by Mac User on 5/29/21.
//
import FirebaseAuth

public class AuthManager {
    
    static let shared  = AuthManager()
    
    // MARK: - Public
    
    public func registerNewUser(username: String, email: String, password: String, comletion: @escaping (Bool) -> Void) {
        // when you drop a popup apeares and says what is it about
        /*
         - Check if usernmae is available
         - check if email is available
         */
        // trailing closure sintax is {succes in }
        DatabaseManager.shared.canCreateNewUser(email: email, username: username) { canCreate in
            if canCreate {
                /*
                 - Create account
                 - insert account to database
                 */
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    guard error == nil,  result != nil else {
                        // firebase auth couldn't create account
                        comletion(false)
                        return
                    }
                    // insert into database
                    DatabaseManager.shared.insertNewUser(email: email, username: username) { inserted in
                        if inserted {
                            comletion(true)
                            return
                        }
                        else {
                            //failed to insert to database
                            comletion(false)
                            return
                        }
                    }
                }
            }
            else {
                // either usernmae or email doesnt exist
                comletion(false)
            }
        }
    }
    
    public func loginUser(username: String?, email: String?, password: String, completion: @escaping (Bool) -> Void) {
        if let email = email {
            // email log in
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                guard authResult != nil, error == nil else {
                    completion(false)
                    return
                }
                completion(true)
            }
        }
        else if let username = username {
            // username log in
            print(username)
        }
    }
    
    /// Attempt to log out FireBase user
    public func logOut(completion: (Bool) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(true)
            return
        }
        catch {
            completion(false)
            print(error)
            return
        }
        
    }
}

//
//  SignInWorker.swift
//  BookPlace
//
//  Created by Artem Lyksa on 3/8/17.
//  Copyright (c) 2017 Artem Lyksa. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit
import FBSDKLoginKit
import GoogleSignIn

class SignInWorker
{
    
    func signInWithFacebook(completionHandler: @escaping (User) -> ())
    {
        if (FBSDKAccessToken.current()) != nil {
            loginWithFB(completionHandler: { (response) in
                completionHandler(User(name: response["name"]!, email: response["email"]!))
            })
        } else {
            let loginManager = FBSDKLoginManager()
            loginManager.logIn(withReadPermissions: ["public_profile", "email"], from: nil) { (result, error) in
                self.loginWithFB(completionHandler: { (response) in
                    completionHandler(User(name: response["name"]!, email: response["email"]!))
                })
            }
        }
    }
    
    private func loginWithFB(completionHandler: @escaping ([String : String]) -> ()) -> ()
    {
        FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"email,id,name"]).start(completionHandler: { (connection, responseObject, error) in
            if error == nil {
                let castedObject = responseObject as! [String : String]
                completionHandler(castedObject)
            }
        })
    }
    
    func signInWithGoogle()
    {
//        GIDSignIn.sharedInstance().scopes = ["https://www.googleapis.com/auth/plus.login"];
        GIDSignIn.sharedInstance().signIn()
    }
}

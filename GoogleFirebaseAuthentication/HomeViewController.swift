//
//  HomeViewController.swift
//  GoogleFirebaseAuthentication
//
//  Created by Arpit iOS Dev. on 17/06/24.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = Auth.auth().currentUser {
            print("User is signed in: \(user.email ?? "No Email")")
        } else {
            print("No user is signed in.")
        }
    }
    
    
    
}

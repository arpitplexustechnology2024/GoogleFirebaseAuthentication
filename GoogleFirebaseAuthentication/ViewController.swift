//
//  ViewController.swift
//  GoogleFirebaseAuthentication
//
//  Created by Arpit iOS Dev. on 17/06/24.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            print("Failed to retrieve Firebase client ID.")
            return
        }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
    }
    
    @IBAction func signInButtonTapped(_ sender: UIButton) {
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [unowned self] result, error in
            if let error = error {
                print("Google Sign-In failed: \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString else {
                print("Failed to retrieve Google user details.")
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print("Firebase Authentication failed: \(error.localizedDescription)")
                    return
                }
                
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "") as! HomeViewController
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
        }
    }
}


//
//  UserDefaultLogIn.swift
//  News App
//
//  Created by Madushan Senavirathna on 11/10/19.
//  Copyright © 2019 Madushan Senavirathna. All rights reserved.
//

import UIKit

class UserDefaultLogIn: UIViewController {

    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(UserDefaults.standard.dictionaryRepresentation())

        let email = UserDefaults.standard.object(forKey: "email")
        
        let password = UserDefaults.standard.object(forKey: "password")
        
        if let saveEmail = email as? String {
            userEmail.text = saveEmail
            print(userEmail.self as Any)
        }
        
        if let savePassword = password as? String {
            userPassword.text = savePassword
            print(userPassword.self as Any)
        }
        
    }
    
    @IBAction func saveProfile(_ sender: Any) {
        UserDefaults.standard.set(userEmail.text, forKey: "email")
        UserDefaults.standard.set(userPassword.text, forKey: "password")
    }
    
    @IBAction func deleteButton(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "email")
        UserDefaults.standard.removeObject(forKey: "password")
    }
    

}

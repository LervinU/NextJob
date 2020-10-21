//
//  ViewController.swift
//  NextJob
//
//  Created by Lervin Urena on 10/19/20.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var RegisterButton: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let defaults = UserDefaults.standard
        defaults.setValue("", forKey: "sessionToken")
        
    }

    @IBAction func Register(_ sender: Any) {
        performSegue(withIdentifier: "goToRegister", sender: self)
    }
    

    @IBAction func Login(_ sender: UIButton) {
        if validations() {
            let loginManager = LoginManager()
            loginManager.login(username: usernameField.text!, password: passwordField.text!)
            if let token = UserDefaults.standard.string(forKey: "sessionToken") {
            
            if token.count > 1 {
                performSegue(withIdentifier: "goToMain", sender: self)
            }
            else {
                let alert = UIAlertController(title: "Error", message: "Usuario y/o Contraseña incorrectos", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        }
    }
}
    
    func validations() -> Bool {
        var message: String

        if usernameField.text!.count < 1 || passwordField.text!.count < 1 {
            message = "Por favor, llenar campos requeridos"
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
            return false
        }
        return true
    }
}


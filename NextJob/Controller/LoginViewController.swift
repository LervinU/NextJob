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
//        let defaults = UserDefaults.standard
//        defaults.setValue("", forKey: "sessionToken")
        usernameField.delegate = self
        passwordField.delegate = self
        
    }

    @IBAction func Register(_ sender: Any) {
        performSegue(withIdentifier: "goToRegister", sender: self)
    }
    

    @IBAction func Login(_ sender: UIButton) {
        if validations() {
            let loginManager = LoginManager()
            loginManager.login(username: usernameField.text!, password: passwordField.text!) { token in
                if let safeToken = token {
                if safeToken.count > 1 {
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "goToMain", sender: self)
                    }
                }
                else {
                    let alert = UIAlertController(title: "Error", message: "Usuario y/o Contraseña incorrectos", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
            }
        }
            //sleep(1)
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

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return usernameField.resignFirstResponder() || passwordField.resignFirstResponder()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.self.endEditing(true)
    }
}

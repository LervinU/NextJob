//
//  RegisterController.swift
//  NextJob
//
//  Created by Lervin Urena on 10/20/20.
//

import UIKit


class RegisterController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var genderField: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        genderField.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        setGender()
        
    }
    
    
    @IBAction func goBack(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func Register(_ sender: UIButton) {
        if validations() {
        let registerManager = RegisterManager()
        registerManager.register(
            username: usernameField.text!,
            password: passwordField.text!,
            fullname: nameField.text!,
            email: emailField.text!,
            gender: genderField.currentTitle!)
        
        let code = registerManager.getCode();
        let message = registerManager.getMessage()
        sleep(1)
        if code != nil {
            dismiss(animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
}
    
    @IBAction func selectGender(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToGender", sender: self)
    }
    
    func getGender(data: String) {
        genderField.setTitle(data, for: .normal)
    }
    
    func validations() -> Bool {
        if nameField.text!.count < 1 || emailField.text!.count < 1 || usernameField.text!.count < 1 || passwordField.text!.count < 1 {
            message = "Por favor, llenar todos los campos"
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
            return false
        }
        return true
    }
    
    func setGender() {
        let defaults = UserDefaults.standard
        let gender = defaults.string(forKey: "gender")
        genderField.setTitle("Sexo", for: .normal)
        if gender != nil {
            genderField.setTitle(gender, for: .normal)
        }
    }

}

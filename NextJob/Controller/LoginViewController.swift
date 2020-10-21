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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    @IBAction func Register(_ sender: Any) {
        performSegue(withIdentifier: "goToRegister", sender: self)
    }
    

    @IBAction func Login(_ sender: UIButton) {
        performSegue(withIdentifier: "goToMain", sender: nil)
    }
}


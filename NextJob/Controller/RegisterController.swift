//
//  RegisterController.swift
//  NextJob
//
//  Created by Lervin Urena on 10/20/20.
//

import Foundation
import UIKit


class RegisterController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var backBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    
    @IBAction func goBack(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
}

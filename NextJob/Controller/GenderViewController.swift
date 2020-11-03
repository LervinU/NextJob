//
//  GenderViewController.swift
//  NextJob
//
//  Created by Lervin Urena on 10/22/20.
//

import UIKit

class GenderViewController: UIViewController {

    var gender: String?
    @IBOutlet weak var back: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func goBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectGender(_ sender: UIButton) {
        if sender.titleLabel?.text == "Masculino" {
            gender = "Masculino"
        } else {
            gender = "Femenino"
        }
        
        let defaults = UserDefaults.standard
        defaults.setValue(gender, forKey: "gender")
        dismiss(animated: true, completion: nil)
        //performSegue(withIdentifier: "goToRegister", sender: nil)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

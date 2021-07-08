//
//  LastPageViewController.swift
//  Practice
//
//  Created by Cypress on 7/1/21.
//

import UIKit




class LastPageViewController: UIViewController {
    
    var signInViewController: UIViewController!
    
    @IBOutlet weak var doneButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        guard let vc = storyboard?.instantiateViewController(identifier: "SignInViewController") as? SignInViewController else { return }
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}

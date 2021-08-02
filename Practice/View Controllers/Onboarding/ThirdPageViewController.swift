//
//  ThirdPageViewController.swift
//  Practice
//
//  Created by Cypress on 7/1/21.
//

import UIKit

class ThirdPageViewController: UIViewController {
    
    // MARK: - Propertries
    var labelText: NSString = "Remember: you’ll need to stay inside a zone for at least one hour to receive any Coins."
    var colorfulString = NSMutableAttributedString()
    
    // MARK: - Outlets
    @IBOutlet weak var colorfulLabel: UILabel!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        makeColorfulLabel()
    }
    
    // MARK: - Methods
    func makeColorfulLabel() {
        colorfulString = NSMutableAttributedString(string: labelText as String, attributes: [NSAttributedString.Key.font:UIFont(name: "Open Sans", size: 16.0)!])
        colorfulString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.onboardingYellow.self, range: NSRange(location:0,length:9))
        colorfulLabel.attributedText = colorfulString
    }
}

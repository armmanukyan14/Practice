//
//  ThirdPageViewController.swift
//  Practice
//
//  Created by Cypress on 7/1/21.
//

import UIKit

class ThirdPageViewController: UIViewController {
    
    
    @IBOutlet weak var colorfulLabel: UILabel!
    var myString:NSString = "Remember: you’ll need to stay inside a zone for at least one hour to receive any Coins."
    var myMutableString = NSMutableAttributedString()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedString.Key.font:UIFont(name: "Open Sans", size: 16.0)!])
        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.tripYellow.self, range: NSRange(location:0,length:9))
            colorfulLabel.attributedText = myMutableString
    }
}

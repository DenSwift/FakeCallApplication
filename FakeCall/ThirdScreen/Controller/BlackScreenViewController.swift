//
//  BlackScreenViewController.swift
//  FakeCall
//
//  Created by Денис  on 28.10.2022.
//

import UIKit

class BlackScreenViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var fakeNameLabel: UILabel!
    var textOfNameLabel: String = ""
    @IBOutlet weak var fakePhoneNumberLabel: UILabel!
    var textOfPhoneNumberLabel: String = ""
    @IBOutlet weak var timeLabel: UILabel!
    var textOfLabel: String = ""
    // Var for switch state
    var switchMode: Bool = true
    // Which display selected var
    var fakeDisplayLabel: String = ""
    // image from MainVC
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // to hide tab bar
        tabBarController?.tabBar.isHidden = true
        // to hide backBarButtonItem
        navigationItem.hidesBackButton = true
        
        fakeNameLabel.text = textOfNameLabel
        fakePhoneNumberLabel.text = textOfPhoneNumberLabel
        timeLabel.text = textOfLabel
        
        switchToCallScreenVC() // 1
    }

    // MARK: - Switch to CallScreenVC (1)
    public func switchToCallScreenVC() {
        if fakeDisplayLabel == "0" {
            var timer: Timer?
            let storyboard3 = UIStoryboard(name: "Main", bundle: nil)
            if let callSreenWithPhoto = storyboard3.instantiateViewController(withIdentifier: "CallScreenWithPhotoViewController") as? CallScreenWithPhotoViewController {
                callSreenWithPhoto.modalPresentationStyle = .overCurrentContext
                
                timer?.invalidate()
                timer = Timer.scheduledTimer(withTimeInterval: whichTimeSelected(), repeats: false, block: { _ in
                    // Pass the data to a variables in CallScreenWithPhotoVC
                    // pass data from text fields
                    callSreenWithPhoto.textOfTitle = self.downloadTextInCallScrenn()
                    // pass data from switch
                    callSreenWithPhoto.switchModeInCallScrenn = self.switchMode
                    // pass data from image view
                    callSreenWithPhoto.image = self.image
                    self.navigationController?.pushViewController(callSreenWithPhoto, animated: false)
                })
            }
        } else {
            var timer: Timer?
            let storyboard2 = UIStoryboard(name: "Main", bundle: nil)
            if let callSreenVC = storyboard2.instantiateViewController(withIdentifier: "CallScreenViewController") as? CallScreenViewController {
                callSreenVC.modalPresentationStyle = .overCurrentContext
                
                timer?.invalidate()
                timer = Timer.scheduledTimer(withTimeInterval: whichTimeSelected(), repeats: false, block: { _ in
                    // Pass the data to a variables in CallScreenVC
                    // pass data from text fields
                    callSreenVC.textOfTitle = self.downloadTextInCallScrenn()
                    // pass data from switch
                    callSreenVC.switchModeInCallScrenn = self.switchMode
                    self.navigationController?.pushViewController(callSreenVC, animated: false)
                })
            }
        }
    }

    // Passing a title to label in CallScreenVC
    public func downloadTextInCallScrenn() -> String {
        var title: String = ""
        
        if textOfNameLabel == "" && textOfPhoneNumberLabel == "" {
            title = "Unknown"
            return title
        } else if textOfNameLabel == "" {
            title = "+" + textOfPhoneNumberLabel
            return title
        } else if textOfPhoneNumberLabel == "" {
            title = textOfNameLabel
            return title
        } else {
            title = textOfNameLabel
            return title
        }
    }
    
    // Selected time from segment control
    private func whichTimeSelected() -> Double {
        if  timeLabel.text == "10 seconds" {
            return 10.0
        } else if  timeLabel.text == "30 seconds" {
            return 30.0
        } else if  timeLabel.text == "1 minute" {
            return 60.0
        } else {
            return 300.0
        }
    }
}

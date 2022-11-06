//
//  AcceptCallViewController.swift
//  FakeCall
//
//  Created by Денис  on 29.10.2022.
//

import UIKit

class AcceptCallViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    var titleLabelAcceptVC: String = ""
    @IBOutlet weak var timeLabel: UILabel!
    var timer = Timer()
    var timeSet = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // to hide tab bar
        tabBarController?.tabBar.isHidden = true
        // to hide backBarButtonItem
        navigationItem.hidesBackButton = true
        
        titleLabel.text = titleLabelAcceptVC
       
        // Timer
        timeSet += 1
        timer = Timer.scheduledTimer(timeInterval: 1.0, target:self, selector: #selector(setTimer), userInfo:nil, repeats: true)
    }
    
    @objc func setTimer() {
        let seconds = timeSet % 60
        var secondsString = "\(seconds)"
        let minutes = timeSet / 60
        var minutesString = "\(minutes)"
        
        if seconds < 10 && seconds >= 0 {
            secondsString = "0\(seconds)"
        } else if seconds < 0 {
            timer.invalidate()
        }
        
        if minutes < 10 {
            minutesString = "0\(minutes)"
        }
        
        timeLabel.text = "\(minutesString):\(secondsString)"
        timeSet += 1
    }
    
    //MARK: - IBAction
    @IBAction func declineButton(_ sender: UIButton) {
        // Switch to firstVC
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let firstVC = storyboard.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController {
            firstVC.modalPresentationStyle = .overCurrentContext
            // to show tab bar in mainController
            self.tabBarController?.tabBar.isHidden = false
            self.navigationController?.setViewControllers([firstVC], animated: false)
        }
    }
}

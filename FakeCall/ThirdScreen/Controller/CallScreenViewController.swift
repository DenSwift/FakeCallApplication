//
//  CallScreenViewController.swift
//  FakeCall
//
//  Created by Денис  on 28.10.2022.
//

import UIKit
import AVFoundation

class CallScreenViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var titleLabel: UILabel!
    var textOfTitle: String = ""
    // Var for switch state
    var switchModeInCallScrenn: Bool = true
    // Audio player
    private var audioPlayer = AVAudioPlayer()
    // Download mp3
    var downloadAudio = DownloadMP3()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // to hide tab bar
        tabBarController?.tabBar.isHidden = true
        // to hide backBarButtonItem
        navigationItem.hidesBackButton = true
 
        titleLabel.text = textOfTitle
        
        pathToSound() // 1
    }

    // Path to mp3 files (1)
    private func pathToSound() {
        downloadAudio.pathToSound(sender: switchModeInCallScrenn, player: &audioPlayer)
    }
    
    // MARK: - IBActions
    @IBAction func declineButton(_ sender: UIButton) {
        audioPlayer.stop()
        // Switch to first screen
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let firstVc = storyboard.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController {
            firstVc.modalPresentationStyle = .overCurrentContext
            // to show tab bar in mainController
            self.tabBarController?.tabBar.isHidden = false
            self.navigationController?.setViewControllers([firstVc], animated: false)
        }
    }
   
    @IBAction func acceptButton(_ sender: UIButton) {
        audioPlayer.stop()
        // Switch to accept call screen
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let fourthVC = storyboard.instantiateViewController(withIdentifier: "AcceptCallViewController") as? AcceptCallViewController {
            fourthVC.modalPresentationStyle = .overCurrentContext
            fourthVC.titleLabelAcceptVC = textOfTitle
            self.navigationController?.pushViewController(fourthVC, animated: false)
        }
    }
}

//
//  CallScreenWithPhotoViewController.swift
//  FakeCall
//
//  Created by Денис  on 31.10.2022.
//

import UIKit
import AVFoundation

class CallScreenWithPhotoViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    var image: UIImage?
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
        imageView.image = image
        
        pathToSound() // 1
        settingsForImageView() // 2
    }
   
    // Path to mp3 files (1)
    private func pathToSound() {
        downloadAudio.pathToSound(sender: switchModeInCallScrenn, player: &audioPlayer)
    }
    
    // UISettings for imageView (2)
    private func settingsForImageView() {
        imageView.layer.cornerRadius = 40
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.systemOrange.cgColor
    }
    
    // MARK: - IBActions
    @IBAction func declineAction(_ sender: UIButton) {
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
    
    @IBAction func acceptAction(_ sender: UIButton) {
        audioPlayer.stop()
        // Switch to accept call screen
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let fourthVC = storyboard.instantiateViewController(withIdentifier: "AcceptCallWithPhotoVCViewController") as? AcceptCallWithPhotoVCViewController {
            fourthVC.modalPresentationStyle = .overCurrentContext
            fourthVC.titleLabelVC = textOfTitle
            fourthVC.image = image
            self.navigationController?.pushViewController(fourthVC, animated: false)
        }
    }
}

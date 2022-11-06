//
//  ViewController.swift
//  FakeCall
//
//  Created by Денис  on 27.10.2022.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var downloadImageButtonOutlet: UIButton!
    @IBOutlet weak var scheduleCallButtonOutlet: UIButton!
    @IBOutlet weak var timeSegmentControl: UISegmentedControl!
    @IBOutlet weak var silentModeSwitch: UISwitch!
    @IBOutlet weak var displayWithoutPhotoImageView: UIImageView!
    @IBOutlet weak var displayWithPhotoImageView: UIImageView!
    @IBOutlet weak var dipslayWithoutPhotoButton: UIButton!
    @IBOutlet weak var dipslayWithPhotoButton: UIButton!
    @IBOutlet weak var displayLabel: UILabel!
    // var for download users images
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // TextField Delegate
        nameTextField.delegate = self
        phoneNumberTextField.delegate = self
        
        settingsForImageView() // 1
        settingsForDownloadImageButton() // 2
        settingsForScheduleCallButton() // 3
        settingsForDisplaysImageViews() // 4
    }

    // UISettings for ImageView (1)
    private func settingsForImageView() {
        imageView.layer.cornerRadius = 45
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.systemGray6.cgColor
    }
    
    // UISettings for DownloadButton (2)
    private func settingsForDownloadImageButton() {
        downloadImageButtonOutlet.layer.cornerRadius = 12
        downloadImageButtonOutlet.layer.borderWidth = 0.5
        downloadImageButtonOutlet.layer.borderColor = UIColor.black.cgColor
    }
    
    // UISettings for ScheduleCallButton (3)
    private func settingsForScheduleCallButton() {
        scheduleCallButtonOutlet.layer.cornerRadius = 18
        scheduleCallButtonOutlet.layer.borderWidth = 2
        scheduleCallButtonOutlet.layer.borderColor = UIColor.red.cgColor
    }
    
    // UISettings for ImageView (4)
    private func settingsForDisplaysImageViews() {
        displayWithoutPhotoImageView.layer.cornerRadius = 50
        displayWithoutPhotoImageView.layer.borderWidth = 4
        displayWithoutPhotoImageView.layer.borderColor = UIColor.red.cgColor
        dipslayWithoutPhotoButton.layer.cornerRadius = 50

        displayWithPhotoImageView.layer.cornerRadius = 50
        displayWithPhotoImageView.layer.borderWidth = 4
        displayWithPhotoImageView.layer.borderColor = UIColor.red.cgColor
        dipslayWithPhotoButton.layer.cornerRadius = 50
    }
    
    // MARK: - IBActions
    @IBAction func downloadImageButton(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    // Display with photo action
    @IBAction func displayWithPhoto(_ sender: UIButton) {
        displayLabel.text = "0"
    }
    
    // Display without photo action
    @IBAction func displayWithoutPhoto(_ sender: UIButton) {
        displayLabel.text = "1"
    }
    
    // MARK: - Function for highlighting and UISettings for textFields
    @IBAction func changingTextFields(_ sender: UITextField) {
        nameTextField.tag = 1
        phoneNumberTextField.tag = 2
        
        if sender.tag == 2 {
            nameTextField.layer.borderColor = UIColor.systemGray6.cgColor
            phoneNumberTextField.layer.cornerRadius = 8
            phoneNumberTextField.layer.borderWidth = 0.7
            phoneNumberTextField.layer.borderColor = UIColor.red.cgColor
        } else if sender.tag == 1 {
            phoneNumberTextField.layer.borderColor = UIColor.systemGray6.cgColor
            nameTextField.layer.cornerRadius = 8
            nameTextField.layer.borderWidth = 0.7
            nameTextField.layer.borderColor = UIColor.red.cgColor
            
        }
    }
    
    @IBAction func scheduleCallButton(_ sender: UIButton) {
        
        let attributedStringForTitle = NSAttributedString(string: "The phone will ring in \(whichTimeSelected(segment: timeSegmentControl)). Don't close the app!", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17), NSAttributedString.Key.foregroundColor: UIColor.black])
        let alert = UIAlertController(title: "", message: nil, preferredStyle: .alert)
        alert.setValue(attributedStringForTitle, forKey: "attributedTitle")
        let alertAction = UIAlertAction(title: "OK", style: .default) { _ in
            // Switch to BlackScrennVC
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let blackScreenVC = storyboard.instantiateViewController(withIdentifier: "BlackScreenViewController") as? BlackScreenViewController {
                blackScreenVC.modalPresentationStyle = .overCurrentContext
                // Pass the data to a variables in BlackScreenVC
                // pass data from segmnet control
                blackScreenVC.textOfLabel = self.whichTimeSelected(segment: self.timeSegmentControl)
                // pass data from text fields
                blackScreenVC.textOfNameLabel = self.nameTextField.text ?? ""
                blackScreenVC.textOfPhoneNumberLabel = self.phoneNumberTextField.text ?? ""
                // pass data from switch
                blackScreenVC.switchMode = self.transferStateSwitchToBlackScreen(self.silentModeSwitch)
                // pass data from display label
                blackScreenVC.fakeDisplayLabel = self.displayLabel.text ?? ""
                // pass data from image view
                blackScreenVC.image = self.imageView.image
                self.navigationController?.pushViewController(blackScreenVC, animated: false)
            }
        }
        alert.addAction(alertAction)
        self.present(alert, animated: true)
    }
    
    @IBAction func saveContact(_ sender: UIBarButtonItem) {
        
        let userName = downloadTextInCallScrenn()
        let userImage = imageView.image
        
        // create a Contact
        let contact = Contact(title: userName, imageName: userImage!)

        // append it to shared data in the data manager singleton
        MyContactData.shared.myContacts.append(contact)

        nameTextField.text = ""
        imageView.image = UIImage(named: "unknownUser")
    }
    
    // Passing a title to label in HistoryTableVC
    private func downloadTextInCallScrenn() -> String {
        var title: String = ""
        
        if nameTextField.text == "" && phoneNumberTextField.text == "" {
            title = "Unknown"
            return title
        } else if nameTextField.text == "" {
            title = "+" + phoneNumberTextField.text!
            return title
        } else if phoneNumberTextField.text == "" {
            title = nameTextField.text!
            return title
        } else {
            title = nameTextField.text!
            return title
        }
    }
    
    // Selected switch mode
    private func transferStateSwitchToBlackScreen(_ sender: UISwitch) -> Bool {
        if sender.isOn {
            return true
        } else {
            return false
        }
    }
    
    // Selected time from segmnet control
    private func whichTimeSelected(segment: UISegmentedControl) -> String {
        if segment.selectedSegmentIndex == 0 {
            return "10 seconds"
        } else if segment.selectedSegmentIndex == 1 {
            return "30 seconds"
        } else if segment.selectedSegmentIndex == 2 {
            return "1 minute"
        } else {
            return "5 minute"
        }
    }
}
extension MainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        phoneNumberTextField.becomeFirstResponder()
    }
}

extension MainViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = image
        }
    }
}




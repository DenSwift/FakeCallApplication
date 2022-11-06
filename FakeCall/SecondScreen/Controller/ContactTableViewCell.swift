//
//  ContactTableViewCell.swift
//  FakeCall
//
//  Created by Денис  on 03.11.2022.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    
    // IBOutlets
    @IBOutlet weak var contactPhotoimaveView: UIImageView!
    @IBOutlet weak var titleContactLabel: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()

        settingsForImageView()
    }
    
    private func settingsForImageView() {
        contactPhotoimaveView.layer.cornerRadius = 25
        contactPhotoimaveView.layer.borderWidth = 1
        contactPhotoimaveView.layer.borderColor = UIColor.systemGray6.cgColor
    }
}

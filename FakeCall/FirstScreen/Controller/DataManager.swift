//
//  DataManager.swift
//  FakeCall
//
//  Created by Денис  on 04.11.2022.
//

import Foundation
import UIKit

class MyContactData {
    
   var myContacts: [Contact] = []
    
    static let shared: MyContactData = {
        let instance = MyContactData()
        // setup code
        return instance
    }()
}

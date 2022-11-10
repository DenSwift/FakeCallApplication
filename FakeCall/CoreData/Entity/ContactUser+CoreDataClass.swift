//
//  ContactUser+CoreDataClass.swift
//  FakeCall
//
//  Created by Денис  on 09.11.2022.
//
//

import Foundation
import CoreData

@objc(ContactUser)
public class ContactUser: NSManagedObject {
    
    convenience init() {
        self.init(entity: CoreDataManager.shared.entityForName(entityName: "ContactUser"), insertInto: CoreDataManager.shared.context)
    }
}

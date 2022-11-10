//
//  ContactUser+CoreDataProperties.swift
//  FakeCall
//
//  Created by Денис  on 09.11.2022.
//
//

import Foundation
import CoreData


extension ContactUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ContactUser> {
        return NSFetchRequest<ContactUser>(entityName: "ContactUser")
    }

    @NSManaged public var title: String?
    @NSManaged public var userImage: Data?
    
}

extension ContactUser : Identifiable {
    
}

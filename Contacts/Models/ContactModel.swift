//
//  ContactModel.swift
//  Contacts
//
//  Created by Yana on 17.07.2020.
//  Copyright © 2020 YanaInc. All rights reserved.
//

import RealmSwift

class Contact: Object {
    
    @objc dynamic var name = ""
    @objc dynamic var phoneNumber = ""
    @objc dynamic var email: String?
    @objc dynamic var imageData: Data?
    
    convenience init (name: String, phoneNumber: String, email: String?, imageData: Data?) {
        
        self.init()
        self.name = name
        self.phoneNumber = phoneNumber
        self.email = email
        self.imageData = imageData
    }
    
}

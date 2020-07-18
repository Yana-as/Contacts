//
//  StorageManager.swift
//  Contacts
//
//  Created by Yana on 16.07.2020.
//  Copyright © 2020 YanaInc. All rights reserved.
//
import RealmSwift

let realm = try! Realm()

class StorageManager {
    
    static func saveObject(_ contact: Contact) {
        
        try! realm.write{
            realm.add(contact)
        }
    }
    
    static func deleteObject (_ contact: Contact) {
        
        try! realm.write{
            realm.delete(contact)
        }
    }
}

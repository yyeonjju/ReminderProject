//
//  RealmDBRepository.swift
//  ReminderProject
//
//  Created by 하연주 on 7/6/24.
//

import Foundation
import RealmSwift


final class RealmDBRepository<T : Object> {
    private let realm = try! Realm()
    
    func checkFileURL() {
        print("fileURL -> ", realm.configuration.fileURL)
    }
    
    func checkSchemaVersion() {
        do {
            let version = try schemaVersionAtURL(realm.configuration.fileURL!)
            print("version -> ",version)
        }catch {
            print(error)
        }
    }
    
    func createItem(_ data : T) {
        do {
            try realm.write{
                realm.add(data)
                print("Realm Create Succeed")
            }
        } catch {
            print(error)
        }
    }
    
    
    func getAllObjects<M : Object>(tableModel : M.Type) -> Results<M> {
        let value =  realm.objects(M.self)
        return value
    }
    
    func removeItem(_ data : T) {
        do {
            try realm.write {
                realm.delete(data)
            }
        }catch {
            print(error)
        }
    }
    
    func editItem<M : Object>(_ data : M.Type, at id : ObjectId ,editKey : String, to editValue : Any) {
        do {
            try realm.write{
                realm.create(
                    M.self,
                    value: [
                        "id" : id, //수정할 컬럼
                        editKey : editValue
                    ],
                    update: .modified
                )
            }
        }catch {
            print(error)
        }
        
    }
    
}


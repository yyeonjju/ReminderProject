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
    
    
    
    //특정 행 수정 : create
//    try! realm.write{
//        realm.create(
//            ConsumptionDiaryTable.self,
//            value: [
//                "id" : data.id, //수정할 컬럼
//                "money" : 111111
//            ], // 이걸로 수정해줘라
//            update: .modified
//        ) // 기존 데이터 수정
//    }
    
    
}


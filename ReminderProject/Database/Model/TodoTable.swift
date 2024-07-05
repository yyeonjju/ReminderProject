//
//  TodoTable.swift
//  ReminderProject
//
//  Created by 하연주 on 7/3/24.
//

import Foundation
import RealmSwift

class TodoTable: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String
    @Persisted var memo: String?
    @Persisted var expirationDate: Date?
    @Persisted var tag: String?
    @Persisted var priority: Int?
    @Persisted var image: Data?
    
    //tag -> String? -> [String]?
    
    //regDate : Date
    //isCompleted : Bool
    //isLiked : Bool
    //isFlaged : Bool
    //isPinned : Bool
    
    convenience init(title: String,memo: String?, expirationDate: Date?, tag: String?, priority: Int?, image: Data?) {
       self.init()
        self.title = title
        self.memo = memo
        self.expirationDate = expirationDate
        self.tag = tag
        self.priority = priority
        self.image = image
   }
}


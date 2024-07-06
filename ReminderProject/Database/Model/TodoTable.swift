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
    @Persisted var tag: String? //❌(안씀. tags로 기능 수정)
    @Persisted var priority: Int?
    @Persisted var image: Data? //❌(안씀. fileManager에 저장)
    
    @Persisted var tags: List<String>
    @Persisted var registerDate: Date
    @Persisted var isCompleted: Bool
    @Persisted var isLiked: Bool
    @Persisted var isFlaged: Bool
    @Persisted var isPinned: Bool
    
    convenience init(title: String, memo: String?, expirationDate: Date?, tag: String?, priority: Int?, image: Data?, tags: List<String>, registerDate: Date, isCompleted: Bool, isLiked: Bool, isFlaged: Bool, isPinned: Bool) {
        self.init()
        self.title = title
        self.memo = memo
        self.expirationDate = expirationDate
        self.tag = tag
        self.priority = priority
        self.image = image
        self.tags = tags
        self.registerDate = registerDate
        self.isCompleted = isCompleted
        self.isLiked = isLiked
        self.isFlaged = isFlaged
        self.isPinned = isPinned
    }
    
    
}


//
//  UtilFunc.swift
//  ReminderProject
//
//  Created by 하연주 on 7/3/24.
//

import UIKit

func isOnlyWhitespace(_ text: String?) -> Bool {
    guard let text else {return true}
    return text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
}

func configureCollectionVewLayout (numberofItemInrow : Int, cellIneterSpacing : CGFloat = 10, sectionSpacing :  CGFloat = 30, height: CGFloat? = nil) -> UICollectionViewLayout{
    let layout = UICollectionViewFlowLayout()
    let numberofItemInrow : CGFloat = CGFloat(numberofItemInrow)
    
    let cellIneterSpacing : CGFloat = cellIneterSpacing
    let sectionSpacing : CGFloat = sectionSpacing
    let inset = UIEdgeInsets(top: sectionSpacing, left: sectionSpacing, bottom: sectionSpacing, right: sectionSpacing)
    let availableWidth = UIScreen.main.bounds.width - (cellIneterSpacing*numberofItemInrow) - inset.left - inset.right
    
    
    layout.itemSize = CGSize(width: availableWidth/numberofItemInrow, height: height ?? availableWidth/numberofItemInrow)
    layout.scrollDirection = .vertical
    layout.minimumLineSpacing = 10
    layout.minimumInteritemSpacing = cellIneterSpacing
    layout.sectionInset = inset
    
    return layout
}

func returnTodayDateRange(for date : Date) -> ClosedRange<Date> {
    let calendar = Calendar.current
    // 오늘 00시
    let startOfDay = calendar.startOfDay(for: date)
    // 내일 00시에서 1초를 빼서 오늘 24시를 구함
    let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)?.addingTimeInterval(-1)
    return (startOfDay...endOfDay!)
}

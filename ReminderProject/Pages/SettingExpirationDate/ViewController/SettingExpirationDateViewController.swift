//
//  SettingExpirationDateViewController.swift
//  ReminderProject
//
//  Created by 하연주 on 7/5/24.
//

import UIKit
import FSCalendar

final class SettingDateViewController : UIViewController, PassDataDelegatePropertyProtocol  {
    
    // MARK: - UI
    let viewManager = SettingDateView()
    
    // MARK: - Properties
    var delegate: ObserveDataDelegate?
    
    // MARK: - Lifecycle
    override func loadView() {
        view = viewManager
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCalendar()
        setupAddTarget()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        guard let delegate else {return }
        delegate.observeNextPageData(data: viewManager.calendar.selectedDates.first as Date?)
    }
    
    // MARK: - SetupDelegate
    private func setupCalendar() {
        viewManager.calendar.delegate = self
        
        viewManager.calendar.select(Date(), scrollToDate: true)
        viewManager.calendarDateLabel.text = DateFormatter.getDateFormatter(format: .yearDotMonth).string(from: Date())
        
    }
    
    
    // MARK: - AddTarget
    private func setupAddTarget() {
        viewManager.previousButton.addTarget(self, action: #selector(prevCurrentPage), for: .touchUpInside)
        viewManager.nextButton.addTarget(self, action: #selector(nextCurrentPage), for: .touchUpInside)
    }
    
    // MARK: - EventSelector
    
    // 이전 달로 이동 함수
    @objc private func prevCurrentPage() {
        // 이전 달로 달력 전환
        //viewManager.calendar.currentPage에서 -1 한 월로 이동
        guard let previousDate =
                Calendar.current.date(
                    byAdding: .month,
                    value: -1,
                    to: viewManager.calendar.currentPage) else { return }
        viewManager.calendar.setCurrentPage(previousDate, animated: true)

    }
    
    
    // 다음 달로 이동 함수
    @objc private func nextCurrentPage() {
        // 다음 달로 달력 전환
        //viewManager.calendar.currentPage에서 +1 한 월로 이동
        guard let nextDate =
                Calendar.current.date(
                    byAdding: .month,
                    value: 1,
                    to: viewManager.calendar.currentPage) else { return }
        viewManager.calendar.setCurrentPage(nextDate, animated: true)

    }
    
    
    // MARK: - SetupUI
    // MARK: - APIFetch
    // MARK: - PageTransition
}


extension SettingDateViewController : FSCalendarDelegate {
    
    /// 캘린더 달이 변경될 때마다 호출되는 메서드
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        let currentDate = calendar.currentPage

        viewManager.calendarDateLabel.text = DateFormatter.getDateFormatter(format: .yearDotMonth).string(from: currentDate)
        viewManager.calendar.select(currentDate, scrollToDate: true)
        
    }
    


}

//
//  RealSettingViewController.swift
//  TimerZandi
//
//  Created by 이주송 on 2022/07/14.
//

import UIKit
import FSCalendar

class RealSettingViewController: UIViewController {

    @IBOutlet weak var calendar: FSCalendar!
    
    @IBOutlet weak var disturbCount: UILabel!
    @IBOutlet weak var sumOfTime: UILabel!
    
    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.delegate = self
        calendar.dataSource = self
        
        self.calendarColor()
        self.languageSet()
        self.fontSize()
        self.calendar.appearance.borderRadius = 0.5
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        let sumTime = UserDefaults.standard.integer(forKey: sumTime)
        
        self.disturbCount.text = String(UserDefaults.standard.integer(forKey: countTime)) + " 회"
        self.sumOfTime.text = String(sumTime) + " 초"
        
        if sumTime < 5 && sumTime > 0{
            calendar.appearance.todayColor = UIColor(red: 155/255, green: 233/255, blue: 168/255, alpha: 1.00)
        } else if sumTime >= 5 && sumTime < 10 {
            calendar.appearance.todayColor = UIColor(red: 64/255, green: 196/255, blue: 99/255, alpha: 1.00)
        } else if sumTime >= 10 && sumTime < 15 {
            calendar.appearance.todayColor = UIColor(red: 48/255, green: 161/255, blue: 78/255, alpha: 1.00)
        } else if sumTime >= 15 {
            calendar.appearance.todayColor = UIColor(red: 33/255, green: 110/255, blue: 57/255, alpha: 1.00)
        } else {
            calendar.appearance.todayColor = .lightGray
        }
        
        calendar.cornerRadius = 15
        
    } // 지정한 날의 색 변경
    
    @IBAction func reLoadButton(_ sender: Any) {
            debugPrint("새로고침합니다.")
    }

    
    func fontSize() {
        // 헤더 폰트 설정
        calendar.appearance.headerTitleFont = UIFont(name: "NotoSansKR-Medium", size: 16)

        // Weekday 폰트 설정
        calendar.appearance.weekdayFont = UIFont(name: "NotoSansKR-Regular", size: 14)

        // 각각의 일(날짜) 폰트 설정 (ex. 1 2 3 4 5 6 ...)
        calendar.appearance.titleFont = UIFont(name: "NotoSansKR-Regular", size: 14)
    }
    
    func calendarColor() {

        // 달력의 평일 날짜 색깔
        calendar.appearance.titleDefaultColor = .black

        // 달력의 토,일 날짜 색깔
        calendar.appearance.titleWeekendColor = .red

        calendar.appearance.headerTitleColor =  UIColor.init(red: 95/256, green: 127/256, blue: 35/256, alpha: 1)
        
        // 달력의 맨 위의 년도, 월의 색깔
        calendar.appearance.weekdayTextColor = UIColor.init(red: 224/256, green: 236/256, blue: 212/256, alpha: 1)

        // 달력의 요일 글자 색깔
        calendar.appearance.weekdayTextColor = .black
        
        
    }
    
    func languageSet() {
        // 달력의 년월 글자 바꾸기
        calendar.appearance.headerDateFormat = "YYYY년 M월"

        // 달력의 요일 글자 바꾸는 방법 1
        calendar.locale = Locale(identifier: "ko_KR")
                
        // 달력의 요일 글자 바꾸는 방법 2
        calendar.calendarWeekdayView.weekdayLabels[0].text = "일"
        calendar.calendarWeekdayView.weekdayLabels[1].text = "월"
        calendar.calendarWeekdayView.weekdayLabels[2].text = "화"
        calendar.calendarWeekdayView.weekdayLabels[3].text = "수"
        calendar.calendarWeekdayView.weekdayLabels[4].text = "목"
        calendar.calendarWeekdayView.weekdayLabels[5].text = "금"
        calendar.calendarWeekdayView.weekdayLabels[6].text = "토"
    }

}

// 터치이벤트

extension RealSettingViewController : FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {

    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(dateFormatter.string(from: date) + " 선택")
        self.disturbCount.text = String(UserDefaults.standard.integer(forKey: countTime)) + " 회"
        self.sumOfTime.text = String(UserDefaults.standard.integer(forKey: sumTime)) + " 초"
    }
    // 날짜 선택 해제 시 콜백 메소드
    public func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(dateFormatter.string(from: date) + " 선택 해제")
        debugPrint()
    }
    
    // 선택된 날짜의 채워진 색상 지정 -> 지금은 기본색이지만 공부시간에 따라 색 바뀌게 (조건문)
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
        return appearance.selectionColor
    
    }

    // 선택된 날짜 테두리 색상
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, borderSelectionColorFor date: Date) -> UIColor? {
        return UIColor.white.withAlphaComponent(1.0)
    }
    
}

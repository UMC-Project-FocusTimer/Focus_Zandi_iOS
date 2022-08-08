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
    let matchDateForZandi = DateFormatter()
    let nowDate = Date()
    var eventsArray:[String] = []
    
    @IBOutlet weak var sumOfThisMonth: UILabel!
    
    @IBOutlet weak var numberOfFollwers: UILabel!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var memo: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        matchDateForZandi.dateFormat = "yyyy-MM-dd"
        let str = matchDateForZandi.string(from: nowDate)
        print(str)
        
        
        calendar.delegate = self
        calendar.dataSource = self
        
        getShowMember(accessToken: accessToken, refToken: refToken,onCompleted: {
            [weak self] result in // 순환 참조 방지, 전달인자로 result
            guard let self = self else { return } // 일시적으로 strong ref가 되게
     
            switch result {
            case let .success(result):
                

                
                DispatchQueue.main.async {
                    self.fullName.text = result.fullName
                    self.memo.text = result.memo
                    self.numberOfFollwers.text = String(result.numberOfFollowers)
                }
                
            case let .failure(error):
                debugPrint("error \(error)")
            }
        })
        
        // 특정날짜 존재하면 그 날짜 색 변경
        
        getMonthRecords(accessToken: accessToken, refToken: refToken, onCompleted: {
            [weak self] result in // 순환 참조 방지, 전달인자로 result
            guard let self = self else { return } // 일시적으로 strong ref가 되게
     
            switch result {
            case let .success(result):
                
            self.eventsArray = result.monthRecord.map({ $0.date })
            print(self.eventsArray)
                
                
                
                let sumMonth = result.monthRecord.compactMap{
                    $0.concentratedTime // monthRecord[] 내 각 요소의 .concentratedTime Key를 뽑은후 , reduce를 이용해 0부터 끝까지 그 값을 더한다!
                }.reduce(0, { (first: Int, second: Int) -> Int in
                    return first + second
                })
         

                
                DispatchQueue.main.async {
                    self.sumOfThisMonth.text = String(sumMonth)
                    self.sumOfTime.text = String(result.monthRecord.last?.concentratedTime ?? 0)
                    self.disturbCount.text = String(result.monthRecord.last?.brokenCount ?? 0)
                }
                
            case let .failure(error):
                debugPrint("error \(error)")
            }
        })
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        var THEME_KEY = UserDefaults.standard.integer(forKey: "THEME_KEY")

        print(THEME_KEY)
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
        
        self.calendarColor()
        self.languageSet()
        self.fontSize()
        self.calendar.appearance.borderRadius = 0.5
        if THEME_KEY != 0 {
        calendar.backgroundColor = themes[THEME_KEY][0]
        // UIColor(red: 0.962, green: 0.832, blue: 0.832, alpha: 1)
        } else {
        calendar.backgroundColor = themes[8][0]
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

        calendar.appearance.headerTitleColor =  .black
        
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

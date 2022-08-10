//
//  FollwersPageViewController.swift
//  TimerZandi
//
//  Created by 이주송 on 2022/07/29.
//

import UIKit
import FSCalendar

class FollwersPageViewController: UIViewController {

    var follwerDataModel = FollwerDataModel ()
    
    @IBOutlet weak var calendar: FSCalendar!
    
    let dateFormatter = DateFormatter()

    @IBOutlet weak var imgae: UIImageView!
    @IBOutlet weak var numberOfFollwer: UILabel!
    @IBOutlet weak var focusTimeForThisMonth: UILabel!
    @IBOutlet weak var followeName: UILabel!
    var name: String?
    @IBOutlet weak var follwerDesciption: UILabel!
    @IBOutlet weak var todayFocusTime: UILabel!
    @IBOutlet weak var brokenCount: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.delegate = self
        calendar.dataSource = self
        
        self.calendarColor()
        self.languageSet()
        self.fontSize()
        self.calendar.appearance.borderRadius = 0.5
        
        if let codePushName = name {
                 self.followeName.text = codePushName
             }
        
    }

    func getInfoFromModel() {
        let selectedIndex = UserDefaults.standard.integer(forKey: "SELECTED")
        print(selectedIndex)

        let image = follwerDataModel.getImage(index: selectedIndex)
        let numberOfFollower = follwerDataModel.getNumberOfFollower(index: selectedIndex)
        let focusTimeForThisMonth = follwerDataModel.getTodayFocusTime(index: selectedIndex)
        let followeName = follwerDataModel.getFolloweName(index: selectedIndex)
        let follwerDesciption = follwerDataModel.getFollwerDesciption(index: selectedIndex)
        let todayFocusTime = follwerDataModel.getTodayFocusTime(index: selectedIndex)
        let brokenCount = follwerDataModel.getBrokenCount(index: selectedIndex)
        
        self.imgae.image = UIImage(named: image)
        self.numberOfFollwer.text = String(numberOfFollower)
        self.focusTimeForThisMonth.text = String(focusTimeForThisMonth)
        self.followeName.text = followeName
        self.follwerDesciption.text = follwerDesciption
        self.todayFocusTime.text = String(todayFocusTime)
        self.brokenCount.text = String(brokenCount)
    }
    
    override func viewWillAppear(_ animated: Bool) {
   
        self.navigationController?.navigationBar.prefersLargeTitles = false
//        self.getInfoFromModel()
        
        var THEME_KEY = UserDefaults.standard.integer(forKey: "THEME_KEY")

        if THEME_KEY != 0 {
        calendar.backgroundColor = themes[THEME_KEY][0]
        // UIColor(red: 0.962, green: 0.832, blue: 0.832, alpha: 1)
        } else {
        calendar.backgroundColor = themes[8][0]
        }
    }
    
    
//

    

//    @objc func test(_ notification:NSNotification){
//        print("it`s")
//        guard let image = notification.userInfo!["image"] as? String else {return}
//        guard let numberOfFollower = notification.userInfo!["numberOfFollower"] as? Int else {return}
//        guard let focusTimeForThisMonth = notification.userInfo!["focusTimeForThisMonth"] as? Int else {return}
//        guard let followeName = notification.userInfo!["followeName"] as? String else {return}
//        guard let follwerDesciption = notification.userInfo!["follwerDesciption"] as? String else {return}
//        guard let todayFocusTime = notification.userInfo!["todayFocusTime"] as? Int else {return}
//        guard let brokenCount = notification.userInfo!["brokenCount"] as? Int else {return}
//        
//        print(brokenCount)
//        self.follwerDataModel.inputData(image: image, numberOfFollower: numberOfFollower, focusTimeForThisMonth: focusTimeForThisMonth, followeName: followeName, follwerDesciption: follwerDesciption, todayFocusTime: todayFocusTime, brokenCount: brokenCount)
//        
//    }
    
    
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
        self.calendar.appearance.titleDefaultColor = .black

        // 달력의 토,일 날짜 색깔
        self.calendar.appearance.titleWeekendColor = .red

        self.calendar.appearance.headerTitleColor = .black
        // 달력의 맨 위의 년도, 월의 색깔
        self.calendar.appearance.weekdayTextColor = UIColor.init(red: 224/256, green: 236/256, blue: 212/256, alpha: 1)

        // 달력의 요일 글자 색깔
        self.calendar.appearance.weekdayTextColor = .black
        
        calendar.cornerRadius = 15

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
    @IBAction func tapBackButton(_ sender: Any) {
        UserDefaults.standard.setValue(0, forKey: "SELECTED")
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension FollwersPageViewController : FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {

    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(dateFormatter.string(from: date) + " 선택")
//        self.disturbCount.text = String(UserDefaults.standard.integer(forKey: countTime)) + " 회"
//        self.sumOfTime.text = String(UserDefaults.standard.integer(forKey: sumTime)) + " 초"
    }
    // 날짜 선택 해제 시 콜백 메소드
    public func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(dateFormatter.string(from: date) + " 선택 해제")
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


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
    
    @IBOutlet weak var imgae: UIImageView!
    @IBOutlet weak var numberOfFollwer: UILabel!
    @IBOutlet weak var focusTimeForThisMonth: UILabel!
    @IBOutlet weak var followeName: UILabel!
    @IBOutlet weak var follwerDesciption: UILabel!
    @IBOutlet weak var todayFocusTime: UILabel!
    @IBOutlet weak var brokenCount: UILabel!

    var Image:String?
    var NumberOfFollower:Int?
    var FocusTimeForThisMonth:Int?
    var FolloweName:String?
    var FollwerDesciption:String?
    var TodayFocusTime:Int?
    var BrokenCount:Int?
    
    var dates:[Date] = []
    
    var eventsArray:[String]? = []
    var zandiArray:[Int]? = []
    
    var newEventsArray:[String] = []
    var newZandiArray:[Int] = []
    
    let dateFormatter = DateFormatter()
    let matchDateForZandi = DateFormatter()
    let nowDate = Date()
    
    var day_5_dpeth:[Date] = []
    var day_4_dpeth:[Date] = []
    var day_3_dpeth:[Date] = []
    var day_2_dpeth:[Date] = []
    var day_1_dpeth:[Date] = []

          

    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.delegate = self
        calendar.dataSource = self
        
        let matchDateForZandi = DateFormatter()
        matchDateForZandi.locale = Locale(identifier: "ko_KR")
        matchDateForZandi.dateFormat = "yyyy-MM-dd"
               
         let xmas = matchDateForZandi.date(from: "2022-12-25")
         let sampledate = matchDateForZandi.date(from: "2022-12-22")
        self.dates = [xmas!, sampledate!]
        
        self.calendarColor()
        self.languageSet()
        self.fontSize()
        self.calendar.appearance.borderRadius = 0.5
        
        calendar.appearance.eventDefaultColor = UIColor.green
        calendar.appearance.eventSelectionColor = UIColor.green
        
    }

    func getInfoFromModel() {
        let selectedIndex = UserDefaults.standard.integer(forKey: "SELECTED")
        print(selectedIndex)
    }
    
    override func viewWillAppear(_ animated: Bool) {
   
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.getInfoFromModel()
        
        var THEME_KEY = UserDefaults.standard.integer(forKey: "THEME_KEY")

        if THEME_KEY != 0 {
        calendar.backgroundColor = themes[THEME_KEY][0]
        // UIColor(red: 0.962, green: 0.832, blue: 0.832, alpha: 1)
        } else {
        calendar.backgroundColor = themes[8][0]
        }
        
        if let FolloweName = FolloweName, let Image = Image, let NumberOfFollower = NumberOfFollower, let FocusTimeForThisMonth = FocusTimeForThisMonth, let FollwerDesciption = FollwerDesciption, let TodayFocusTime = TodayFocusTime, let BrokenCount = BrokenCount, let eventsArray = eventsArray, let zandiArray = zandiArray
        {
            self.followeName.text = FolloweName
            self.imgae.image = UIImage(named: Image)
            self.numberOfFollwer.text = String(NumberOfFollower)
            self.focusTimeForThisMonth.text = String(FocusTimeForThisMonth)
            self.follwerDesciption.text = FollwerDesciption
            self.todayFocusTime.text = String(TodayFocusTime)
            self.brokenCount.text = String(BrokenCount)
    
            self.newEventsArray = self.eventsArray!
            self.newZandiArray = self.zandiArray!

                if self.newEventsArray.count > 0 {
                    for i in 0...self.newEventsArray.count - 1{
                        self.dates.append(self.matchDateForZandi.date(from: self.newEventsArray[i] ?? "") ?? self.nowDate )
                        
                        if self.newZandiArray[i] > 800 && self.newZandiArray[i] < 999 {
                            self.day_5_dpeth.append(self.matchDateForZandi.date(from: self.newEventsArray[i] ?? "") ?? self.nowDate )
                            print("5_depth is : \(self.day_5_dpeth)")
                        } else if self.newZandiArray[i] > 600 && self.newZandiArray[i] < 799 {
                            self.day_4_dpeth.append(self.matchDateForZandi.date(from: self.newEventsArray[i] ?? "") ?? self.nowDate )
                            print("4_depth is : \(self.day_4_dpeth)")
                        } else if self.newZandiArray[i] > 400 && self.newZandiArray[i] < 599 {
                            self.day_3_dpeth.append(self.matchDateForZandi.date(from: self.newEventsArray[i] ?? "") ?? self.nowDate )
                            print("3_depth is : \(self.day_3_dpeth)")
                        } else if self.newZandiArray[i] > 200 && self.newZandiArray[i] < 399 {
                            self.day_2_dpeth.append(self.matchDateForZandi.date(from: self.newEventsArray[i] ?? "") ?? self.nowDate )
                            print("2_depth is : \(self.day_2_dpeth)")
                        } else if self.newZandiArray[i] > 0 && self.newZandiArray[i] < 199 {
                            self.day_1_dpeth.append(self.matchDateForZandi.date(from: self.newEventsArray[i] ?? "") ?? self.nowDate )
                            print("1_depth is : \(self.day_1_dpeth)")
                        }
                        
                    }
                    
                }
                self.calendar.reloadData()
            
            
            print("5_depth is : \(self.day_5_dpeth)")
            print("4_depth is : \(self.day_4_dpeth)")


        }
        
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

    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        if self.dates.contains(date){
            return 1
        }
        return 0
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {

        if self.day_5_dpeth.contains(date) {
            return [UIColor(red: 155/255, green: 233/255, blue: 168/255, alpha: 1.00)]
        } else if self.day_4_dpeth.contains(date) {
            return [UIColor(red: 64/255, green: 196/255, blue: 99/255, alpha: 1.00)]
        } else if self.day_3_dpeth.contains(date) {
            return [UIColor(red: 48/255, green: 161/255, blue: 78/255, alpha: 1.00)]
        } else if self.day_2_dpeth.contains(date) {
            return [UIColor(red: 33/255, green: 110/255, blue: 57/255, alpha: 1.00)]
        } else if self.day_1_dpeth.contains(date) {
            return [UIColor.lightGray]
        }
        return [UIColor.white]
    }
    
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


//
//  TimerViewController.swift
//  TimerZandi
//
//  Created by 이주송 on 2022/07/01.
//

import UIKit
import Alamofire

enum TimerStatus {
    case start
    case end
}


class TimerViewController: UIViewController {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var toggleButton: UIButton!
    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var testLabel2: UILabel!

    var timerStatus: TimerStatus = .end
    var timer: DispatchSourceTimer?
    var currentSeconds = 0
    
    
    var usersFocusTime: [Int] = []
    var someOfUsersFocusTime: [Int] = []
    var setOfSome:[Int] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureToggleButton()
//        self.loadValues()
    }
    
    
    @IBAction func tapToggleButton(_ sender: UIButton) {
        debugPrint(timerStatus)
        switch self.timerStatus {
        case .end:
//            if UserDefaults.standard.integer(forKey: sumTime) == true {
//                debugPrint("값이 이미 존재함")
//            }
            self.timerStatus = .start
            self.toggleButton.isSelected = true
            self.startTimer()
            debugPrint("시작 버튼이 눌리면 출력되는 메세지")
            
        case .start:
            
            self.timerStatus = .end
            self.toggleButton.isSelected = false
            self.stopTimer()
        }
    }
    // 시작할 때 만약 이미 있다면 그값을 가져오기
    @IBAction func getUserDefaultValue(_ sender: Any) {
        let sumTimeForUserDefaults = UserDefaults.standard.integer(forKey: sumTime)
        let countTimeForUserDefaults = UserDefaults.standard.integer(forKey: countTime)
        
        debugPrint(sumTimeForUserDefaults)

        let hour = (sumTimeForUserDefaults ?? 0 ) / 3600
        let minutes = (sumTimeForUserDefaults ?? 0 % 3600) / 60
        let seconds = (sumTimeForUserDefaults ?? 0 % 3600) % 60

        if hour != 0, minutes != 0, seconds != 0 {
            self.testLabel.text = "총 집중시간 : " + String(format: "%d시간 %d분 %d초", hour,minutes,seconds)
        } else if minutes != 0, seconds != 0 {
            self.testLabel.text = "총 집중시간 : " + String(format: "%d분 %d초", minutes,seconds)
        } else if seconds != 0 {
            self.testLabel.text = "총 집중시간 : " + String(format: "%d초", seconds)
        }
        self.testLabel2.text = "집중 방해 횟수 : " + String(countTimeForUserDefaults) + "회"
        postTest(a: sumTimeForUserDefaults, b: countTimeForUserDefaults)
    }
    
    @IBAction func resetUserDefaultValue(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: sumTime)
        UserDefaults.standard.removeObject(forKey: countTime)
    }
    
    
    func configureToggleButton() {
        self.toggleButton.setTitle("시작", for: .normal)
        self.toggleButton.setTitle("저장", for: .selected)
    }
    
    //시작누르면 UserDefaults가 리셋됨
    func startTimer() {
        
        if self.timer == nil {
            self.timer = DispatchSource.makeTimerSource(flags: [], queue: .main) // [GCB] UI관련작업은 main Thread에서 !
            self.timer?.schedule(deadline: .now(), repeating: 1) // 타이머의 주기 설정 메소드
            self.timer?.setEventHandler(handler: { [weak self] in
                guard let self = self else { return }
                self.currentSeconds += 1
                let hour = self.currentSeconds / 3600
                let minutes = (self.currentSeconds % 3600) / 60
                let seconds = (self.currentSeconds % 3600) % 60
                self.timerLabel.text = String(format: "%02d:%02d:%02d", hour,minutes,seconds)
                debugPrint(self.currentSeconds)
                
            })
            self.timer?.resume()
        }
    }
    
    func stopTimer() {
        usersFocusTime = UserDefaults.standard.value(forKey: "userFocusTime") as? [Int] ?? [0]
        
        print("usersFocusTime: ")
        print(usersFocusTime)
        print("someOfUsersFocusTime: ")
        print(someOfUsersFocusTime)
        print("setOfSomes:")
        print(setOfSome)
        
        self.usersFocusTime.append(self.currentSeconds)
        self.someOfUsersFocusTime.append(self.usersFocusTime.reduce(0,+))
        
        if self.someOfUsersFocusTime.count > 1 {
            self.someOfUsersFocusTime.removeFirst()
            debugPrint(someOfUsersFocusTime)
        }

        // 이걸 저장 한다음 시작했을 때 마지막 값만 가져오기
        let countOfPreventing = self.usersFocusTime.count - 1
        let someOfUsersFocusTimeIndex = self.someOfUsersFocusTime[0]
        
        UserDefaults.standard.setValue(self.usersFocusTime, forKey: "userFocusTime")
        UserDefaults.standard.setValue(countOfPreventing, forKey: countTime)
        UserDefaults.standard.setValue(someOfUsersFocusTimeIndex, forKey: sumTime)

        // 어펜드해서 저장하기
        // 배열 자체를 유저디폴트로 저장하고 가져오기 할때마다 빼오기
        
//        debugPrint("집중 시간: \(self.usersFocusTime)")
//        debugPrint("집중 시간의 합: \(someOfUsersFocusTimeIndex)")
//        debugPrint("집중 방해횟수: \(countOfPreventing)")

        currentSeconds = 0
        self.timerLabel.text = "00:00:00"
        self.timerStatus = .end
        self.toggleButton.isSelected = false
        self.timer?.cancel()
        self.timer = nil
    }
    
//    func loadValues() {
//        debugPrint(UserDefaults.standard.integer(forKey: sumTime))
//    }

    //MARK: - POST로 서버에 값을 내보내기 :: 서버에서 이 데이터를 Json 파일에 저장할 수 있음?

        func postTest(a:Int, b:Int) {
                    let url = "https://ptsv2.com/t/ln306-1656702503/post"
                    var request = URLRequest(url: URL(string: url)!)
                    request.httpMethod = "POST"
                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                    request.timeoutInterval = 10

                    // POST 로 보낼 정보
                    let params = [
                        "총 집중시간": a,
                        "집중 방해 횟수": b
                    ] as [String : Any]

                    // httpBody 에 parameters 추가
                    do {
                        try request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])
                    } catch {
                        print("http Body Error")
                    }

                    AF.request(request).responseString { (response) in
                        switch response.result {
                        case .success:
                            print("POST 성공")
                        case .failure(let error):
                            print("🚫 Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
                        }
                    }
                }
    

}


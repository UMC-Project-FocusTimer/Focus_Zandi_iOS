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
    @IBOutlet weak var willDisappearWhenItStart: UIStackView!
    @IBOutlet weak var testLabel2: UILabel!

    var timerStatus: TimerStatus = .end
    var timer: DispatchSourceTimer?
    var currentSeconds = 0
    
//    var ZandiContents = [ZandiContents]()
    
    var usersFocusTime: [Int] = []
    var sumOfUsersFocusTime: [Int] = []

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppearanceCheck(self)
    }

//MARK: - 다크모드 변경함수 , 다른 VC의 함수 어떻게 호출?
    
    func AppearanceCheck(_ viewController: UIViewController) {
        guard let appearance = UserDefaults.standard.string(forKey: "Appearance") else { return }
        if appearance == "Dark" {
            viewController.overrideUserInterfaceStyle = .dark
            if #available(iOS 13.0, *) {
                UIApplication.shared.statusBarStyle = .lightContent
            } else {
                UIApplication.shared.statusBarStyle = .default
            }
        } else {
            viewController.overrideUserInterfaceStyle = .light
            if #available(iOS 13.0, *) {
                UIApplication.shared.statusBarStyle = .darkContent
            } else {
                UIApplication.shared.statusBarStyle = .default
            }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureToggleButton()
        self.remainValuesResetWhenItLoaded()
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
            debugPrint(view.backgroundColor)
            UIView.animate(withDuration: 0.25, delay: 0, animations: {
                self.willDisappearWhenItStart.isHidden = true
                self.view.backgroundColor = .darkGray
                self.timerLabel.textColor = .white
                self.testLabel.textColor = .white
                self.testLabel2.textColor = .white
                self.tabBarController?.tabBar.isHidden = true
            })

            self.startTimer()
            
        case .start:
            self.timerStatus = .end
            self.toggleButton.isSelected = false
            self.willDisappearWhenItStart.isHidden = false
            self.tabBarController?.tabBar.isHidden = false

            self.view.backgroundColor = .white
            self.timerLabel.textColor = .black
            self.testLabel.textColor = .black
            self.testLabel2.textColor = .black

            self.stopTimer()
        }
    }
    // 시작할 때 만약 이미 있다면 그값을 가져오기
    
    @IBAction func getUserDefaultValue(_ sender: Any) {
        let sumTimeForUserDefaults = UserDefaults.standard.integer(forKey: sumTime)
        let countTimeForUserDefaults = UserDefaults.standard.integer(forKey: countTime)
        
        let hour = (sumTimeForUserDefaults ?? 0 ) / 3600
        let minutes = (sumTimeForUserDefaults ?? 0 % 3600) / 60
        let seconds = (sumTimeForUserDefaults ?? 0 % 3600) % 60

        if hour != 0, minutes != 0, seconds != 0 {
            self.testLabel.text = "총 집중시간 : " + String(format: "%d시간 %d분 %d초", hour,minutes,seconds)
        } else if minutes != 0, seconds != 0 {
            self.testLabel.text = "총 집중시간 : " + String(format: "%d분 %d초", minutes,seconds)
        } else if seconds != 0 {
            self.testLabel.text = "총 집중시간 : " + String(format: "%d초", seconds)
        } else if sumTimeForUserDefaults == 0 {
            self.testLabel.text = "총 집중시간 : " + String(sumTimeForUserDefaults) + "초"
        }
            
            
        self.testLabel2.text = "집중 방해 횟수 : " + String(countTimeForUserDefaults) + "회"
        postTest(a: sumTimeForUserDefaults, b: countTimeForUserDefaults)

    }
    
    @IBAction func resetUserDefaultValue(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "userFocusTime")
        UserDefaults.standard.removeObject(forKey: sumTime)
        UserDefaults.standard.removeObject(forKey: countTime)
    }
    // 총 집중시간도 0이 됨 근데 출력이 안될뿐
    
//MARK: - 빌드 했는데 그 전에 UserDefaults로 저장된 값이 있다면 이를 다 지움
    
    func remainValuesResetWhenItLoaded() {
        if UserDefaults.standard.value(forKey: sumTime) as? Int ?? 0 > 0 || UserDefaults.standard.value(forKey: countTime) as? Int ?? 0 >= 0
        {
            debugPrint("위와 같이 기존의 값이 기기에 존재해서")
            UserDefaults.standard.removeObject(forKey: "userFocusTime")
            UserDefaults.standard.removeObject(forKey: sumTime)
            UserDefaults.standard.removeObject(forKey: countTime)
            debugPrint("지우고 시작합니다")
        }
        
    }
    
    func configureToggleButton() {
        self.toggleButton.setTitle("시작", for: .normal)
        self.toggleButton.setTitle("저장", for: .selected)
    }
    
    
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
        
        self.usersFocusTime.append(self.currentSeconds)
        self.sumOfUsersFocusTime.append(self.usersFocusTime.reduce(0,+))
        
        if self.sumOfUsersFocusTime.count > 1 {
            self.sumOfUsersFocusTime.removeFirst()
            debugPrint(sumOfUsersFocusTime)
        }

        // 이걸 저장 한다음 시작했을 때 마지막 값만 가져오기
        let countOfPreventing = self.usersFocusTime.count - 2
        let sumOfUsersFocusTimeIndex = self.sumOfUsersFocusTime[0]
        
        UserDefaults.standard.setValue(self.usersFocusTime, forKey: "userFocusTime")
        UserDefaults.standard.setValue(countOfPreventing, forKey: countTime)
        UserDefaults.standard.setValue(sumOfUsersFocusTimeIndex, forKey: sumTime)
        
        // 어펜드해서 저장하기
        // 배열 자체를 유저디폴트로 저장하고 가져오기 할때마다 빼오기
        
//        debugPrint("집중 시간: \(self.usersFocusTime)")
//        debugPrint("집중 시간의 합: \(sumOfUsersFocusTimeIndex)")
//        debugPrint("집중 방해횟수: \(countOfPreventing)")

        currentSeconds = 0
        self.timerLabel.text = "00:00:00"
        self.timerStatus = .end
        self.toggleButton.isSelected = false
        self.timer?.cancel()
        self.timer = nil
    }
    

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


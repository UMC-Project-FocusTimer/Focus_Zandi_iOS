//
//  TimerViewController.swift
//  TimerZandi
//
//  Created by 이주송 on 2022/07/01.
//

import UIKit
import Alamofire
import GoogleSignIn

enum TimerStatus {
    case start
    case end
}

class TimerViewController: UIViewController {

    @IBOutlet weak var textWillBeChanged: UILabel!
    @IBOutlet weak var exampleClassView: UIView!
    @IBOutlet weak var userDayInfo: UIStackView!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var toggleButton: UIButton!
//    @IBOutlet weak var idToken: UILabel!
//    @IBOutlet weak var userId: UILabel!
//    @IBOutlet weak var email: UILabel!
//    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var firstClasTime: UILabel!

    var TimeList:[String] = []
    
    var topics = [Topic]() {
        didSet {
            self.saveTopics()
        }
    } // append 될때마다 save Topics 실행되게
    
    var eachClassTimeSum:[Int] = []
    
    var timerStatus: TimerStatus = .end
    var timer: DispatchSourceTimer?
    var currentSeconds = 0
    var usersFocusTime: [Int] = []
    var sumOfUsersFocusTime: [Int] = []

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
//MARK: - UserDefaults로 저장된 값 초기화하기
    
    @IBAction func resetData(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "userFocusTime")
        UserDefaults.standard.removeObject(forKey: sumTime)
        UserDefaults.standard.removeObject(forKey: countTime)
    }
    
//MARK: - UserDefaults로 저장된 값 가져오기
    @IBAction func reLoadButton(_ sender: Any) {
        let sumTimeForUserDefaults = UserDefaults.standard.integer(forKey: sumTime)
        
        let hour = (sumTimeForUserDefaults ?? 0 ) / 3600
        let minutes = (sumTimeForUserDefaults ?? 0 % 3600) / 60
        let seconds = (sumTimeForUserDefaults ?? 0 % 3600) % 60

        self.tableView.reloadData()
        
        if hour != 0, minutes != 0, seconds != 0 {
            self.firstClasTime.text = "총 공부시간 :" + String(format: "%d시간 %d분 %d초", hour,minutes,seconds)
        } else if minutes != 0, seconds != 0 {
            self.firstClasTime.text = "총 공부시간 :" + String(format: "%d분 %d초", minutes,seconds)
        } else if seconds != 0 {
            self.firstClasTime.text = "총 공부시간 :" + String(format: "%d초", seconds)
        } else if sumTimeForUserDefaults == 0 {
            self.firstClasTime.text = "총 공부시간 :" + String(sumTimeForUserDefaults) + "초"
        }
//        let tagKey = UserDefaults.standard.string(forKey: "tagKey")
//        UserDefaults.standard.setValue(sumTimeForUserDefaults, forKey: "class_\(tagKey!)")
//        print(UserDefaults.standard.integer(forKey: sumTime))
//        print(UserDefaults.standard.integer(forKey: "userFocusTime"))
        

    }
    
    @IBAction func tapAddButton(_ sender: Any) {
        let alert = UIAlertController(title: "과목 등록", message: "오늘 공부할 과목 등록하기", preferredStyle: .alert)
        let registerButton = UIAlertAction(title: "등록", style: .default, handler: { [weak self] _ in
            guard let title = alert.textFields?[0].text else {return}
            let topic = Topic(title: title)
            self?.topics.append(topic)
            self?.eachClassTimeSum.append(0)
            self?.tableView.reloadData()
        })
        let cancleButton = UIAlertAction(title: "취소", style: .default, handler:nil)
        alert.addAction(cancleButton)
        alert.addAction(registerButton)
        alert.addTextField(configurationHandler: {
            textField in textField.placeholder = "과목을 입력해주세요"
        })
        self.present(alert, animated: true, completion: nil)
    }
    
    func saveTopics() {
        let data = self.topics.map {
            [
                "title": $0.title
            ]
        }
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(data, forKey: "topics")
    } // 딕셔너리 형태로 UserDefaults에 저장
    
    func loadTopics() {
        let userDefaults = UserDefaults.standard
      guard let data = userDefaults.object(forKey: "topics") as? [[String:Any]] else {return}
        self.topics = data.compactMap {
            guard let title = $0["title"] as? String else {return nil}
            return Topic(title: title)
        }
    }
    
//MARK: - Google Login -> 유저정보 받아오기
    
//    @IBAction func google(_ sender: Any) {
//        let config = GIDConfiguration(clientID: "795344605481-eh9clt5aracqv6avsfmr3ca611nemc7k.apps.googleusercontent.com")
//
//        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { user, error in
//            if let error = error { return }
//            guard let user = user else { return }
//
//
//            self.idToken.text = user.authentication.idToken
//            self.userId?.text = user.userID
//            self.email?.text = user.profile?.email
//            self.fullName?.text = user.profile?.name
//
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.loadTopics()
        self.remainValuesResetWhenItLoaded()
    }
    
    @IBAction func tapToggleButton(_ sender: UIButton) {
        debugPrint(timerStatus)
        switch self.timerStatus {
        case .end:
            self.timerStatus = .start
            self.toggleButton.isSelected = true
            UIView.animate(withDuration: 0.25, delay: 0, animations: {
                self.view.backgroundColor = .darkGray
                self.timerLabel.textColor = .white
                self.tabBarController?.tabBar.isHidden = true
                self.logoImage.isHidden = true
                self.userDayInfo.isHidden = true
                self.tableView.isHidden = true
            })
            self.startTimer()
            
        case .start:
            self.timerStatus = .end
            self.toggleButton.isSelected = false
            self.tabBarController?.tabBar.isHidden = false
            self.logoImage.isHidden = false
            self.userDayInfo.isHidden = false
            self.tableView.isHidden = false

            self.view.backgroundColor = .white
            self.timerLabel.textColor = .black
            self.toggleButton.setImage(UIImage(systemName: "pause.circle.fill"), for: .selected)
            self.stopTimer()
        }
    }

    func testFunc() {
        
    } // stoptimer에서 저장된 값을 배열에 넣기
    // 테이블뷰 셀의 label로
    // 저장된 시간을 topic.time에 넣어야함
    // 이 배열에 넣기만 하면 알아서 끄집어 냄
    
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
        
        let tagKey = UserDefaults.standard.integer(forKey: "tagKey")
        UserDefaults.standard.setValue(self.currentSeconds, forKey: "class_\(tagKey)")
        let numberForSum = UserDefaults.standard.integer(forKey: "class_\(tagKey)")
        

        print("tagKey is \(tagKey)")
        print("numberForSum is \(numberForSum)")
        print("eachClassTimeSum is \(eachClassTimeSum)")
        print("eachClassTimeSum[tagKey] is \(eachClassTimeSum[tagKey])")
        
        // numberForSum 값을 eachClassTimeSum[tagKey] 값에 더한 후 다시 넣어줄거임
        if eachClassTimeSum[tagKey] != 0 {
            print("값이 존재함")
            self.eachClassTimeSum[tagKey] += numberForSum
        } else if eachClassTimeSum[tagKey] == 0 {
            print("값이 없음")
            self.eachClassTimeSum[tagKey] = UserDefaults.standard.integer(forKey: "class_\(tagKey)")
        }
        
        UserDefaults.standard.setValue(eachClassTimeSum[tagKey], forKey: "focustime_number_\(tagKey)")
            
        print("tagKey is \(tagKey)")
        print("numberForSum is \(numberForSum)")
        print("eachClassTimeSum is \(eachClassTimeSum)")
        print("eachClassTimeSum[tagKey] is \(eachClassTimeSum[tagKey])")
        
        
        // 각각의 배열에 더해지게
        // 태그 값이랑 배열 값이랑 같아지면 더하도록
        // eachClassTimeSum에 이전 값이 존재하면 더하도록 설계하기
        
        // 스크린샷 참고 ! 시작할때 앱 삭제 후 다시 시작하기 (위에 0으로 채우는 메소드가 유저디폴트가 아니라서 오류뜸)
        // 과목 추가 -> 타이머 실행하면 eachClassTimeSum에 값이 각각 교체되어 들어감(0->3)
        // 근데 이미 추가되어있다면 0이 아니라면 더해서 들어가야 하는데, 새로운 값이 업데이트 되어 들어감
        // 인덱스 0인 값 0이라면 더하는 조건문 만들기
        
        currentSeconds = 0
        self.timerLabel.text = "00:00:00"
        self.timerStatus = .end
        self.toggleButton.isSelected = false
        self.timer?.cancel()
        self.timer = nil
        self.TimeList.append(String(sumOfUsersFocusTimeIndex))
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


extension TimerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.topics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClassTableViewCell", for: indexPath) as! ClassTableViewCell
        let topic = self.topics[indexPath.row]
        cell.className?.text = topic.title
        cell.cellDelegate = self
        cell.btn.tag = indexPath.row
        cell.FocusTime.text = UserDefaults.standard.string(forKey: "focustime_number_\(indexPath.row)")
        

        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        self.topics.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
}

extension TimerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

extension TimerViewController: YourCellDelegate {
    func didPressButton(_ tag: Int) {
         print("\(tag)번 인덱스에 있는 버튼입니다")
        self.textWillBeChanged.text = topics[tag].title
        UserDefaults.standard.setValue(tag, forKey: "tagKey")
        print(UserDefaults.standard.string(forKey: "tagKey"))
    }
}

// 버튼 누르면 몇번째 셀인지를 의미하는 태그번호가 유저디폴트로 저장 1번 누르면 tag = 1 이 tagKey로 저장
// 그 키 담고 있는 값(tag = 1)의 Key 하여금 순간 집중 값을 저장
// 그 순간 집중값을 인덱스화 시켜서 각 셀에 저장

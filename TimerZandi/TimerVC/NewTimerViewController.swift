//
//  NewTimerViewController.swift
//  TimerZandi
//
//  Created by 이주송 on 2022/08/15.
//

import UIKit

class NewTimerViewController: UIViewController {

    @IBOutlet var editButton: UIBarButtonItem!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var topicTableView: UITableView!
    @IBOutlet var stopButton: UIButton!
    var doneButton: UIBarButtonItem?

    var brokenCount = 0
    var selected = 0
    var time = 0
    var timer: Timer?
    var totalTime = 0
    let formatter = DateFormatter() //객체 생성

    
    var concentratedTime = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        aboutTableView()
        aboutDefaultTime()
        aboutStopButton()
        todatDate()
        self.doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTap))
    }
    
    func todatDate() {
        self.formatter.dateStyle = .long
        self.formatter.timeStyle = .medium
        self.formatter.dateFormat = "yyyy-MM-dd"
        self.dateLabel.text = self.formatter.string(from: Date())
    }
    
    @objc func doneButtonTap() {
        self.navigationItem.leftBarButtonItem = self.editButton
        self.topicTableView.setEditing(false, animated: true)
    }
    
    func aboutStopButton() {
        stopButton.isHidden = true
    }
    
    func aboutTableView() {
        topicTableView.delegate = self
        topicTableView.dataSource = self
        topicTableView.register(UINib(nibName: "TopicTableViewCell", bundle: nil), forCellReuseIdentifier: "TopicTableViewCell")
    }
    
    func aboutDefaultTime() {
        totalTime = topicTimeList.reduce(0) { (a: Int, b: Int) -> Int in
            return a + b
        }
        
        
        timeLabel.text = timeForm(rowTime: topicTimeList.reduce(0) { (a: Int, b: Int) -> Int in
            return a + b
        })
    }
    
    func timeForm(rowTime: Int) -> String {
        var row = rowTime
        var hour: Int = 0
        var minute: Int = 0
        var second: Int = 0
        
        if (row >= 3600) {
            hour = row / 3600
            row = row % 3600
        }
        
        if (row >= 60) {
            minute = row / 60
            row = row % 60
        }
        
        second = row
        
        self.concentratedTime = rowTime

        let hourString = String(format: "%02d", hour)
        let minuteString = String(format: "%02d", minute)
        let secondString = String(format: "%02d", second)
        
        return hourString + ":" + minuteString + ":" + secondString
    }
    
    @objc func timerCallBack() {
        time += 1
        self.timeLabel.text = timeForm(rowTime: totalTime + 1)
        totalTime += 1
    }
    
    @IBAction func plusTopicButtonPush(_ sender: Any) {
        let title = "Add New Topic"
        let message = "추가할 과목의 이름을 적어주세요"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addTextField(){ (tf) in
            tf.placeholder = "수학"
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: "추가", style: .default) { (tf) in
            if let txt = alert.textFields?[0] {
                if txt.text?.isEmpty != true {
                    topicList.append(txt.text!)
                    topicTimeList.append(0)
                    
                    UserDefaults.standard.set(topicList, forKey: topicKey)
                    UserDefaults.standard.set(topicTimeList, forKey: topicTimeKey)
                    
                    self.topicTableView.reloadData()
                } else {
                    print("텍스트가 없음")
                }
            }
        }
        alert.addAction(cancel)
        alert.addAction(ok)
        
        self.present(alert, animated: true)
    }
    
    func whenStudyStart() {
        topicTableView.isHidden = true
    }
    

    @IBAction func tapEditButton(_ sender: Any) {
        self.navigationItem.leftBarButtonItem = self.doneButton
        self.doneButton?.tintColor = .darkGray
        self.topicTableView.setEditing(true, animated: true)
    }
    
    @IBAction func stopButtonPush(_ sender: Any) {
        self.brokenCount += 1
        timer!.invalidate()
        topicTimeList[selected] += time
        time = 0
        UserDefaults.standard.set(topicTimeList, forKey: topicTimeKey)
        self.sendToServer()
        topicTableView.reloadData()
        topicTableView.isHidden = false
        stopButton.isHidden = true
    }
    
    func sendToServer(){
        self.formatter.dateStyle = .long
        self.formatter.timeStyle = .medium
        self.formatter.dateFormat = "yyyy-MM-dd" //데이터 포멧 설정
        let str = self.formatter.string(from: Date()) //문자열로 바꾸기
        
        print("방해집중 횟수 : \(self.brokenCount)")

//        var concentratedTime = topicTimeList.reduce(0) { (a: Int, b: Int) -> Int in
//            return a + b
//        }
        
        print(self.concentratedTime)
        print(str)
        
        postTodayRecord(accessToken: accessToken, refToken: refToken, concentratedTime: self.concentratedTime, brokenCount: self.brokenCount, date: str)
        // post 연결하기
    }
    
}

extension NewTimerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topicList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TopicTableViewCell", for: indexPath) as? TopicTableViewCell else { return UITableViewCell() }
        
        cell.timeLabel.text = timeForm(rowTime: topicTimeList[indexPath.row])
        cell.topicNameLabel.text = topicList[indexPath.row]
        

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selected = indexPath.row
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCallBack), userInfo: nil, repeats: true)
        tableView.isHidden = true
        stopButton.isHidden = false
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            topicList.remove(at: indexPath.row)
            topicTimeList.remove(at: indexPath.row)
            
            UserDefaults.standard.set(topicList, forKey: topicKey)
            UserDefaults.standard.set(topicTimeList, forKey: topicTimeKey)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

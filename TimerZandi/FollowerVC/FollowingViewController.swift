//
//  FollowingViewController.swift
//  TimerZandi
//
//  Created by Jin younkyum on 2022/07/01.
//

import UIKit

var followingList: [String] = ["Song", "Onve", "Jason", "Yk"]
var followerTime = ["00:03:30", "02:34:33", "07:55:34", "00:40:23"]
var disturbCount = [3, 5, 6, 3]


class FollowingViewController: UIViewController {
    
        
    @IBOutlet var editButton: UIBarButtonItem!
    var follwerDataModel = FollwerDataModel ()
    var doneButton: UIBarButtonItem?
    
    @IBAction func addFollwer(_ sender: Any) {
        let alert = UIAlertController(title: "팔로워 등록", message: "같이 공부할 친구 추가하기", preferredStyle: .alert)
        let registerButton = UIAlertAction(title: "등록", style: .default, handler: { [weak self] _ in
            guard let follwee_Name = alert.textFields?[0].text else {return}
//            addFollwerPost(accessToken: accessToken, refToken: refToken, follweeName: follwee_Name)
            addFriend(follweeName: follwee_Name, accessToken: accessToken, refToken: refToken, onCompleted: {
                [weak self] result in // 순환 참조 방지, 전달인자로 result
                guard let self = self else { return } // 일시적으로 strong ref가 되게
         
                switch result {
                case let .success(result):
                    self.follwerDataModel.inputData(image: "IMG_0518.jpg", numberOfFollower: result.numberOfFollowers, focusTimeForThisMonth: 22, followeName: result.username, follwerDesciption: result.memo, todayFocusTime: 33, brokenCount: 44)
                    self.follwerTableView.reloadData()
                    print(self.follwerDataModel.count)

                    // 받아와 지면 여기에서는 appende가 됨.

                    
                    
                case let .failure(error):
                    debugPrint("error \(error)")
                }
            })
            
        })
        let cancleButton = UIAlertAction(title: "취소", style: .default, handler:nil)
        alert.addAction(cancleButton)
        alert.addAction(registerButton)
        alert.addTextField(configurationHandler: {
            textField in textField.placeholder = "친구의 이름을 알려주세요"
        })
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBOutlet weak var follwerTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
        
        self.doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTap))
        follwerTableView.dataSource = self
        follwerTableView.delegate = self
//        followerTableViewAutoLayout()
        follwerTableView.register(UINib(nibName: "FollowerTableViewCell", bundle: .main), forCellReuseIdentifier: "FollowerTableViewCell")
        follwerTableView.allowsSelection = true
//        follwerTableView.setEditing(true, animated: true)
    }
    
    @objc func doneButtonTap() {
        self.navigationItem.leftBarButtonItem = self.editButton
        self.follwerTableView.setEditing(false, animated: true)
    }
    
    @IBAction func tapEditButton(_ sender: Any) {
        guard !self.follwerDataModel.arrayStruct.isEmpty else {return}
        self.navigationItem.leftBarButtonItem = self.doneButton
        self.follwerTableView.setEditing(true, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        var THEME_KEY = UserDefaults.standard.integer(forKey: "THEME_KEY")

        super.viewWillAppear(animated)
        
        if THEME_KEY != 0 {
        let textAttributes = [NSAttributedString.Key.foregroundColor:themes[THEME_KEY][0]]
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
            navigationController?.navigationBar.titleTextAttributes = textAttributes
        } else {
            let textAttributes = [NSAttributedString.Key.foregroundColor:themes[8][0]]
            navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
            navigationController?.navigationBar.titleTextAttributes = textAttributes
        }
    }

    
    @IBAction func pushPlusButton(_ sender: Any) {
        print("add new Follower")
    }
    
    
    @IBAction func pushReloadButton(_ sender: Any) {
        print("reload")
        follwerTableView.reloadData()
    }

}

extension FollowingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        UserDefaults.standard.setValue(indexPath.row, forKey: "SELECTED")
    
        guard let ViewController = self.storyboard?.instantiateViewController(withIdentifier: "FollwersPageViewController") as? FollwersPageViewController else {return}
        
        ViewController.FolloweName = self.follwerDataModel.getFolloweName(index: indexPath.row)
        ViewController.Image = self.follwerDataModel.getImage(index: indexPath.row)
        ViewController.NumberOfFollower = self.follwerDataModel.getNumberOfFollower(index: indexPath.row)
        ViewController.TodayFocusTime = self.follwerDataModel.getTodayFocusTime(index: indexPath.row)
        ViewController.FollwerDesciption = self.follwerDataModel.getFollwerDesciption(index: indexPath.row)
        ViewController.TodayFocusTime = self.follwerDataModel.getTodayFocusTime(index: indexPath.row)
        ViewController.BrokenCount = self.follwerDataModel.getBrokenCount(index: indexPath.row)
        ViewController.FocusTimeForThisMonth = self.follwerDataModel.getFocusTimeForThisMonth(index: indexPath.row)
    
        self.navigationController?.pushViewController(ViewController, animated: true)

    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return follwerDataModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FollowerTableViewCell", for: indexPath) as? FollowerTableViewCell else { return UITableViewCell() }
        
        let followerName = follwerDataModel.getFolloweName(index: indexPath.row)
        let brokenCount = follwerDataModel.getBrokenCount(index: indexPath.row)
        let todayFocusTime = follwerDataModel.getTodayFocusTime(index: indexPath.row)
        let image = follwerDataModel.getImage(index: indexPath.row)
        
        cell.follwerImage.image = UIImage(named: image)
        cell.userNameLabel.text = followerName
//        cell.disturbCountLabel.text = String(brokenCount) + "초"
//        cell.totalTimeLabel.text = String(todayFocusTime) + "회"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        self.follwerDataModel.removeFromDataModel(index: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    
    
}
// 선택되면 페이지 넘어가고 넘어간 페이지에서 데이터 가져오기

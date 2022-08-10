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
    
    
    var follwerDataModel = FollwerDataModel ()
    
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
        follwerTableView.dataSource = self
        follwerTableView.delegate = self
//        followerTableViewAutoLayout()
        follwerTableView.register(UINib(nibName: "FollowerTableViewCell", bundle: .main), forCellReuseIdentifier: "FollowerTableViewCell")
        follwerTableView.allowsSelection = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(follwerDataModel.count)
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

//extension FollowingViewController {
//    func followerTableViewAutoLayout() {
//        self.view.addSubview(followerTableView)
//        followerTableView.translatesAutoresizingMaskIntoConstraints = false
//
//        followerTableView.separatorInset.left = 0
//
//        followerTableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
//        followerTableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
//        followerTableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
//        followerTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
//    }
//}

extension FollowingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        UserDefaults.standard.setValue(indexPath.row, forKey: "SELECTED")

        print(self.follwerDataModel.getFolloweName(index: indexPath.row))

        
//        let cellName = follwerDataModel.getFolloweName(index: indexPath.row)
        

//        NotificationCenter.default.post(name: NSNotification.Name("test04"), object: nil,
//        userInfo: ["image": follwerDataModel.getImage(index: indexPath.row) ?? "",
//                   "numberOfFollower": follwerDataModel.getNumberOfFollower(index:) ?? 0,
//                   "focusTimeForThisMonth": follwerDataModel.getTodayFocusTime(index: indexPath.row),
//                   "followeName": follwerDataModel.getFolloweName(index: indexPath.row) ?? "",
//                   "follwerDesciption": result.memo ?? "",
//                   "todayFocusTime": 33,
//                   "brokenCount": 44
//                  ]
//            ) // 셀 눌렀을때 전송되게

        guard let ViewController = self.storyboard?.instantiateViewController(withIdentifier: "FollwersPageViewController") as? FollwersPageViewController else {return}
        
        ViewController.name = self.follwerDataModel.getFolloweName(index: indexPath.row)
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
          
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        
        if editingStyle == .delete {
            tableView.beginUpdates()
            followingList.remove(at: indexPath.row)
            followerTime.remove(at: indexPath.row)
            disturbCount.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()

        } // model에 remove함수 만들어서 가져오기 
    }
    
}
// 선택되면 페이지 넘어가고 넘어간 페이지에서 데이터 가져오기

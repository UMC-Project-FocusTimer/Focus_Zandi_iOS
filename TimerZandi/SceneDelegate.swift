
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    var boolValue = 0

    // TODO: 1. 이미지뷰 생성
        var imageView: UIImageView?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        
            
    // TODO: 3. 앱이 다시 활성화 상태가 되면 이미지뷰를 superview (window)에서 제거한다
            if let imageView = imageView {
                imageView.removeFromSuperview()
            }
    }

    func sceneWillResignActive(_ scene: UIScene) {
    // TODO: 2. will resign active 상태가 호출되면 imageview를 window 크기로 잡아주고 window에 추가한다
        guard let window = window else {
            return
        }

        imageView = UIImageView(frame: window.frame)
        imageView?.image = UIImage(named: "launchScreen.png" )
        window.addSubview(imageView!)
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}


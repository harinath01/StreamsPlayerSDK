import UIKit

class ViewController: UIViewController {

    @IBAction func playStreamsNonDRMVideo(_ sender: Any) {
        let playerViewController = self.storyboard?.instantiateViewController(withIdentifier: "StreamsPlayerViewController") as! StreamsPlayerViewController
        playerViewController.videoId = Constants.Streams.NON_DRM_VIDEO_ID
        playerViewController.accessToken = Constants.Streams.NON_DRM_VIDEO_ACCESS_TOKEN
        playerViewController.modalPresentationStyle = .fullScreen
        self.present(playerViewController, animated: false)
    }
}


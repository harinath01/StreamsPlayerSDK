//
//  StreamsPlayerViewController.swift
//  Sample
//
//  Created by Testpress on 17/05/23.
//

import Foundation
import StreamsPlayerSDK
import UIKit

class StreamsPlayerViewController: UIViewController {
    var playerView: StreamsPlayerView!
    var videoId: String!
    var accessToken: String!
    
    @IBOutlet weak var playerContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            playerView = try StreamsPlayerView(
                frame: playerContainer.frame,
                orgCode: Constants.Streams.ORG_CODE,
                videoId: videoId,
                accessToken: accessToken
            )
            playerContainer.removeFromSuperview()
            view.addSubview(playerView)
        } catch {
            print("Failed to initialize the player")
        }
    }
    
    @IBAction func goBack(_ sender: Any) {
        dismiss(animated: false)
    }
}


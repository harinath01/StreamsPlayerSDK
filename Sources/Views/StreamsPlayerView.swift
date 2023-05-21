import Foundation
import UIKit
import AVKit

open class StreamsPlayerView: UIView {
    var videoId: String!
    var orgCode: String!
    var accessToken: String!
    var player: AVPlayer!
    var playerLayer: AVPlayerLayer!
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public init(frame: CGRect, orgCode: String!, videoId: String!, accessToken: String!) throws{
        super.init(frame: frame)
        try validateArguments(orgCode: orgCode, videoId: videoId, accessToken: accessToken)
        self.orgCode = orgCode
        self.videoId = videoId
        self.accessToken = accessToken
        self.backgroundColor = .black
        self.configurePlayerWithVideo()
    }
    
    private func validateArguments(orgCode: String!, videoId: String!, accessToken: String!) throws {
        guard let orgCode = orgCode, !orgCode.isEmpty else {
            throw StreamsPlayerError.InvalidArgument("orgCode")
        }
        
        guard let videoId = videoId, !videoId.isEmpty else {
            throw StreamsPlayerError.InvalidArgument("videoId")
        }
        
        guard let accessToken = accessToken, !accessToken.isEmpty else {
            throw StreamsPlayerError.InvalidArgument("accessToken")
        }
    }
    
    private func configurePlayerWithVideo(){
        StreamsAPIClient.fetchVideo(orgCode: orgCode, videoId: videoId, accessToken: accessToken){ videoDetails, error in
            if let videoDetails = videoDetails {
                self.setupPlayer(with: videoDetails.playbackURL)
            } else if let error = error {
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    private func setupPlayer(with playbackURL: String) {
        guard let url = URL(string: playbackURL) else {
            return
        }
        
        player = AVPlayer(url: url)
        addPlayerLayerToView()
        player.play()
    }
    
    private func addPlayerLayerToView() {
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = bounds
        layer.addSublayer(playerLayer)
    }
}

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
        self.initializePlayer()
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
    
    private func initializePlayer(){
        StreamingClient.fetchVideo(orgCode: orgCode, videoId: videoId, accessToken: accessToken) { videoDetails, error in
            if let videoDetails = videoDetails {
                let playerItem = self.getPlayerItem(url: URL(string: videoDetails.playbackURL)!)
                self.player = AVPlayer(playerItem: playerItem)
                self.playerLayer = AVPlayerLayer(player: self.player)
                self.playerLayer.frame = self.bounds
                self.layer.addSublayer(self.playerLayer)
                self.player.play()
            } else if let error = error {
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    private func getPlayerItem(url: URL) -> AVPlayerItem{
        let asset = AVURLAsset(url: url)
        return AVPlayerItem(asset: asset)
    }
}

import Foundation
import Alamofire

class APIClient: BaseAPIClient{
    class override var VIDEO_DETAIL_API: String {
        return "https://%@.testpress.in/api/v2.5/video_info/%@/?access_token=%@"
    }
    
    override class func parseVideoDetails(data: Data) throws -> VideoDetails {
        guard let responseDict = try JSONSerialization.jsonObject(with: data) as? [String: Any],
              let title = responseDict["title"] as? String,
              let playbackURL = responseDict["hls_url"] as? String ?? responseDict["url"] as? String,
              let transcodingStatus = responseDict["transcoding_status"] as? String else {
            throw NSError(domain: "InvalidResponseError", code: 0)
        }
        
        return VideoDetails(videoId: "",
                            title: title,
                            playbackURL: playbackURL,
                            transcodingStatus: transcodingStatus)
    }
}

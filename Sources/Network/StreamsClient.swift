import Foundation
import Alamofire

class StreamingClient: StreamingClientProtocol {
    static let VIDEO_DETAIL_API = "https://app.tpstreams.com/api/v1/%@/assets/%@/?access_token=%@"
    
    static func fetchVideo(orgCode: String!, videoId: String!, accessToken: String!, completion: @escaping (VideoDetails?, Error?) -> Void) {
        let url = String(format: VIDEO_DETAIL_API, orgCode, videoId, accessToken)
        
        AF.request(url).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let videoDetails = try parseVideoDetails(data: data)
                    completion(videoDetails, nil)
                } catch {
                    completion(nil, error)
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    private static func parseVideoDetails(data: Data) throws -> VideoDetails {        
        guard let responseDict = try JSONSerialization.jsonObject(with: data) as? [String: Any],
              let video = responseDict["video"] as? [String: Any],
              let videoId = responseDict["id"] as? String,
              let title = responseDict["title"] as? String,
              let playbackURL = video["playback_url"] as? String,
              let isDRMProtected = video["enable_drm"] as? Bool,
              let transcodingStatus = video["status"] as? String else {
            throw NSError(domain: "InvalidResponseError", code: 0)
        }
        
        return VideoDetails(videoId: videoId,
                            title: title,
                            playbackURL: playbackURL,
                            isDRMProtected: isDRMProtected,
                            transcodingStatus: transcodingStatus)
    }
}

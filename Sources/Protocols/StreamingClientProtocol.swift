import Foundation

protocol StreamingClientProtocol{
    static func fetchVideo(orgCode: String!, videoId: String!, accessToken: String!, completion: @escaping (VideoDetails?, Error?) -> Void) throws;
    
}

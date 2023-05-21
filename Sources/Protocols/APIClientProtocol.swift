import Foundation

protocol APIClientProtocol{
    static func fetchVideo(orgCode: String!, videoId: String!, accessToken: String!, completion: @escaping (VideoDetails?, Error?) -> Void) throws;
}

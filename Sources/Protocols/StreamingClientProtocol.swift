//
//  BaseNetwork.swift
//  StreamsPlayerSDK
//
//  Created by Testpress on 16/05/23.
//

import Foundation

protocol StreamingClientProtocol{
    static func fetchVideo(orgCode: String!, videoId: String!, accessToken: String!, completion: @escaping (VideoDetails?, Error?) -> Void) throws;
    
}

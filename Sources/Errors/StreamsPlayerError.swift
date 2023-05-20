//
//  StreamsPlayerError.swift
//  StreamsPlayerSDK
//
//  Created by Testpress on 16/05/23.
//

import Foundation

enum StreamsPlayerError: Error {
    case InvalidArgument(String)
    
    var localizedDescription: String {
        switch self {
        case .InvalidArgument(let input):
            return "Invalid argument for \(input)"
        }
    }
}

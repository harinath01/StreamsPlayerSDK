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

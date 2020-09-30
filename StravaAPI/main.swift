import Alamofire
import Foundation
import HTTPRequest

do {

    try StravaSession.shared.configure()
    debugPrint(StravaSession.shared.token)
    
    debugPrint("Done!")
    
} catch {
    debugPrint(error)
}

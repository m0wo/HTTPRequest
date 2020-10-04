import Alamofire
import Foundation
import HTTPRequest

do {
    HTTPRequest.Configuration.shared.responseLogging = true
    
    try StravaSession.shared.configure()
    
    let athlete: Athlete =
        try AF.requestSync(StravaAPI.athlete).modelOrThrow()
    
    debugPrint(athlete)

} catch {
    debugPrint(error)
}

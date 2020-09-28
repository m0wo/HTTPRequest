import Alamofire
import Foundation
import HTTPRequest

do {
    let _ = try AF.requestSync(StravaAPI.athlete)
    debugPrint("Done!")
    
} catch {
    debugPrint(error)
}

import Alamofire
import Foundation
import HTTPRequest

do {

    try StravaSession.shared.configure()
    
    let athlete: DetailedAthlete =
        try AF.requestModelSync(StravaAPI.athlete).modelOrThrow()

    debugPrint(athlete)
    
} catch {
    debugPrint(error)
}

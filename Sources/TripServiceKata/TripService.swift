import Foundation

class TripService
{
    func getTripsByUser(_ user: User) throws -> [Trip]?
    {
        var tripList: [Trip]? = nil
        let loggedUser = try! getLoggedUser()
        
        var isFriend = false
        
        if let loggedUser = loggedUser {
            for friend in user.getFriends() {
                if friend == loggedUser {
                    isFriend = true
                    break
                }
            }
            if isFriend {
                tripList = try! findTripsByUser(user)
            }
            return tripList
        }
        else {
            throw TripServiceErrorType.userNotLoggedIn
        }
    }
    
    func getLoggedUser() throws -> User?{
        try! UserSession.sharedInstance.getLoggedUser()
    }
    
    func findTripsByUser(_ user: User) throws -> [Trip]?{
        try! TripDAO.findTripsByUser(user)
    }
}

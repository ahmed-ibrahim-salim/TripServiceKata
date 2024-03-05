import XCTest
@testable import TripServiceKata

class TripServiceKataTests: XCTestCase {
    var tripService: TestableTripService?
    
    override func setUp() {
        tripService = TestableTripService()
    }
    
    override func tearDown() {
        tripService = nil
    }
    
    func test_whenUserNotLoggedIn_throwsError() throws {
        let user = User()
        
        XCTAssertThrowsError(try tripService?.getTripsByUser(user))
        
    }
    
    func test_whenUserIsLoggedIn_DoesNotThrowError() throws {
        let user = User()
        let userSession = UserSession()
        tripService?.userSession = UserSessionMock()
        XCTAssertNoThrow(try tripService?.getTripsByUser(user), "no message")
    }
    
}

class UserSessionMock: UserSession {

    override func getLoggedUser() throws -> User? {
        User()
    }
}

class TestableTripService: TripService {
    var userSession: UserSession?
    
    override func getLoggedUser() throws -> User? {
        try! userSession?.getLoggedUser()
    }
    
    override func findTripsByUser(_ user: User) throws -> [Trip]? {
        nil
    }
}

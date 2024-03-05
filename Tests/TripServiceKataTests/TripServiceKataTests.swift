import XCTest
@testable import TripServiceKata

class TripServiceKataTests: XCTestCase {
    
    // starting with getting any output from this TripService class functions
    func test_whenUserNotLoggedIn_throwsError() throws {
        let user = User()        
        XCTAssertThrowsError(try TestableTripService().getTripsByUser(user))
        
    }
    
}

class TestableTripService: TripService {
    override func getLoggedUser() throws -> User? {
        nil
    }
    override func findTripsByUser(_ user: User) throws -> [Trip]? {
        nil
    }
}

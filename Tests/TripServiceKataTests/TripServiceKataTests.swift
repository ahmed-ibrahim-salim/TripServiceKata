import XCTest
@testable import TripServiceKata

class TripServiceKataTests: XCTestCase {
    
    // starting with getting any output from this TripService class functions
    func test_getTripsByUser() throws {
        let user = User()
        let trips = try TripService().getTripsByUser(user)
        
        XCTAssertEqual(trips?.count, 2)
    }
    
}

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

        XCTAssertNoThrow(
            try prepareTripServiceWhenUserIsLoggedIn(user)?.getTripsByUser(user),
            "no message"
        )
    }
    
    func test_AddingAFriend_WhichIsNotTheSameUser_tripsIsNil() throws {
        let user = User()
        let friend1 = User()
        user.addFriend(friend1)
        
        let trips = try prepareTripServiceWhenUserIsLoggedIn(user)?.getTripsByUser(user)
        
        XCTAssertEqual(trips?.count, nil)
    }
    
    func test_AddingAFriend_WhichIsTheSameUser_tripsIsNil() throws {
        let user = User()
        user.addFriend(user)
        let tripService = prepareTripServiceWhenUserIsLoggedIn(user)
    
        
        tripService?.tripDAO = TripDAOMock()
        let trips = try tripService?.getTripsByUser(user)
//
        XCTAssertEqual(trips?.count, 1)
    }
    
}

extension TripServiceKataTests {
    func prepareTripServiceWhenUserIsLoggedIn(_ user: User = User()) -> TestableTripService?{
        tripService?.userSession = UserSessionMock(user: user)
        return tripService
    }
}

class TripDAOMock: TripDAO {
    override class func findTripsByUser(_ user: User) throws -> [Trip]? {
        user.addTrip(Trip())
        return user.trips()
    }
}

class UserSessionMock: UserSession {
    let user: User
    
    init(user: User) {
        self.user = user
    }
    
    override func getLoggedUser() throws -> User? {
        user
    }
    override func isUserLoggedIn(_ user: User) throws -> Bool {
        self.user == user
    }
}

class TestableTripService: TripService {
    var userSession: UserSession?
    var tripDAO: TripDAO?

    override func getLoggedUser() throws -> User? {
        try! userSession?.getLoggedUser()
    }
    
    override func findTripsByUser(_ user: User) throws -> [Trip]? {
        guard tripDAO is TripDAOMock else {
            return try! TripDAO.findTripsByUser(user)
        }
        return try! TripDAOMock.findTripsByUser(user)
        
    }
}

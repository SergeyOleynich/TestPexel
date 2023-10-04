import XCTest

@testable import CustomNetworkService

final class ResponseValidatorTests: XCTestCase {
    func testErrorResponseValidatorForNilError() throws {
        let validator = ErrorResponseValidator()
        XCTAssertNoThrow(try validator.validate(response: nil, error: nil))
    }
    
    func testErrorResponseValidatorForSomeError() throws {
        let validator = ErrorResponseValidator()
        XCTAssertThrowsError(try validator.validate(response: nil, error: URLError.init(.badURL)))
    }
}

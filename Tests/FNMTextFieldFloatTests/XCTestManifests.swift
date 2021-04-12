import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(FNMTextFieldFloatTests.allTests),
    ]
}
#endif

    import XCTest
    @testable import JsJsonDecoderWrapper

    final class JsJsonDecoderWrapperTests: XCTestCase {
        class Posting: Decodable {
            // Property Wrapper를 이용한 프로퍼티
            @JSONDefaultWrapper.EmptyString var stringValue: String
            @JSONDefaultWrapper.True var trueValue: Bool
            @JSONDefaultWrapper.False var falseValue: Bool
            @JSONDefaultWrapper.IntZero var intValue: Int
            @JSONDefaultWrapper.DoubleZero var doubleValue: Double
            @JSONDefaultWrapper.FloatZero var floatValue: Float
            @JSONDefaultWrapper.CGFloatZero var cGFloatValue: CGFloat
            @JSONDefaultWrapper.StringFalse var stringFalseValue: Bool
            @JSONDefaultWrapper.StringTrue var stringTrueValue: Bool
            @JSONDefaultWrapper.TimestampToOptionalDate var dateValue: Date?
            @JSONDefaultWrapper.EmptyList var listValue: [Int]
            @JSONDefaultWrapper.EmptyDict var dictValue: [String:String]
        }
        func testExample() {
                // 전혀 상관없는 JSON 형태의 데이터
            let data = """
                    {
                        "test": 3,
                        "dateValue" : 1626012942
                    }
                    """.data(using: .utf8)!
            
            // Decodable을 이용한 객체 생성
            let object = try! JSONDecoder().decode(Posting.self, from: data)
            
            XCTAssert(object.stringValue == "")
            XCTAssert(object.trueValue == true)
            XCTAssert(object.falseValue == false)
            XCTAssert(object.intValue == 0)
            XCTAssert(object.doubleValue == 0)
            XCTAssert(object.floatValue == 0)
            XCTAssert(object.cGFloatValue == 0)
            XCTAssert(object.stringFalseValue == false)
            XCTAssert(object.stringTrueValue == true)
            XCTAssert(object.dateValue == nil)
            XCTAssert(object.listValue == [])
            XCTAssert(object.dictValue == [:])
        }
    }

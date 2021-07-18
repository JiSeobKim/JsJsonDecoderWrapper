    import XCTest
    @testable import JsJsonDecoderWrapper

    final class JsJsonDecoderWrapperTests: XCTestCase {
        class Posting: Decodable {
            // Property Wrapper를 이용한 프로퍼티
            @JSONDecoderWrapper.EmptyString var stringValue: String
            @JSONDecoderWrapper.True var trueValue: Bool
            @JSONDecoderWrapper.False var falseValue: Bool
            @JSONDecoderWrapper.IntZero var intValue: Int
            @JSONDecoderWrapper.DoubleZero var doubleValue: Double
            @JSONDecoderWrapper.FloatZero var floatValue: Float
            @JSONDecoderWrapper.CGFloatZero var cGFloatValue: CGFloat
            @JSONDecoderWrapper.StringFalse var stringFalseValue: Bool
            @JSONDecoderWrapper.StringTrue var stringTrueValue: Bool
            @JSONDecoderWrapper.TimestampToOptionalDate var dateValue: Date?
            @JSONDecoderWrapper.EmptyList var listValue: [Int]
            @JSONDecoderWrapper.EmptyDict var dictValue: [String:String]
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

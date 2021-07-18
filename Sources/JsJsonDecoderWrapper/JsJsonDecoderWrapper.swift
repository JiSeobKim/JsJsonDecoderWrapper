import Foundation
import UIKit

public protocol JSONDefaultWrapperAvailable {
    associatedtype ValueType: Decodable
    static var defaultValue: ValueType { get }
}

public protocol JSONStringConverterAvailable {
    static var defaultValue: Bool { get }
}

public enum JSONDefaultWrapper {
    public typealias EmptyString = Wrapper<JSONDefaultWrapper.TypeCase.EmptyString>
    public typealias True = Wrapper<JSONDefaultWrapper.TypeCase.True>
    public typealias False = Wrapper<JSONDefaultWrapper.TypeCase.False>
    public typealias IntZero = Wrapper<JSONDefaultWrapper.TypeCase.Zero<Int>>
    public typealias DoubleZero = Wrapper<JSONDefaultWrapper.TypeCase.Zero<Double>>
    public typealias FloatZero = Wrapper<JSONDefaultWrapper.TypeCase.Zero<Float>>
    public typealias CGFloatZero = Wrapper<JSONDefaultWrapper.TypeCase.Zero<CGFloat>>
    public typealias StringFalse = StringConverterWrapper<JSONDefaultWrapper.TypeCase.StringFalse>
    public typealias StringTrue = StringConverterWrapper<JSONDefaultWrapper.TypeCase.StringTrue>
    public typealias EmptyList<T: Decodable & ExpressibleByArrayLiteral> = Wrapper<JSONDefaultWrapper.TypeCase.List<T>>
    public typealias EmptyDict<T: Decodable & ExpressibleByDictionaryLiteral> = Wrapper<JSONDefaultWrapper.TypeCase.Dict<T>>
    
    // Property Wrapper - Optional Type to Type
    @propertyWrapper
    public struct Wrapper<T: JSONDefaultWrapperAvailable> {
        public typealias ValueType = T.ValueType

        public var wrappedValue: ValueType

        public init() {
            wrappedValue = T.defaultValue
        }
    }
    
    // Property Wrapper - Optional String To Bool
    @propertyWrapper
    public struct StringConverterWrapper<T: JSONStringConverterAvailable> {
        public var wrappedValue: Bool = T.defaultValue
        public init() {
            wrappedValue = T.defaultValue
        }
    }
    
    // Property Wrapper - Optional Timestamp to Optinoal Date
    @propertyWrapper
    struct TimestampToOptionalDate {
        public var wrappedValue: Date?
    }
    
    @propertyWrapper
    struct TrueByStringToBool {
        public var wrappedValue: Bool = true
    }
    
    @propertyWrapper
    struct FalseByStringToBool {
        public var wrappedValue: Bool = false
    }

    public enum TypeCase {
        // Type Enums
        public enum True: JSONDefaultWrapperAvailable {
            // 기본값 - true
            public static var defaultValue: Bool { true }
        }

        public enum False: JSONDefaultWrapperAvailable {
            // 기본값 - false
            public static var defaultValue: Bool { false }
        }

        public enum EmptyString: JSONDefaultWrapperAvailable {
            // 기본값 - ""
            public static var defaultValue: String { "" }
        }
        
        public enum Zero<T: Decodable>: JSONDefaultWrapperAvailable where T: Numeric {
            // 기본값 - 0
            public static var defaultValue: T { 0 }
        }
        
        public enum StringFalse: JSONStringConverterAvailable {
            // 기본값 - false
            public static var defaultValue: Bool { false }
        }
        
        public enum StringTrue: JSONStringConverterAvailable {
            // 기본값 - false
            public static var defaultValue: Bool { true }
        }
        
        public enum List<T: Decodable & ExpressibleByArrayLiteral>: JSONDefaultWrapperAvailable {
            // 기본값 - []
            public static var defaultValue: T { [] }
        }
        
        public enum Dict<T: Decodable & ExpressibleByDictionaryLiteral>: JSONDefaultWrapperAvailable {
            // 기본값 - [:]
            public static var defaultValue: T { [:] }
        }
    }
}

extension JSONDefaultWrapper.Wrapper: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.wrappedValue = try container.decode(ValueType.self)
    }
}

extension JSONDefaultWrapper.StringConverterWrapper: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.wrappedValue = (try container.decode(String.self)) == "Y"
    }
}

extension JSONDefaultWrapper.TimestampToOptionalDate: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let timestamp = try container.decode(Double.self)
        let date = Date.init(timeIntervalSince1970: timestamp)
        self.wrappedValue = date
    }
}

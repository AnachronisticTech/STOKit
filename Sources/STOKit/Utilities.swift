@propertyWrapper public struct Clamped<Value: Comparable & Codable>: Codable {
    let range: ClosedRange<Value>
    var value: Value

    public var wrappedValue: Value {
        get { return value }
        set { value = min(max(range.lowerBound, newValue), range.upperBound) }
    }

    public init(wrappedValue value: Value, _ range: ClosedRange<Value>) {
        self.range = range
        self.value = min(max(range.lowerBound, value), range.upperBound)
    }
}

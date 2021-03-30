public struct ConsoleArray<C: Console> {
    public typealias Consoles = [C?]

    private var consoles: Consoles

    public init(size: Int) {
        @Clamped(0...5) var _size = size
        self.consoles = Array(repeating: nil, count: _size)
    }

    public subscript(index: Int) -> C? {
        get {
            guard (0..<consoles.count).contains(index) else { return nil }
            return consoles[index]
        }
        set {
            guard (0..<consoles.count).contains(index) else { return }
            consoles[index] = newValue
        }
    }
}

extension ConsoleArray: CustomStringConvertible {
    public var description: String {
        return consoles
            .map { console in
                if let console = console { return "\(console)" }
                return "Empty"
            }
            .joined(separator: ", ")
    }
}

internal enum ConsoleArrayCodingKeys: String, CodingKey, CaseIterable {
    case slot1, slot2, slot3, slot4, slot5
}

extension ConsoleArray: Codable {

    public init(from decoder: Decoder) throws {
        fatalError("Not yet implemented")
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: ConsoleArrayCodingKeys.self)
        for (index, console) in consoles.enumerated() {
            let key = ConsoleArrayCodingKeys.allCases.filter({ $0.rawValue.contains("\(index+1)") }).first!
            if let console = console {
                switch console {
                    case is EngineeringConsole:
                        try container.encode(console as! EngineeringConsole, forKey: key)
                    default:
                        try container.encodeNil(forKey: key)
                }
            } else {
                try container.encodeNil(forKey: key)
            }
        }
    }
}

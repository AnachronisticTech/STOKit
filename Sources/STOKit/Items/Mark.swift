public protocol Markable {
    var mark: Mark { get }
}

public enum Mark: String, Codable, CustomStringConvertible {
    case I, II, III, IV, V
    case VI, VII, VIII, IX, X
    case XI, XII, XIII, XIV, XV
    case Standard = ""
    case SmallCraft = "SC"
    case Infinity = "∞"

    public var description: String {
        switch self {
            case .Standard: return "Standard Issue"
            case .SmallCraft: return "(Small Craft)"
            case .Infinity: return "Mk ∞"
            default: return "Mk \(rawValue)"
        }
    }
}

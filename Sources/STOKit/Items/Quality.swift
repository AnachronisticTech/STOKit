public enum Quality: String, CustomStringConvertible, Codable {
    case Common, Uncommon, Rare
    case VeryRare, UltraRare, Epic

    public var description: String {
        switch self {
            case .VeryRare: return "Very Rare"
            case .UltraRare: return "Ultra Rare"
            default: return rawValue
        }
    }
}

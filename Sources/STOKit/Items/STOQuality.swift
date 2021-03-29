public enum STOQuality: String, CustomStringConvertible, Codable {
    case Common, Uncommon, Rare
    case VeryRare, UltraRare, Epic

    public var description: String {
        switch self {
            case .Common, .Uncommon, .Rare, .Epic: return self.rawValue
            case .VeryRare: return "Very Rare"
            case .UltraRare: return "Ultra Rare"
        }
    }
}

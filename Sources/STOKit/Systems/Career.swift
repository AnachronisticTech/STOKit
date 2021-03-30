public enum Career: String, Codable {
    case Tactical, Engineering, Science
}

extension Career: CustomStringConvertible {
    public var description: String {
        return "\(self.rawValue) Officer"
    }
}

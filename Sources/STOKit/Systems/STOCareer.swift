public enum STOCareer: String, Codable {
    case Tactical, Engineering, Science
}

extension STOCareer: CustomStringConvertible {
    public var description: String {
        return "\(self.rawValue) Officer"
    }
}

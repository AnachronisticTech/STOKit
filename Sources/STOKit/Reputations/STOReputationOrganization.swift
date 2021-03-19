public enum STOReputationOrganization: String, CaseIterable, Codable {
    case Omega = "Task Force Omega"
    case Nukara = "Nukara Strikeforce"
    case NewRomulus = "New Romulus"
    case Dyson = "Dyson Joint Command"
    case Undine = "8472 Counter Command"
    case Delta = "Delta Alliance"
    case Iconian = "Iconian Resistance"
    case Terran = "Terran Task Force"
    case Temporal = "Temporal Defense Initiative"
    case Lukari = "Lukari Restoration Initiative"
    case Competitive = "Competitive Wargames"
    case Gamma = "Gamma Task Force"
    case Discovery = "Discovery Legends"

    internal var order: Int {
        switch self {
            case .Omega: return 0
            case .Nukara: return 1
            case .NewRomulus: return 2
            case .Dyson: return 3
            case .Undine: return 4
            case .Delta: return 5
            case .Iconian: return 6
            case .Terran: return 7
            case .Temporal: return 8
            case .Lukari: return 9
            case .Competitive: return 10
            case .Gamma: return 11
            case .Discovery: return 12
        }
    }
}

extension STOReputationOrganization: CustomStringConvertible {
    public var description: String {
        return self.rawValue
    }
}

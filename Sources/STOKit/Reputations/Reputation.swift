public struct Reputation {
    public let organization: ReputationOrganization

    @Clamped(0...250000) public var xp: Int = 0
    
    public var tier: Int {
        get {
            if xp == 250000 { return 6 }
            else if xp >= 100000 { return 5 }
            else if xp >= 60000 { return 4 }
            else if xp >= 32500 { return 3 }
            else if xp >= 15000 { return 2 }
            else if xp >= 5000 { return 1 }
            else { return 0 }
        }
    }

    public init(organization: ReputationOrganization, xp: Int = 0) {
        self.organization = organization
        self.xp = xp
    }

    public mutating func set(xp: Int) {
        self.xp = xp
    }
}

extension Reputation: Codable {
    enum CodingKeys: String, CodingKey {
        case org = "organization"
        case xp
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.organization = try container.decode(ReputationOrganization.self, forKey: .org)
        self.xp = try container.decode(Int.self, forKey: .xp)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(organization, forKey: .org)
        try container.encode(xp, forKey: .xp)
    }
}

extension Reputation: Comparable {
    public static func <(lhs: Reputation, rhs: Reputation) -> Bool {
        return lhs.organization.order < rhs.organization.order
    }
}

extension Reputation: Equatable {
    public static func ==(lhs: Reputation, rhs: Reputation) -> Bool {
        return lhs.organization == rhs.organization && lhs.xp == rhs.xp
    }
}

extension Reputation: CustomStringConvertible {
    public var description: String {
        return "\(organization): Tier \(tier) (\(xp) xp)"
    }
}

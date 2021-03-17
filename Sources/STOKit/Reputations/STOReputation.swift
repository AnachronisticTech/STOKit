public struct STOReputation: Codable {
    public let organization: STOReputationOrganization

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

    enum CodingKeys: String, CodingKey {
        case org = "organization"
        case xp
    }

    public init(organization: STOReputationOrganization, xp: Int = 0) {
        self.organization = organization
        self.xp = xp
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.organization = try container.decode(STOReputationOrganization.self, forKey: .org)
        self.xp = try container.decode(Int.self, forKey: .xp)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(organization, forKey: .org)
        try container.encode(xp, forKey: .xp)
    }
}
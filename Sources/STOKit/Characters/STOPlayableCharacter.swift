public struct STOPlayableCharacter: STOCharacter {
    public private(set) var name: String
    public private(set) var faction: STOFaction
    public private(set) var journal: STOJournal
    public private(set) var reputations: STOReputationCollection

    public init(name: String, faction: STOFaction) {
        self.name = name
        self.faction = faction
        self.journal = STOJournal(faction: faction)
        self.reputations = STOReputationCollection()
    }

    enum CodingKeys: CodingKey {
        case name, faction, journal, reputations
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.faction = try container.decode(STOFaction.self, forKey: .faction)
        self.journal = try container.decode(STOJournal.self, forKey: .journal)

        var reps = try container.nestedUnkeyedContainer(forKey: .reputations)
        try self.reputations = STOReputationCollection(
            STOReputationOrganization.allCases.map { _ in
                try reps.decode(STOReputation.self)
            }
        )
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(faction, forKey: .faction)
        try container.encode(journal, forKey: .journal)

        var reps = container.nestedUnkeyedContainer(forKey: .reputations)
        try reputations.forEach { reputation in
            try reps.encode(reputation)
        }
    }
}

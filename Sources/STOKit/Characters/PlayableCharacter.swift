import Foundation

public struct PlayableCharacter: Character {
    public let identifier: UUID

    public private(set) var name: String
    public private(set) var faction: Faction
    public private(set) var career: Career

    public var journal: Journal
    public var reputations: ReputationCollection
    public var bridgeOfficers: [BridgeOfficer]
    public var inventory: Inventory

    public init(name: String, faction: Faction, career: Career) {
        self.identifier = UUID()
        self.name = name
        self.faction = faction
        self.career = career
        self.journal = Journal(faction: faction)
        self.reputations = ReputationCollection()
        self.bridgeOfficers = []
        self.inventory = Inventory()
    }

    enum CodingKeys: String, CodingKey {
        case name, faction, career
        case journal, reputations, bridgeOfficers
        case inventory
        case identifier = "id"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.identifier = try container.decode(UUID.self, forKey: .identifier)
        self.name = try container.decode(String.self, forKey: .name)
        self.faction = try container.decode(Faction.self, forKey: .faction)
        self.career = try container.decode(Career.self, forKey: .career)
        self.journal = try container.decode(Journal.self, forKey: .journal)

        var reps = try container.nestedUnkeyedContainer(forKey: .reputations)
        try self.reputations = ReputationCollection(
            ReputationOrganization.allCases.map { _ in
                try reps.decode(Reputation.self)
            }
        )

        var bridgeOfficerContainer = try container.nestedUnkeyedContainer(forKey: .bridgeOfficers)
        var bridgeOfficers = [BridgeOfficer]()
        while !bridgeOfficerContainer.isAtEnd {
            let identifier = try bridgeOfficerContainer.decode(UUID.self)
            guard let officer = BridgeOfficer.load(with: identifier) else { continue }
            guard self.faction.permittedOfficerFactions.contains(officer.faction) else { continue }
            bridgeOfficers.append(officer)
        }
        self.bridgeOfficers = bridgeOfficers
        self.inventory = try container.decode(Inventory.self, forKey: .inventory)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(identifier, forKey: .identifier)
        try container.encode(name, forKey: .name)
        try container.encode(faction, forKey: .faction)
        try container.encode(career, forKey: .career)
        try container.encode(journal, forKey: .journal)

        var reps = container.nestedUnkeyedContainer(forKey: .reputations)
        try reputations.forEach { reputation in
            try reps.encode(reputation)
        }

        var boffs = container.nestedUnkeyedContainer(forKey: .bridgeOfficers)
        try bridgeOfficers.forEach { officer in
            try boffs.encode(officer.identifier)
        }

        try container.encode(inventory, forKey: .inventory)
    }
    
    public var description: String {
        return "\(name) - \(faction) \(career)"
    }
}

extension PlayableCharacter {
    public func save() {
        let directoryURL = URL(string: "file:///\(FileManager.default.currentDirectoryPath)")!
            .appendingPathComponent("Output")
            .appendingPathComponent("Characters")
        if !FileManager.default.fileExists(atPath: directoryURL.path) {
            try! FileManager.default.createDirectory(at: directoryURL, withIntermediateDirectories: true)
        }
        let fileURL = directoryURL.appendingPathComponent("\(name).json")
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(self)
            try data.write(to: fileURL)
        } catch {
            print(error)
        }
    }

    public static func load(_ name: String) -> PlayableCharacter? {
        let fileURL = URL(string: "file:///\(FileManager.default.currentDirectoryPath)")!
            .appendingPathComponent("Output")
            .appendingPathComponent("Characters")
            .appendingPathComponent("\(name).json")
        if !FileManager.default.fileExists(atPath: fileURL.path) { return nil }
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(PlayableCharacter.self, from: try Data(contentsOf: fileURL))
        } catch {
            print(error)
            return nil
        }
    }
}

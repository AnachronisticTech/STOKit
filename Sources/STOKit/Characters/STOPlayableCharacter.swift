import Foundation

public struct STOPlayableCharacter: STOCharacter {
    public let identifier: UUID

    public private(set) var name: String
    public private(set) var faction: STOFaction
    public private(set) var career: STOCareer

    public var journal: STOJournal
    public var reputations: STOReputationCollection
    public var bridgeOfficers: [STOBridgeOfficer]

    public init(name: String, faction: STOFaction, career: STOCareer) {
        self.identifier = UUID()
        self.name = name
        self.faction = faction
        self.career = career
        self.journal = STOJournal(faction: faction)
        self.reputations = STOReputationCollection()
        self.bridgeOfficers = []
    }

    enum CodingKeys: String, CodingKey {
        case name, faction, career, journal, reputations, bridgeOfficers
        case identifier = "id"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.identifier = try container.decode(UUID.self, forKey: .identifier)
        self.name = try container.decode(String.self, forKey: .name)
        self.faction = try container.decode(STOFaction.self, forKey: .faction)
        self.career = try container.decode(STOCareer.self, forKey: .career)
        self.journal = try container.decode(STOJournal.self, forKey: .journal)

        var reps = try container.nestedUnkeyedContainer(forKey: .reputations)
        try self.reputations = STOReputationCollection(
            STOReputationOrganization.allCases.map { _ in
                try reps.decode(STOReputation.self)
            }
        )

        var bridgeOfficerContainer = try container.nestedUnkeyedContainer(forKey: .bridgeOfficers)
        var bridgeOfficers = [STOBridgeOfficer]()
        while !bridgeOfficerContainer.isAtEnd {
            let identifier = try bridgeOfficerContainer.decode(UUID.self)
            guard let officer = STOBridgeOfficer.load(with: identifier) else { continue }
            guard self.faction.permittedOfficerFactions.contains(officer.faction) else { continue }
            bridgeOfficers.append(officer)
        }
        self.bridgeOfficers = bridgeOfficers
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
    }
}

extension STOPlayableCharacter: CustomStringConvertible {
    public var description: String {
        return "\(name) - \(faction) \(career)"
    }
}

extension STOPlayableCharacter {
    public func save() {
        let directoryURL = URL(string: "file:///\(FileManager.default.currentDirectoryPath)")!
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

    public static func load(_ name: String) -> STOPlayableCharacter? {
        let fileURL = URL(string: "file:///\(FileManager.default.currentDirectoryPath)")!
            .appendingPathComponent("Characters")
            .appendingPathComponent("\(name).json")
        if !FileManager.default.fileExists(atPath: fileURL.path) { return nil }
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(STOPlayableCharacter.self, from: try Data(contentsOf: fileURL))
        } catch {
            print(error)
            return nil
        }
    }
}

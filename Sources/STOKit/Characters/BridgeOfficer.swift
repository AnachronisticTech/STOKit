import Foundation

public struct BridgeOfficer: Character {
    public let identifier: UUID

    public private(set) var name: String
    public private(set) var faction: Faction
    public private(set) var career: Career

    public init(name: String, faction: Faction, career: Career) {
        self.identifier = UUID()
        self.name = name
        self.faction = faction
        self.career = career
    }

    @available(*, deprecated, message: "For development use only")
    public init(name: String, faction: Faction, career: Career, _ uuidString: String? = nil) {
        if let uuidString = uuidString {
            self.identifier = UUID(uuidString: uuidString)!
        } else {
            self.identifier = UUID()
        }
        self.name = name
        self.faction = faction
        self.career = career
    }

    enum CodingKeys: String, CodingKey {
        case name, faction, career
        case identifier = "id"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.identifier = try container.decode(UUID.self, forKey: .identifier)
        self.name = try container.decode(String.self, forKey: .name)
        self.faction = try container.decode(Faction.self, forKey: .faction)
        self.career = try container.decode(Career.self, forKey: .career)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(identifier, forKey: .identifier)
        try container.encode(name, forKey: .name)
        try container.encode(faction, forKey: .faction)
        try container.encode(career, forKey: .career)
    }
    
    public var description: String {
        return "\(name) - \(faction) \(career)"
    }
}

extension BridgeOfficer {
    public func save() {
        let directoryURL = URL(string: "file:///\(FileManager.default.currentDirectoryPath)")!
            .appendingPathComponent("Output")
            .appendingPathComponent("BridgeOfficers")
        if !FileManager.default.fileExists(atPath: directoryURL.path) {
            try! FileManager.default.createDirectory(at: directoryURL, withIntermediateDirectories: true)
        }
        let fileURL = directoryURL.appendingPathComponent("\(identifier).json")
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(self)
            try data.write(to: fileURL)
        } catch {
            print(error)
        }
    }

    public static func load(with identifier: UUID) -> BridgeOfficer? {
        let fileURL = URL(string: "file:///\(FileManager.default.currentDirectoryPath)")!
            .appendingPathComponent("Output")
            .appendingPathComponent("BridgeOfficers")
            .appendingPathComponent("\(identifier).json")
        if !FileManager.default.fileExists(atPath: fileURL.path) { return nil }
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(BridgeOfficer.self, from: try Data(contentsOf: fileURL))
        } catch {
            print(error)
            return nil
        }
    }
}
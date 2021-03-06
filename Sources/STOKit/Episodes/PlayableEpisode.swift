import struct Foundation.UUID

public class PlayableEpisode: Episode {
    public var played: Bool

    public init(episode: Episode, played: Bool) {
        self.played = played
        super.init(name: episode.name, arc: episode.arc, number: episode.number, id: episode.id)
    }

    public init(name: String, arc: StoryArc, number: Int, id: UUID, played: Bool) {
        self.played = played
        super.init(name: name, arc: arc, number: number, id: id)
    }
    
    enum CodingKeys: CodingKey {
        case name, arc, number, id, played
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.played = try container.decode(Bool.self, forKey: .played)
        super.init(
            name: try container.decode(String.self, forKey: .name),
            arc: try container.decode(StoryArc.self, forKey: .arc),
            number: try container.decode(Int.self, forKey: .number),
            id: try container.decode(UUID.self, forKey: .id)
        )
    }

    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(arc, forKey: .arc)
        try container.encode(number, forKey: .number)
        try container.encode(id, forKey: .id)
        try container.encode(played, forKey: .played)
    }

    public override var description: String {
        return "\(super.description) (\(played ? "" : "not ")played)"
    }
}

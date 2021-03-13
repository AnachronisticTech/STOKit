public struct STOPlayableCharacter: STOCharacter {
    public private(set) var faction: STOFaction
    public private(set) var name: String
    public private(set) var journal: STOJournal

    public init(name: String, faction: STOFaction) {
        self.name = name
        self.faction = faction
        self.journal = STOJournal(faction: faction)
    }
}

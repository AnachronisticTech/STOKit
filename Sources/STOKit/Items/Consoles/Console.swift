internal protocol ConsoleBase {}

open class Console: Item, ConsoleBase, Markable {
    public var mark: Mark

    init(mark: Mark, quality: Quality) {
        self.mark = mark
        super.init(quality: quality)
    }

    public required init(from decoder: Decoder) throws {
        fatalError("You cannot instantiate an abstract console")
    }

    internal override class func decode(container: KeyedDecodingContainer<Keys>) -> Self? {
        guard let className = try? container.decode(String.self, forKey: .class) else { return nil }

        if
            EngineeringConsole.specialTypes[className] != nil,
            let item = EngineeringConsole.decode(container: container) as? Self
        {
            return item
        } else if
            ScienceConsole.specialTypes[className] != nil,
            let item = ScienceConsole.decode(container: container) as? Self
        {
            return item
        } else if
            TacticalConsole.specialTypes[className] != nil,
            let item = TacticalConsole.decode(container: container) as? Self
        {
            return item
        }

        return nil
    }
}

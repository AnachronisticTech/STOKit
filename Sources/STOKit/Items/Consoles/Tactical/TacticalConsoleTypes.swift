extension TacticalConsole {
    internal static let specialTypes: [String: TacticalConsole.Type] = {
        return _specialTypes.reduce([String: TacticalConsole.Type]()) { (dict, type) -> [String: TacticalConsole.Type] in
            var dict = dict
            dict[String(describing: type.self)] = type.self
            return dict
        }
    }()
    private static let _specialTypes: [TacticalConsole.Type] = [
        PhaserRelay.self
    ]
}

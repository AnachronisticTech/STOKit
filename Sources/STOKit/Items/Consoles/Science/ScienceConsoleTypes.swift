extension ScienceConsole {
    internal static let specialTypes: [String: ScienceConsole.Type] = {
        return _specialTypes.reduce([String: ScienceConsole.Type]()) { (dict, type) -> [String: ScienceConsole.Type] in
            var dict = dict
            dict[String(describing: type.self)] = type.self
            return dict
        }
    }()
    private static let _specialTypes: [ScienceConsole.Type] = [
        FieldGenerator.self
    ]
}

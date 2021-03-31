extension EngineeringConsole {
    internal static let specialTypes: [String: EngineeringConsole.Type] = {
        return _specialTypes.reduce([String: EngineeringConsole.Type]()) { (dict, type) -> [String: EngineeringConsole.Type] in
            var dict = dict
            dict[String(describing: type.self)] = type.self
            return dict
        }
    }()
    private static let _specialTypes: [EngineeringConsole.Type] = [
        NeutroniumAlloy.self
    ]
}

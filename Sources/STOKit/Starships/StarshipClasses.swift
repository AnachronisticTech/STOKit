extension Starship {
    internal static let specialTypes: [String: Starship.Type] = {
        return _specialTypes.reduce([String: Starship.Type]()) { (dict, type) -> [String: Starship.Type] in
            var dict = dict
            dict[String(describing: type.self)] = type.self
            return dict
        }
    }()
    
    private static let _specialTypes: [Starship.Type] = [
        LightCruiser.self,
        AssaultCruiser.self,
        FleetImperialIntelAssaultCruiserT6.self
    ]
}

extension Deflector {
    internal static let specialTypes: [String: Deflector.Type] = {
        return _specialTypes.reduce([String: Deflector.Type]()) { (dict, type) -> [String: Deflector.Type] in
            var dict = dict
            dict[String(describing: type.self)] = type.self
            return dict
        }
    }()
    private static let _specialTypes: [Deflector.Type] = [
        PositronDeflector.self
    ]
}

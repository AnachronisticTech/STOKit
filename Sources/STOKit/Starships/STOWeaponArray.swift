public struct STOWeaponArray {
    public typealias Weapons = [STOWeapon?]

    private var weapons: Weapons

    public init(size: Int) {
        @Clamped(0...5) var _size = size
        self.weapons = Array(repeating: nil, count: _size)
    }

    public subscript(index: Int) -> STOWeapon? {
        get {
            guard (0..<weapons.count).contains(index) else { return nil }
            return weapons[index]
        }
        set {
            guard (0..<weapons.count).contains(index) else { return }
            weapons[index] = newValue
        }
    }
}

extension STOWeaponArray: CustomStringConvertible {
    public var description: String {
        return weapons
            .map { weapon in
                if let weapon = weapon { return "\(weapon)" }
                return "Empty"
            }
            .joined(separator: ", ")
    }
}

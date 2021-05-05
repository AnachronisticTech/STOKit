public struct Inventory {
    public typealias Items = [Item?]

    private var items: Items

    public init(size: Int = 72) {
        @Clamped(72...216) var _size = size
        items = Array(repeating: nil, count: _size)
    }

    public subscript(index: Int) -> Item? {
        get {
            guard (0..<items.count).contains(index) else { return nil }
            return items[index]
        }
        set {
            guard (0..<items.count).contains(index) else { return }
            items[index] = newValue
        }
    }
}

extension Inventory: CustomStringConvertible {
    public var description: String {
        return items
            .compactMap { item in
                guard let item = item else { return nil }
                return "\(item)"
            }
            .joined(separator: "\n\t")
    }
}

extension Inventory: Codable {
    enum CodingKeys: CodingKey {
        case size
        case items
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.items = Array(repeating: nil, count: try container.decode(Int.self, forKey: .size))
        var itemsContainer = try container.nestedUnkeyedContainer(forKey: .items)
        var counter = 0
        while !itemsContainer.isAtEnd {
            if try itemsContainer.decodeNil() {
                counter += 1
                continue
            }

            let itemContainer = try itemsContainer.nestedContainer(keyedBy: ItemCodingKeys.self)
            self.items[counter] = Item.decode(container: itemContainer)
            counter += 1
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(items.count, forKey: .size)
        try container.encode(items, forKey: .items)
    }
}

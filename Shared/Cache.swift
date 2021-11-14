//
// Created by Mattia Righetti on 13/06/21.
//

// Credit - https://github.com/mattrighetti/HNReaderApp/blob/95ea9fa0dfd8598d79f864e9b347dfdb5a363f92/HNReader/HNClient/ItemCache.swift#L16-L30
// Used under the MIT License
import Foundation

class StructWrapper<T>: NSObject {
    let value: T

    init(_ _struct: T) {
        value = _struct
    }
}


class ItemCache: NSCache<NSString, StructWrapper<Any>> {
    static let shared = ItemCache()

    func cache(_ item: Any, for key: Int) {
        let keyString = NSString(format: "%d", key)
        let itemWrapper = StructWrapper(item)
        self.setObject(itemWrapper, forKey: keyString)
    }

    func getItem(for key: Int) -> Any? {
        let keyString = NSString(format: "%d", key)
        let itemWrapper = self.object(forKey: keyString)
        return itemWrapper?.value
    }
}

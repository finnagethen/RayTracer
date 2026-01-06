import Foundation

class PPMExporter: Exporter {
    static func export(image: Image, toFile path: String) {
        let url = URL(fileURLWithPath: path)

        let header = "P3\n\(image.width) \(image.height)\n255\n"
        try! header.write(to: url, atomically: true, encoding: .utf8)

        let fileHandle = try! FileHandle(forWritingTo: url)
        defer {
            fileHandle.closeFile()
        }

        for y in 0..<image.height {
            var row = ""
            for x in 0..<image.width {
                let pixel = image.getPixel(x: x, y: y)
                let rgb255 = pixel.clamp01().scale(scalar: 255.0)
                row += " \(Int(rgb255.x)) \(Int(rgb255.y)) \(Int(rgb255.z))"
            }
            row += "\n"
            
            let data = row.data(using: .utf8)!
            fileHandle.seekToEndOfFile()
            fileHandle.write(data)
        }
    }
}

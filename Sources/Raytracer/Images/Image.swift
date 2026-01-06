class Image {
    let width: Int
    let height: Int
    var pixels: [Vec3]

    init(width: Int, height: Int) {
        self.width = width
        self.height = height
        self.pixels = Array(repeating: Vec3(), count: width * height)
    }

    private func toIndex(_ x: Int, _ y: Int) -> Int {
        assert(x >= 0 && x < width, "x is out of bounds")
        assert(y >= 0 && y < height, "y is out of bounds")

        return y * width + x
    }

    func setPixel(x: Int, y: Int, color: Vec3) {
        let index = toIndex(x, y)
        pixels[index] = color
    }

    func getPixel(x: Int, y: Int) -> Vec3 {
        let index = toIndex(x, y)
        return pixels[index]
    }
}

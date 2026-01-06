@main
struct Raytracer {
    static func main() {
        print("Hello, world!")

        let image = Image(width: 640, height: 400)
        let aspectRatio = Double(image.width) / Double(image.height)

        let camera = Camera(position: Vec3(0.0, 0.0, -5.0))
        let scene = Scene(
            objects: [
                Sphere(center: Vec3(), radius: 1.0, material: BasicMaterial(color: Vec3(1.0, 0.0, 0.0))),
                Plane(offset: Vec3(0.0, -1.0, 0.0), normal: Vec3(0.0, 1.0, 0.0), material: BasicMaterial(color: Vec3(1.0, 1.0, 0.0)))
            ],
            lights: [
                Sphere(center: Vec3(5.0, 5.0, -5.0), radius: 1.0, material: LightMaterial(color: Vec3(1.0, 1.0, 1.0)))
            ]
        )

        for y in 0..<image.height {
            for x in 0..<image.width {
                let u = (Double(x) / Double(image.width)) * 2.0 - 1.0
                let v = -((Double(y) / Double(image.height)) * 2.0 - 1.0) / aspectRatio // flip v to match image coordinates and adjust for aspect ratio

                let ray = camera.getRay(u: u, v: v)
                let color = trace(ray: ray, scene: scene)
                image.setPixel(x: x, y: y, color: color)
            }
        }

        PPMExporter.export(image: image, toFile: "./output.ppm")
    }

    static func isInShadow(point: Vec3, light: Sphere, scene: Scene) -> Bool {
        let epsilon = 1e-5

        let directionToLight = light.center.sub(other: point).normalized()
        let shadowRayOrigin = point.add(other: directionToLight.scale(scalar: epsilon)) // offset to avoid self-intersection
        let shadowRay = Ray(origin: shadowRayOrigin, direction: directionToLight)

        if let shadowIntersection = scene.closestIntersection(ray: shadowRay) {
            let lightDistance = light.center.sub(other: point).length()
            if shadowIntersection.distance < lightDistance {
                return true
            }
        }

        return false    
    }

    static func trace(ray: Ray, scene: Scene) -> Vec3 {
        let backgroundColor = Vec3(0.0, 0.0, 1.0)

        if let intersection = scene.closestIntersection(ray: ray) {
            var color = Vec3()
            
            // trace shadow rays
            for light in scene.lights {
                if !isInShadow(point: intersection.point, light: light, scene: scene) {
                    let directionToLight = light.center.sub(other: intersection.point).normalized()
                    let lightIntensity = max(0.0, intersection.normal.dot(other: directionToLight))
                    color = color.add(other: light.material.emit().scale(scalar: lightIntensity))
                }    
            }

            return color.mult(other: intersection.material.color)
        }

        return backgroundColor  
    }
 }

import AppKit

// Rendering uses macOS frameworks only; no package installation is required.
let root = URL(fileURLWithPath: #filePath).deletingLastPathComponent().deletingLastPathComponent()
let usage = """
Usage:
  ./scripts/export-images.sh screenshot.png [name]
  ./scripts/export-images.sh --simulator [name] [--device device-UDID]

Writes the same PNG into docs/assets/ and website/public/screens/:
<name>.png, or simulator-framed.png when no name is supplied.
The .png extension is optional. No image is written into the repository root.
Uses docs/assets/iphone-frame.png. Existing exports with the same name are replaced.
Input must be an unframed portrait screenshot. Simulator capture does not navigate
the app or change its data. With multiple simulators, use --device device-UDID.
The supplied frame's baked-in light status bar is retained.
"""

enum ExportError: LocalizedError {
    case message(String)
    var errorDescription: String? {
        switch self { case .message(let text): return text }
    }
}

func load(_ url: URL) throws -> CGImage {
    guard let source = CGImageSourceCreateWithURL(url as CFURL, nil),
          let image = CGImageSourceCreateImageAtIndex(source, 0, nil) else {
        throw ExportError.message("Cannot read image: \(url.path)")
    }
    return image
}

func render(width: Int, height: Int, draw: (CGContext) -> Void) throws -> CGImage {
    guard let context = CGContext(data: nil, width: width, height: height,
                                  bitsPerComponent: 8, bytesPerRow: 0,
                                  space: CGColorSpace(name: CGColorSpace.sRGB)!,
                                  bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue) else {
        throw ExportError.message("Cannot create image canvas.")
    }
    context.interpolationQuality = .high
    draw(context)
    guard let image = context.makeImage() else {
        throw ExportError.message("Cannot render image.")
    }
    return image
}

func pngData(_ image: CGImage) throws -> Data {
    guard let data = NSBitmapImageRep(cgImage: image).representation(using: .png, properties: [:]) else {
        throw ExportError.message("Cannot encode the exported PNG.")
    }
    return data
}

func capture(device: String, to url: URL) throws {
    let process = Process()
    process.executableURL = URL(fileURLWithPath: "/usr/bin/xcrun")
    process.arguments = ["simctl", "io", device, "screenshot", "--type=png", url.path]
    try process.run()
    process.waitUntilExit()
    guard process.terminationStatus == 0 else {
        throw ExportError.message("Simulator capture failed. Start a simulator and show the desired app screen first.")
    }
}

// Coordinates measured for the supplied 1319 × 2748 iphone-frame.png.
// Core Graphics uses a bottom-left origin. The display starts 64 px from the top.
func frameScreenshot(_ screenshot: CGImage, frame: CGImage) throws -> CGImage {
    guard frame.width == 1319, frame.height == 2748 else {
        throw ExportError.message("docs/assets/iphone-frame.png must be 1319 × 2748; update the display geometry for a different frame.")
    }
    guard screenshot.height > screenshot.width else {
        throw ExportError.message("Use a portrait screenshot without an existing device frame.")
    }
    let display = CGRect(x: 57, y: 62, width: 1206, height: 2622)
    let ratio = CGFloat(screenshot.width) / CGFloat(screenshot.height)
    guard abs(ratio / (display.width / display.height) - 1) < 0.03 else {
        throw ExportError.message("Screenshot aspect ratio does not match this frame. Use a matching portrait iPhone simulator (for example iPhone 17 Pro).")
    }
    return try render(width: frame.width, height: frame.height) { context in
        context.saveGState()
        context.addPath(CGPath(roundedRect: display, cornerWidth: 200, cornerHeight: 200, transform: nil))
        context.clip()
        // Aspect-fill preserves proportions; small device-ratio differences crop at the edges.
        let scale = max(display.width / CGFloat(screenshot.width), display.height / CGFloat(screenshot.height))
        let size = CGSize(width: CGFloat(screenshot.width) * scale, height: CGFloat(screenshot.height) * scale)
        context.draw(screenshot, in: CGRect(x: display.midX - size.width / 2,
                                            y: display.midY - size.height / 2,
                                            width: size.width, height: size.height))
        context.restoreGState()
        context.draw(frame, in: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
    }
}


do {
    let arguments = Array(CommandLine.arguments.dropFirst())
    if arguments.isEmpty || arguments.contains("--help") || arguments.contains("-h") {
        print(usage)
        exit(0)
    }
    var remaining = Array(arguments.dropFirst())
    var device = "booted"
    let simulator = arguments.first == "--simulator"
    if let index = remaining.firstIndex(of: "--device") {
        guard simulator, index + 1 < remaining.count else { throw ExportError.message(usage) }
        device = remaining[index + 1]
        remaining.removeSubrange(index...(index + 1))
    }
    guard remaining.count <= 1,
          !remaining.contains(where: { $0.hasPrefix("--") }),
          simulator || !arguments[0].hasPrefix("--") else {
        throw ExportError.message(usage)
    }
    let name = remaining.first ?? "simulator-framed"
    guard !name.isEmpty, name != ".", name != "..", !name.contains("/"),
          !name.contains("\\"), !name.contains("\0") else {
        throw ExportError.message("Specify a filename without directory components.")
    }
    let filename = name.lowercased().hasSuffix(".png") ? name : "\(name).png"
    let outputs = ["docs/assets", "website/public/screens"].map {
        root.appendingPathComponent($0).appendingPathComponent(filename)
    }
    let frameURL = root.appendingPathComponent("docs/assets/iphone-frame.png")
    guard !outputs.contains(where: { $0.path.lowercased() == frameURL.path.lowercased() }) else {
        throw ExportError.message("The export must not overwrite the iPhone frame.")
    }
    let frame = try load(frameURL)
    var temporaryCapture: URL?
    defer { if let temporaryCapture { try? FileManager.default.removeItem(at: temporaryCapture) } }
    let input: URL
    if simulator {
        let temporary = FileManager.default.temporaryDirectory.appendingPathComponent("borrowback-\(UUID().uuidString).png")
        temporaryCapture = temporary
        try capture(device: device, to: temporary)
        input = temporary
    } else {
        input = URL(fileURLWithPath: arguments[0]).standardizedFileURL
    }
    guard !outputs.contains(input) else {
        throw ExportError.message("Input and export paths must differ.")
    }
    let phone = try frameScreenshot(load(input), frame: frame)
    let data = try pngData(phone)
    for output in outputs {
        try FileManager.default.createDirectory(at: output.deletingLastPathComponent(), withIntermediateDirectories: true)
        try data.write(to: output, options: .atomic)
        print("Exported \(output.path)")
    }
} catch {
    fputs("Error: \(error.localizedDescription)\n", stderr)
    exit(1)
}

import PackageDescription

let package = Package(
    name: "GlossSerializer",
	dependencies: [
		.Package(url: "https://github.com/randymarsh77/wkinterop", majorVersion: 0),
		.Package(url: "https://github.com/hkellaway/gloss", majorVersion: 1),
		]
)

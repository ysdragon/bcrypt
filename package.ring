aPackageInfo = [
	:name = "Ring Bcrypt",
	:description = "A Ring language binding for the bcrypt password hashing algorithm.",
	:folder = "bcrypt",
	:developer = "ysdragon",
	:email = "",
	:license = "MIT License",
	:version = "1.0.1",
	:ringversion = "1.27",
	:versions = 	[
		[
			:version = "1.0.1",
			:branch = "master"
		]
	],
	:libs = 	[
		[
			:name = "ringopenssl",
			:version = "1.0.9",
			:providerusername = "ringpackages"
		]
	],
	:files = 	[
		"lib.ring",
		"main.ring",
		".clang-format",
		"CMakeLists.txt",
		"LICENSE",
		"README.md",
		"examples/01_basic_hashing.ring",
		"examples/02_password_verification.ring",
		"examples/03_security_levels.ring",
		"examples/04_hash_inspection.ring",
		"examples/05_user_registration.ring",
		"examples/06_password_update.ring",
		"examples/07_salt_uniqueness.ring",
		"examples/08_error_handling.ring",
		"src/bcrypt.ring",
		"src/bcrypt_test.ring",
		"src/c_src/bcrypt.c",
		"src/c_src/blf.h",
		"src/c_src/blowfish.c",
		"src/c_src/ring_bcrypt.c",
		"src/utils/color.ring",
		"src/utils/install.ring",
		"src/utils/uninstall.ring"
	],
	:ringfolderfiles = 	[

	],
	:windowsfiles = 	[
		"lib/windows/i386/ring_bcrypt.dll",
		"lib/windows/amd64/ring_bcrypt.dll",
		"lib/windows/arm64/ring_bcrypt.dll"
	],
	:linuxfiles = 	[
		"lib/linux/amd64/libring_bcrypt.so",
		"lib/linux/arm64/libring_bcrypt.so",
		"lib/linux/musl/amd64/libring_bcrypt.so",
		"lib/linux/musl/arm64/libring_bcrypt.so"
	],
	:ubuntufiles = 	[

	],
	:fedorafiles = 	[

	],
	:macosfiles = 	[
		"lib/macos/amd64/libring_bcrypt.dylib",
		"lib/macos/arm64/libring_bcrypt.dylib"
	],
	:freebsdfiles = 	[
		"lib/freebsd/amd64/libring_bcrypt.so"
	],
	:windowsringfolderfiles = 	[

	],
	:linuxringfolderfiles = 	[

	],
	:ubunturingfolderfiles = 	[

	],
	:fedoraringfolderfiles = 	[

	],
	:freebsdringfolderfiles = 	[

	],
	:macosringfolderfiles = 	[

	],
	:run = "ring main.ring",
	:windowsrun = "",
	:linuxrun = "",
	:macosrun = "",
	:ubunturun = "",
	:fedorarun = "",
	:setup = "ring src/utils/install.ring",
	:windowssetup = "",
	:linuxsetup = "",
	:macossetup = "",
	:ubuntusetup = "",
	:fedorasetup = "",
	:remove = "ring src/utils/uninstall.ring",
	:windowsremove = "",
	:linuxremove = "",
	:macosremove = "",
	:ubunturemove = "",
	:fedoraremove = ""
]
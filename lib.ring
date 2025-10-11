# Load necessary Ring libraries
load "openssllib.ring"
load "src/bcrypt.ring"

# Load the Bcrypt library based on the operating system.
if isWindows()
	loadlib("ring_bcrypt.dll")
but isLinux() or isFreeBSD()
	loadlib("libring_bcrypt.so")
but isMacOSX()
	loadlib("libring_bcrypt.dylib")
else
	raise("Unsupported OS! You need to build the library for your OS.")
ok
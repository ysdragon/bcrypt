# Ring Bcrypt Test Suite
# Test the bcrypt extension

# Load the appropriate shared library based on OS and architecture
arch = getarch()
if isWindows()
	if arch = "x64"
		loadlib("../lib/windows/amd64/ring_bcrypt.dll")
	but arch = "arm64"
		loadlib("../lib/windows/arm64/ring_bcrypt.dll")
	but arch = "x86"
		loadlib("../lib/windows/i386/ring_bcrypt.dll")
	ok
but isLinux()
	if arch = "x64"
		loadlib("../lib/linux/amd64/libring_bcrypt.so")
	but arch = "arm64"
		loadlib("../lib/linux/arm64/libring_bcrypt.so")
	ok
but isFreeBSD()
	if arch = "x64"
		loadlib("../lib/freebsd/amd64/libring_bcrypt.so")
	but arch = "arm64"
		loadlib("../lib/freebsd/arm64/libring_bcrypt.so")
	ok
but isMacOSX()
	if arch = "x64"
		loadlib("../lib/macos/amd64/libring_bcrypt.dylib")
	but arch = "arm64"
		loadlib("../lib/macos/arm64/libring_bcrypt.dylib")
	ok
else
	raise("Unsupported OS! You need to build the library for your OS.")
ok

load "utils/color.ring"
load "openssllib.ring"
load "bcrypt.ring"

? colorText([:text = "===== Ring Bcrypt Test Suite =====", :color = :BRIGHT_CYAN, :style = :BOLD]) + nl

# Test 1: Generate salt
? colorText([:text = "Test 1: Generate Salt", :color = :BRIGHT_YELLOW, :style = :BOLD])
try
    salt = bcrypt_gensalt(10)
    ? colorText([:text = "  ✓ Salt generated: " + salt, :color = :BRIGHT_GREEN])
    if len(salt) > 0
        ? colorText([:text = "  ✓ Salt length: " + len(salt), :color = :BRIGHT_GREEN])
    ok
catch
    ? colorText([:text = "  ✗ Failed: " + cCatchError, :color = :BRIGHT_RED]) + nl
done

# Test 2: Hash a password
? colorText([:text = "Test 2: Hash Password", :color = :BRIGHT_YELLOW, :style = :BOLD])
try
    password = "test_password_123"
    hash = bcrypt_hashpw(password, 10)
    ? colorText([:text = "  ✓ Password hashed: " + hash, :color = :BRIGHT_GREEN])
    if len(hash) > 0
        ? colorText([:text = "  ✓ Hash length: " + len(hash), :color = :BRIGHT_GREEN])
    ok
catch
    ? colorText([:text = "  ✗ Failed: " + cCatchError, :color = :BRIGHT_RED]) + nl
done

# Test 3: Verify correct password
? colorText([:text = "Test 3: Verify Correct Password", :color = :BRIGHT_YELLOW, :style = :BOLD])
try
    password = "my_password"
    hash = bcrypt_hashpw(password, 8)
    result = bcrypt_verify(password, hash)
    if result = 1
        ? colorText([:text = "  ✓ Password verification successful", :color = :BRIGHT_GREEN]) + nl
    else
        ? colorText([:text = "  ✗ Password verification failed (should have matched)", :color = :BRIGHT_RED]) + nl
    ok
catch
    ? colorText([:text = "  ✗ Failed: " + cCatchError, :color = :BRIGHT_RED]) + nl
done

# Test 4: Verify incorrect password
? colorText([:text = "Test 4: Verify Incorrect Password", :color = :BRIGHT_YELLOW, :style = :BOLD])
try
    password = "correct_password"
    wrong_password = "wrong_password"
    hash = bcrypt_hashpw(password, 8)
    result = bcrypt_verify(wrong_password, hash)
    if result = 0
        ? colorText([:text = "  ✓ Password verification correctly rejected", :color = :BRIGHT_GREEN]) + nl
    else
        ? colorText([:text = "  ✗ Password verification failed (should have rejected)", :color = :BRIGHT_RED]) + nl
    ok
catch
    ? colorText([:text = "  ✗ Failed: " + cCatchError, :color = :BRIGHT_RED]) + nl
done

# Test 5: Get rounds from hash
? colorText([:text = "Test 5: Get Rounds from Hash", :color = :BRIGHT_YELLOW, :style = :BOLD])
try
    password = "test"
    rounds_in = 12
    hash = bcrypt_hashpw(password, rounds_in)
    rounds_out = bcrypt_rounds(hash)
    if rounds_out = rounds_in
        ? colorText([:text = "  ✓ Rounds extracted: " + rounds_out, :color = :BRIGHT_GREEN]) + nl
    else
        ? colorText([:text = "  ✗ Rounds mismatch: expected " + string(rounds_in) + ", got " + string(rounds_out), :color = :BRIGHT_RED]) + nl
    ok
catch
    ? colorText([:text = "  ✗ Failed: " + cCatchError, :color = :BRIGHT_RED]) + nl
done

# Test 6: Different rounds
? colorText([:text = "Test 6: Test Different Rounds", :color = :BRIGHT_YELLOW, :style = :BOLD])
try
    password = "test_rounds"
    for rounds = 4 to 12
        hash = bcrypt_hashpw(password, rounds)
        ? colorText([:text = "  ✓ Rounds " + rounds + ": " + hash, :color = :BRIGHT_GREEN]) + nl
    next
catch
    ? colorText([:text = "  ✗ Failed: " + cCatchError, :color = :BRIGHT_RED]) + nl
done

# Test 7: Low-level API test
? colorText([:text = "Test 7: Low-level API (bcrypt_hash and bcrypt_compare)", :color = :BRIGHT_YELLOW, :style = :BOLD])
try
    password = "low_level_test"
    salt = bcrypt_gensalt(10)
    hash = bcrypt_hash(password, salt)
    ? colorText([:text = "  ✓ Hash created: " + hash, :color = :BRIGHT_GREEN])
    
    result = bcrypt_compare(password, hash)
    if result = 1
        ? colorText([:text = "  ✓ Comparison successful", :color = :BRIGHT_GREEN]) + nl
    else
        ? colorText([:text = "  ✗ Comparison failed", :color = :BRIGHT_RED]) + nl
    ok
catch
    ? colorText([:text = "  ✗ Failed: " + cCatchError, :color = :BRIGHT_RED]) + nl
done

? nl + colorText([:text = "All tests completed!", :color = :BRIGHT_CYAN, :style = :BOLD])

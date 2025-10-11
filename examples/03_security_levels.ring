# Example 03: Different Security Levels
# This example demonstrates how different round values affect security and performance

load "bcrypt.ring"

? "===== Example 03: Security Levels (Rounds) =====" + nl

password = "TestPassword"
? "Password to hash: " + password + nl

? "Hashing with different round values:"
? "------------------------------------" + nl

# Fast (4 rounds) - Use only for testing
? "1. Fast (4 rounds) - Development/Testing only"
hash4 = bcrypt_hashpw(password, 4)
time4 = clock()
? "   Hash: " + hash4
? "   Time: " + time4 + " seconds" + nl

# Normal (10 rounds) - Recommended for most applications
? "2. Normal (10 rounds) - Recommended"
hash10 = bcrypt_hashpw(password, 10)
time10 = clock()
? "   Hash: " + hash10
? "   Time: " + time10 + " seconds" + nl

# Secure (12 rounds) - High security applications
? "3. Secure (12 rounds) - High Security"
hash12 = bcrypt_hashpw(password, 12)
time12 = clock()
? "   Hash: " + hash12
? "   Time: " + time12 + " seconds" + nl

? nl + "Done!"
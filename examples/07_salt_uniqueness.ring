# Example 07: Salt Uniqueness Demonstration
# This example shows how bcrypt generates unique salts for each hash

load "bcrypt.ring"

? "===== Example 07: Salt Uniqueness =====" + nl

password = "SamePasswordForAll"
? "Hashing the same password multiple times:"
? "Password: " + password + nl

? "Each hash will be different due to unique random salts:"
? "-------------------------------------------------------" + nl

# Hash the same password 5 times
for i = 1 to 5
    hash = bcrypt_hashpw(password, 10)
    ? "Hash " + i + ": " + hash
    
    # Verify all hashes work with the same password
    if bcrypt_verify(password, hash)
        ? "         ✓ Verified successfully"
    ok
    ? ""
next

? nl + "Done!"
# Example 02: Password Verification
# This example shows how to verify passwords against stored hashes

load "bcrypt.ring"

? "===== Example 02: Password Verification =====" + nl

# Hash a password
password = "SecretPassword456"
? "Original password: " + password

hash = bcrypt_hashpw(password, 10)
? "Stored hash: " + hash + nl

# Verify correct password
? "Test 1: Verifying with correct password..."
if bcrypt_verify(password, hash)
    ? "✓ Success! Password matches the hash" + nl
else
    ? "✗ Failed! Password does not match" + nl
ok

# Verify incorrect password
? "Test 2: Verifying with incorrect password..."
wrong_password = "WrongPassword123"
if bcrypt_verify(wrong_password, hash)
    ? "✗ Error! Wrong password was accepted" + nl
else
    ? "✓ Success! Wrong password was correctly rejected" + nl
ok

# Verify with slightly different password
? "Test 3: Verifying with case-sensitive mismatch..."
wrong_case = "secretpassword456"  # Different case
if bcrypt_verify(wrong_case, hash)
    ? "✗ Error! Password with wrong case was accepted" + nl
else
    ? "✓ Success! Bcrypt is case-sensitive" + nl
ok


? nl + "Done!"

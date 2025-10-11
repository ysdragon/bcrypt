# Example 06: Password Update (Rehashing)
# This example shows how to update/rehash passwords when security requirements change

load "bcrypt.ring"

? "===== Example 06: Password Update & Rehashing =====" + nl

# Simulate old user with weak hash (8 rounds)
username = "john_doe"
old_password = "UserPassword123"
old_hash = bcrypt_hashpw(old_password, 8)

? "Current user state:"
? "  Username: " + username
? "  Old hash: " + old_hash
? "  Old rounds: " + bcrypt_rounds(old_hash) + nl

# User logs in with old hash
? "User login attempt..."
if bcrypt_verify(old_password, old_hash)
    ? "✓ Login successful with old hash"
    ? ""
    
    # Check if rehashing is needed
    current_rounds = bcrypt_rounds(old_hash)
    recommended_rounds = 12
    
    if current_rounds < recommended_rounds
        ? "Security Notice: Hash uses " + current_rounds + " rounds"
        ? "Recommended rounds: " + recommended_rounds
        ? ""
        ? "Rehashing password with stronger settings..."
        
        # Rehash the password during login
        new_hash = bcrypt_hashpw(old_password, recommended_rounds)
        
        ? "✓ Password rehashed successfully!"
        ? "  New hash: " + new_hash
        ? "  New rounds: " + bcrypt_rounds(new_hash)
        ? ""
        
        # Verify the new hash works
        ? "Verifying new hash..."
        if bcrypt_verify(old_password, new_hash)
            ? "✓ New hash verified successfully"
            ? "  (In production, save this new hash to database)"
        ok
    else
        ? "Hash is up to date (using " + current_rounds + " rounds)"
    ok
else
    ? "✗ Login failed"
ok

? nl + "Done!"
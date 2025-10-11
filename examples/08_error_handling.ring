# Example 08: Error Handling
# This example demonstrates proper error handling with bcrypt

load "bcrypt.ring"

? "===== Example 08: Error Handling =====" + nl

? "Test 1: Invalid round values"
? "----------------------------"

# Test with rounds too low
? "Attempting to hash with 3 rounds (minimum is 4)..."
try
    hash = bcrypt_hashpw("password", 3)
    ? "✗ Unexpected: Should have raised an error" + nl
catch
    ? "✓ Error caught: " + cCatchError + nl
done
? ""

# Test with rounds too high
? "Attempting to hash with 32 rounds (maximum is 31)..."
try
    hash = bcrypt_hashpw("password", 32)
    ? "✗ Unexpected: Should have raised an error" + nl
catch
    ? "✓ Error caught: " + cCatchError + nl
done
? ""

? "Test 2: Invalid hash formats"
? "----------------------------"

# Test with invalid hash
invalid_hash = "not_a_valid_bcrypt_hash"
? "Attempting to verify with invalid hash format..."
try
    result = bcrypt_verify("password", invalid_hash)
    if result = 0
        ? "✓ Correctly returned 0 (no match)" + nl
    else
        ? "✗ Unexpected result: " + result + nl
    ok
catch
    ? "✓ Error caught: " + cCatchError + nl
done
? ""

# Test with empty password
? "Test 3: Empty password"
? "----------------------"
? "Hashing empty password..."
try
    hash = bcrypt_hashpw("", 10)
    ? "✓ Hash created: " + hash
    
    # Verify empty password
    if bcrypt_verify("", hash)
        ? "✓ Empty password verified successfully" + nl
    ok
catch
    ? "✗ Error: " + cCatchError + nl
done

? "Test 4: Valid round boundaries"
? "------------------------------"

? "Minimum valid rounds (4)..."
try
    hash = bcrypt_hashpw("password", 4)
    ? "✓ Hash created: " + hash + nl
catch
    ? "✗ Error: " + cCatchError + nl
done

? "Maximum valid rounds (31)..."
try
    hash = bcrypt_hashpw("password", 31)
    ? "✓ Hash created: " + hash + nl
catch
    ? "✗ Error: " + cCatchError + nl
done

? nl + "Done!"
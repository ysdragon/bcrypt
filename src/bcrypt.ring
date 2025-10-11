# Ring Bcrypt Library

# Generate a salt with the specified number of rounds
# rounds: number of rounds (4-31, default 10)
# Returns: salt string
func bcrypt_gensalt(rounds)
    if rounds = NULL
        rounds = 10
    ok
    
    # Validate rounds
    if rounds < 4 or rounds > 31
        raise("Rounds must be between 4 and 31")
    ok
    
    # Generate random seed (16 bytes)
    seed = randbytes(16)

    # Generate salt with minor version 'b'
    return bcrypt_gensalt_sync("b", rounds, seed)

# Hash a password
# password: the password string to hash
# rounds: number of rounds (4-31, default 10)
# Returns: hashed password string
func bcrypt_hashpw(password, rounds)
    if rounds = NULL
        rounds = 10
    ok
    
    salt = bcrypt_gensalt(rounds)
    return bcrypt_hash(password, salt)

# Compare a password with a hash
# password: the password string to compare
# hash: the hash string to compare against
# Returns: 1 if match, 0 if not
func bcrypt_verify(password, hash)
    return bcrypt_compare(password, hash)

# Get the number of rounds used in a hash
# hash: the hash string
# Returns: number of rounds
func bcrypt_rounds(hash)
    return bcrypt_get_rounds(hash)
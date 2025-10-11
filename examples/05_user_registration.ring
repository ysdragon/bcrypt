# Example 05: User Registration Simulation
# This example simulates a user registration system using bcrypt

load "bcrypt.ring"

? "===== Example 05: User Registration System =====" + nl

# Simulated user database (in real apps, this would be a database)
users = []

# Demo
? "Demo: User Registration and Login"
? "====================================" + nl

# Register users
register_user("alice", "AlicePassword123")

register_user("bob", "BobSecretPass456")

# Try to register duplicate user
register_user("alice", "DifferentPassword")

# Login attempts
login_user("alice", "AlicePassword123")      # Correct
login_user("alice", "WrongPassword")         # Wrong password
login_user("bob", "BobSecretPass456")        # Correct
login_user("charlie", "AnyPassword")         # User not found


? "Total registered users: " + len(users) + nl

? nl + "Done!"

func register_user(username, password)
    ? "Registering user: " + username
    
    # Check if user already exists
    for user in users
        if user[:username] = username
            ? "✗ Error: User already exists!"
            return false
        ok
    next
    
    # Hash the password (10 rounds for production)
    ? "  Hashing password..."
    hash = bcrypt_hashpw(password, 10)
    
    # Store user with hashed password
    add(users, [
        :username = username,
        :password_hash = hash
    ])
    
    ? "✓ User registered successfully!"
    ? "  Username: " + username
    ? "  Hash: " + hash
    return true

func login_user(username, password)
    ? ""
    ? "Attempting login for: " + username
    
    # Find user
    for user in users
        if user[:username] = username
            ? "  User found, verifying password..."
            
            # Verify password
            if bcrypt_verify(password, user[:password_hash])
                ? "✓ Login successful!"
                return true
            else
                ? "✗ Login failed: Incorrect password"
                return false
            ok
        ok
    next
    
    ? "✗ Login failed: User not found"
    return false
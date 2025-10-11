# Example 01: Basic Password Hashing
# This example demonstrates the simplest use case of bcrypt

load "bcrypt.ring"

? "===== Example 01: Basic Password Hashing =====" + nl

# Define a password
password = "MySecurePassword123"
? "Original password: " + password + nl

# Hash the password with default 10 rounds
? "Hashing password with 10 rounds..."
hash = bcrypt_hashpw(password, 10)
? "Hashed password: " + hash

? nl + "Done!"
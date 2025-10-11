# Example 04: Hash Inspection
# This example shows how to inspect bcrypt hashes

load "bcrypt.ring"

? "===== Example 04: Hash Inspection =====" + nl

# Create hashes with different rounds
password = "InspectMe"
? "Creating hashes with different round values..." + nl

hash8 = bcrypt_hashpw(password, 8)
hash10 = bcrypt_hashpw(password, 10)
hash12 = bcrypt_hashpw(password, 12)

? "Hash with 8 rounds:"
? hash8
rounds8 = bcrypt_rounds(hash8)
? "Detected rounds: " + rounds8 + nl

? "Hash with 10 rounds:"
? hash10
rounds10 = bcrypt_rounds(hash10)
? "Detected rounds: " + rounds10 + nl

? "Hash with 12 rounds:"
? hash12
rounds12 = bcrypt_rounds(hash12)
? "Detected rounds: " + rounds12 + nl

? nl + "Done!"
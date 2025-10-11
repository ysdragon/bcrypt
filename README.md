# Ring Bcrypt

[license]: https://img.shields.io/github/license/ysdragon/bcrypt?style=for-the-badge&logo=opensourcehardware&label=License&logoColor=C0CAF5&labelColor=414868&color=8c73cc
[![][license]](https://github.com/ysdragon/bcrypt/blob/master/LICENSE)

[ring]: https://img.shields.io/badge/Made_with_❤️_for-Ring-2D54CB?style=for-the-badge
[![][ring]](https://ring-lang.net/)

A Ring language binding for the bcrypt password hashing algorithm, providing secure password hashing and verification capabilities based on the Blowfish cipher.

## 📖 Overview

Bcrypt is a password hashing function designed by Niels Provos and David Mazières, based on the Blowfish cipher. It incorporates a salt to protect against rainbow table attacks and is designed to be computationally expensive to resist brute-force attacks.

## ✨ Features

- Secure password hashing with automatic salt generation
- Configurable computational cost (4-31 rounds)
- Simple API for password hashing and verification
- Built-in salt generation using OpenSSL
- Cross-platform support (Windows, Linux, macOS, FreeBSD)

## 📦 Installation

This package can be installed using the Ring Package Manager (**RingPM**):

```
ringpm install bcrypt from ysdragon
```

## 💡 Usage

First, load the library in your Ring script:

```ring
load "bcrypt.ring"
```

### Basic Password Hashing

To hash a password with default settings (10 rounds):

```ring
password = "MySecurePassword123"

# Hash the password (salt is generated automatically)
hash = bcrypt_hashpw(password, 10)
? "Hashed password: " + hash
```

### Password Verification

To verify a password against a stored hash:

```ring
if bcrypt_verify(password, hash)
    ? "Password is correct!"
else
    ? "Password verification failed!"
ok
```

### Advanced Usage

```ring
# Check how many rounds were used in a hash
rounds = bcrypt_rounds(hash)
? "This hash used " + rounds + " rounds"

# Use different security levels
fast_hash = bcrypt_hashpw(password, 4)      # Fast (less secure)
normal_hash = bcrypt_hashpw(password, 10)   # Normal (recommended)
secure_hash = bcrypt_hashpw(password, 12)   # Secure (slower)
```

## ⚙️ Security Considerations

- **Rounds**: The work factor (rounds) determines computational cost. Higher values = more secure but slower
  - Minimum: 4 rounds
  - Maximum: 31 rounds
  - Recommended: 10-12 rounds for most applications
- **Salt**: Automatically generated using cryptographically secure random bytes from OpenSSL
- Each hash is unique even for the same password due to the salt

## 📚 API Reference

### High-Level Functions

#### `bcrypt_hashpw(password, rounds)`
Hashes a password with automatic salt generation.

**Parameters:**
- `password` (string): The password to hash
- `rounds` (number): Number of rounds (4-31, default 10)

**Returns:** Hashed password string

**Example:**
```ring
hash = bcrypt_hashpw("mypassword", 10)
```

#### `bcrypt_verify(password, hash)`
Verifies a password against a hash.

**Parameters:**
- `password` (string): The password to verify
- `hash` (string): The hash to verify against

**Returns:** 1 if match, 0 if not

**Example:**
```ring
if bcrypt_verify("mypassword", hash)
    ? "Match!"
ok
```

#### `bcrypt_rounds(hash)`
Gets the number of rounds used in a hash.

**Parameters:**
- `hash` (string): The hash to inspect

**Returns:** Number of rounds

**Example:**
```ring
rounds = bcrypt_rounds(hash)
```

### Low-Level Functions

#### `bcrypt_gensalt(rounds)`
Generates a salt with the specified number of rounds.

**Parameters:**
- `rounds` (number): Number of rounds (4-31, default 10)

**Returns:** Salt string

#### `bcrypt_hash(password, salt)`
Hashes a password with a given salt (C extension function).

#### `bcrypt_compare(password, hash)`
Compares a password with a hash (C extension function).

#### `bcrypt_get_rounds(hash)`
Gets the rounds from a hash (C extension function).

## 🛠️ Development

If you wish to contribute to the development of Ring Bcrypt or build it from the source, follow these steps.

### Prerequisites

-   **CMake**: Version 3.16 or higher.
-   **C Compiler**: A C compiler compatible with your platform (e.g., GCC, Clang, MSVC).
-   **[Ring](https://ring-lang.net/) Source Code**: You will need to have the Ring language source code available on your machine.
-   **OpenSSL**: Required for random number generation (usually pre-installed on most systems).

### Build Steps

1.  **Clone the Repository:**
    ```sh
    git clone https://github.com/ysdragon/bcrypt.git
    ```
    > **Note**: If you installed the library via RingPM, you can skip this step.

2.  **Set the `RING` Environment Variable:**
    This variable must point to the root directory of the Ring language source code.

    -   **Windows (Command Prompt):**
        ```cmd
        set RING=X:\path\to\ring
        ```
    -   **Windows (PowerShell):**
        ```powershell
        $env:RING = "X:\path\to\ring"
        ```
    -   **Unix-like Systems (Linux, macOS or FreeBSD):**
        ```bash
        export RING=/path/to/ring
        ```

3.  **Configure with CMake:**
    Create a build directory and run CMake from within it.
    ```sh
    mkdir build
    cd build
    cmake ..
    ```

4.  **Build the Project:**
    Compile the source code using the build toolchain configured by CMake.
    ```sh
    cmake --build .
    ```

    The compiled library will be available in the `lib/<os>/<arch>` directory.

## 🤝 Contributing

Contributions are always welcome! If you have suggestions for improvements or have identified a bug, please feel free to open an issue or submit a pull request.

## 📄 License

This project is licensed under the MIT License. See the [`LICENSE`](LICENSE) file for more details.
# vulnerable.py

import subprocess
import hashlib

# ⚠️ Insecure use of subprocess with shell=True
def run_command(user_input):
    subprocess.call("echo " + user_input, shell=True)

# ⚠️ Hardcoded password
def connect_db():
    password = "SuperSecret123"  # Hardcoded secret
    print("Connecting with password:", password)

# ⚠️ Weak hash algorithm (MD5)
def hash_password(password):
    return hashlib.md5(password.encode()).hexdigest()

if __name__ == "__main__":
    run_command("hello; rm -rf /")  # Dangerous input
    connect_db()
    print(hash_password("password123"))
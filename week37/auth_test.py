import boto3
import hmac
import hashlib
import base64

# CONFIGURATION
REGION = "us-east-2"
CLIENT_ID = "64mtlff629kf9emq8h1rcrpj4n"
CLIENT_SECRET = "av59jd0qi0shbfpbrscsfl0lu2hmvt8orqu8cpt04mar6h4ktf6"
USERNAME = "Myusername1$3" # Try cameron.cleveland@ymail.com if this fails
PASSWORD = "aw8XKb6r4xBuqGw!"

def get_secret_hash(username, client_id, client_secret):
    message = username + client_id
    dig = hmac.new(str(client_secret).encode('utf-8'),
                   msg=message.encode('utf-8'),
                   digestmod=hashlib.sha256).digest()
    return base64.b64encode(dig).decode()

def login():
    client = boto3.client('cognito-idp', region_name=REGION)
    secret_hash = get_secret_hash(USERNAME, CLIENT_ID, CLIENT_SECRET)

    print(f"DEBUG: Using Username: {USERNAME}")
    print(f"DEBUG: Using Client ID: {CLIENT_ID}")
    print(f"DEBUG: Generated Hash: {secret_hash}")

    try:
        response = client.initiate_auth(
            ClientId=CLIENT_ID,
            AuthFlow='USER_PASSWORD_AUTH',
            AuthParameters={
                'USERNAME': USERNAME,
                'PASSWORD': PASSWORD,
                'SECRET_HASH': secret_hash
            }
        )
        print("✅ SUCCESS!")
    except client.exceptions.NotAuthorizedException:
        print("❌ ERROR: Cognito rejected these credentials.")
    except Exception as e:
        print(f"❌ SYSTEM ERROR: {e}")

if __name__ == "__main__":
    login()

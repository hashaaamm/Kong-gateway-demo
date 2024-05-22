from fastapi import FastAPI, Request
import jwt
app = FastAPI()


def decode_jwt(token):
    secret_key = "mysecretkey"
    algorithms = ["HS256"]

    try:
        # Extract the token from the Authorization header
        token = token.replace("Bearer ", "")
        # Decode the JWT
        payload = jwt.decode(token,secret_key, algorithms)
        return payload
    except jwt.ExpiredSignatureError:
        # Handle expired token
        print("Token has expired")
        return None
    except jwt.InvalidTokenError:
        # Handle invalid token
        print("Invalid token")
        return None


@app.get("/results/")
def read_root(request: Request):
    payload = decode_jwt(request.headers.get("authorization"))
    return {"jwt payload": payload}


@app.get("/results/{result_id}")
def read_result(result_id: int, q: str = None):
    return {"result_id": result_id, "q": q}


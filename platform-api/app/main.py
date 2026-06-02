from fastapi import FastAPI
from pydantic import BaseModel
import subprocess

app = FastAPI(
    title="Platform API",
    description="Internal Developer Platform API",
    version="1.0.0"
)

# ==============================
# DTO
# ==============================

class GenerateServiceRequest(BaseModel):
    serviceName: str
    packageName: str
    containerPort: int
    nodePort: int

# ==============================
# ROOT
# ==============================

@app.get("/")
def root():
    return {
        "message": "Platform API is running"
    }

# ==============================
# GENERATE SERVICE
# ==============================

@app.post("/generate-service")
def generate_service(request: GenerateServiceRequest):

    command = [
        "/home/marcel/platform/generators/generate.sh",
        request.serviceName,
        request.packageName,
        str(request.containerPort),
        str(request.nodePort)
    ]

    result = subprocess.run(
        command,
        capture_output=True,
        text=True
    )

    return {
        "service": request.serviceName,
        "stdout": result.stdout,
        "stderr": result.stderr,
        "returncode": result.returncode
    }

@app.get("/health")
def health():
    return {
        "status": "UP"
    }

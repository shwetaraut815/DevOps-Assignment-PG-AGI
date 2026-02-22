from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

# Create FastAPI app FIRST
app = FastAPI()

# Configure CORS AFTER app is created
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],          # OK for assignment
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/api/health")
async def health_check():
    return {
        "status": "healthy",
        "message": "Backend is running successfully"
    }

@app.get("/api/message")
async def get_message():
    return {
        "message": "You've successfully integrated the backend!"
    }
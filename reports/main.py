from fastapi import FastAPI
import time
app = FastAPI()


@app.get("/reports/")
def read_root():
    # sleep to showcase kong cache
    time.sleep(5)
    print("slept")
    return {"reports": "Here is your report"}


@app.get("/reports/{report_id}")
def read_report(report_id: int, q: str = None):
    return {"report_id": report_id, "q": q}

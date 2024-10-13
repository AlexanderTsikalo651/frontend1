FROM python:3.12-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt
RUN apt-get update && apt-get install -y git && apt-get install -y libgl1-mesa-glx
COPY . .
RUN git stash
RUN git checkout v2.0
EXPOSE 5002
CMD ["python", "frontend1.py""--host=0.0.0.0", "--port=5002"]

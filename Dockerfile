FROM python:3.12-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt
RUN apt-get update && apt-get install -y git
COPY . .
RUN git stash
RUN git checkout v2.0
ENV FLASK_APP=frontend1
CMD ["flask", "run", "--host=0.0.0.0", "--port=5002"]

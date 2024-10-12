FROM python:3.12-slim
WORKDIR /app

COPY requirements.txt .
RUN pip install -r requirements.txt
COPY frontend1.py .


RUN apt-get update && apt-get install -y git

RUN git stash
RUN git checkout v2.0

RUN apt-get update && apt-get install -y libqt5core5a libqt5gui5 libqt5widgets5 libqt5printsupport5 qtwayland5

ENV QT_QPA_PLATFORM_PLUGIN_PATH=/usr/lib/x86_64-linux-gnu/qt5/plugins/platforms
ENV PYTHONPATH=/app

EXPOSE 5000

CMD ["python", "frontend1.py"]

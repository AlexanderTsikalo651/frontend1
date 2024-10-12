FROM python:3.12-slim
WORKDIR /app

RUN apt-get update && apt-get install -y libqt5core5a libqt5gui5 libqt5widgets5 libqt5printsupport5 qtwayland5 xvfb libxcb-xinerama0

COPY requirements.txt .
RUN pip install -r requirements.txt
COPY frontend1.py .

ENV QT_QPA_PLATFORM_PLUGIN_PATH=/usr/lib/x86_64-linux-gnu/qt5/plugins/platforms
ENV PYTHONPATH=/app
ENV DISPLAY=:99

RUN Xvfb :99 &

EXPOSE 5000

CMD ["python", "frontend1.py"]

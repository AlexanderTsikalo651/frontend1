FROM python:3.12-slim
WORKDIR /app



# Установка PyQt5
RUN pip install PyQt5

# Установка необходимых пакетов для xcb
RUN apt-get install -y libxcb-xinerama0 libxcb-xinput0 libx11-xcb1 libxrender1 libxext6 libxi6 libxrandr2

# Установка переменных окружения
ENV QT_QPA_PLATFORM=xcb
ENV QT_PLUGIN_PATH=/usr/lib/x86_64-linux-gnu/qt5/plugins
ENV QT_DEBUG_PLUGINS=1

COPY requirements.txt .
RUN pip install -r requirements.txt
RUN apt-get update && apt-get install -y git
COPY . .
RUN git stash
RUN git checkout v2.0
EXPOSE 5002



CMD ["python", "frontend1.py", "--host=0.0.0.0", "--port=5002"]

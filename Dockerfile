# Используем базовый образ Python
FROM python:3.9

# Устанавливаем рабочую директорию
WORKDIR /Users/tsika/PycharmProjects/DevOps/frontend1

# Устанавливаем зависимости для PyQt5
RUN apt-get update && apt-get install -y libgl1-mesa-glx

# Копируем requirements.txt и устанавливаем зависимости
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Копируем остальные файлы
COPY . .

# Указываем команду для запуска приложения
CMD ["python", "frontend1.py"]

# Указываем порт
EXPOSE 5000

# Указываем версию тега
LABEL version="2.0"

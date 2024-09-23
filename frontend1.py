import sys
from PyQt5.QtWidgets import QApplication, QWidget, QVBoxLayout, QLineEdit, QPushButton, QTextEdit
import requests

class App(QWidget):
    def __init__(self):
        super().__init__()
        self.initUI()

    def initUI(self):
        self.setWindowTitle('Frontend 2.0')
        self.setGeometry(100, 100, 300, 300)

        layout = QVBoxLayout()

        self.textbox = QLineEdit(self)
        layout.addWidget(self.textbox)

        self.send_button = QPushButton('Отправить', self)
        self.send_button.clicked.connect(self.on_send_click)
        layout.addWidget(self.send_button)

        self.result_textbox = QTextEdit(self)
        self.result_textbox.setReadOnly(True)
        layout.addWidget(self.result_textbox)

        self.get_button = QPushButton('Получить данные', self)
        self.get_button.clicked.connect(self.on_get_click)
        layout.addWidget(self.get_button)

        self.setLayout(layout)

    def on_send_click(self):
        text = self.textbox.text()
        response = requests.post('http://localhost:5000/data', data={'text': text})
        print(response.text)

    def on_get_click(self):
        response = requests.get('http://localhost:5000/data')
        if response.status_code == 200:
            self.result_textbox.setText('\n'.join(response.json()))
        else:
            self.result_textbox.setText('Ошибка при получении данных')

if __name__ == '__main__':
    app = QApplication(sys.argv)
    ex = App()
    ex.show()
    sys.exit(app.exec_())

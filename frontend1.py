import sys
from PyQt5.QtWidgets import QApplication, QWidget, QVBoxLayout, QLineEdit, QPushButton
import requests

class App(QWidget):
    def __init__(self):
        super().__init__()
        self.initUI()

    def initUI(self):
        self.setWindowTitle('Frontend 1.0')
        self.setGeometry(100, 100, 300, 200)

        layout = QVBoxLayout()

        self.textbox = QLineEdit(self)
        layout.addWidget(self.textbox)

        self.button = QPushButton('Отправить', self)
        self.button.clicked.connect(self.on_click)
        layout.addWidget(self.button)

        self.setLayout(layout)

    def on_click(self):
        text = self.textbox.text()
        response = requests.post('http://localhost:5000/data', data={'text': text})
        print(response.text)

if __name__ == '__main__':
    app = QApplication(sys.argv)
    ex = App()
    ex.show()
    sys.exit(app.exec_())

from PySide2.QtCore import *
from PySide2.QtGui import *
from PySide2.QtWidgets import *

class CircularProgress(QWidget):
    def __init__(self):
        QWidget.__init__(self)
        # Custom properties
        self.value = 0
        self.width = 200
        self.height = 200
        self.progress_width = 10
        self.progress_rounded_cap = True
        self.progress_color = 0x498BD1

        # Text
        self.max_value = 100
        self.font_family = "Segoe UI"
        self.font_size = 12
        self.suffix = "%"
        self.text_color = 0x498BD1

        # Bg
        self.enable_bg = False
        self.bg_color = 0x44475a

        # Set default size without layout
        self.resize(self.width, self.height)

    # Set Value
    def setValue(self, value):
        self.value = value
        self.repaint()

    # Add Drop Shadow
    def add_shadow(self, enable):
        if enable:
            self.shadow = QGraphicsDropShadowEffect(self)
            self.shadow.setBlurRadius(15)
            self.shadow.setXOffset(0)
            self.shadow.setYOffset(0)
            self.shadow.setColor(QColor(0,0,0,120))
            self.setGraphicsEffect(self.shadow)

    #  Paint event (Design Circular Progress)
    def paintEvent(self, event):
        # Set progress parameters
        width = self.width - self.progress_width
        height = self.height - self.progress_width
        margin = int(self.progress_width / 2)
        value = self.value * 360 / self.max_value

        # Painter
        paint = QPainter()
        paint.begin(self)
        paint.setRenderHint(QPainter.Antialiasing) # Remove pixelated edges
        paint.setFont(QFont(self.font_family, self.font_size))

        # Create rectangle
        rect = QRect(0, 0, self.width, self.height)
        paint.setPen(Qt.NoPen)
        paint.drawRect(rect)

        # Pen
        pen = QPen()
        pen.setWidth(self.progress_width)
        # Set round cap
        if self.progress_rounded_cap:   
            pen.setCapStyle(Qt.RoundCap)

        # Create Bg
        if self.enable_bg:
            pen.setColor(QColor(self.bg_color))
            paint.setPen(pen)
            paint.drawArc(int(margin), int(margin), int(width), int(height), int(-90*16), int(-360*16))

        pen.setColor(QColor(self.progress_color))
        # Create ARK / Circular Progress
        paint.setPen(pen)
        paint.drawArc(int(margin), int(margin), int(width), int(height), int(-90*16), int(-value*16))


        # Create Text
        pen.setColor(QColor(self.text_color))
        paint.setPen(pen)
        paint.drawText(rect, Qt.AlignCenter, f"{self.value}{self.suffix}")

        # End
        paint.end()

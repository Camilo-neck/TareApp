# -*- coding: utf-8 -*-

################################################################################
## Form generated from reading UI file 'splash_screen.ui'
##
## Created by: Qt User Interface Compiler version 6.0.4
##
## WARNING! All changes made in this file will be lost when recompiling UI file!
################################################################################

from PySide6.QtCore import *
from PySide6.QtGui import *
from PySide6.QtWidgets import *


class Ui_SplashScreen(object):
    def setupUi(self, SplashScreen):
        if not SplashScreen.objectName():
            SplashScreen.setObjectName(u"SplashScreen")
        SplashScreen.resize(300, 300)
        SplashScreen.setMinimumSize(QSize(300, 300))
        SplashScreen.setMaximumSize(QSize(300, 300))
        self.centralwidget = QWidget(SplashScreen)
        self.centralwidget.setObjectName(u"centralwidget")
        self.verticalLayout = QVBoxLayout(self.centralwidget)
        self.verticalLayout.setSpacing(0)
        self.verticalLayout.setObjectName(u"verticalLayout")
        self.verticalLayout.setContentsMargins(10, 10, 10, 10)
        self.container = QFrame(self.centralwidget)
        self.container.setObjectName(u"container")
        self.container.setFrameShape(QFrame.StyledPanel)
        self.container.setFrameShadow(QFrame.Raised)
        self.verticalLayout_2 = QVBoxLayout(self.container)
        self.verticalLayout_2.setSpacing(0)
        self.verticalLayout_2.setObjectName(u"verticalLayout_2")
        self.verticalLayout_2.setContentsMargins(20, 20, 20, 20)
        self.circle_bg = QFrame(self.container)
        self.circle_bg.setObjectName(u"circle_bg")
        self.circle_bg.setStyleSheet(u"QFrame {\n"
"	background-color: #ffffff;\n"
"	color: #f8f8f2;\n"
"	border-radius: 119px;\n"
"}")
        self.circle_bg.setFrameShape(QFrame.NoFrame)
        self.circle_bg.setFrameShadow(QFrame.Raised)
        self.verticalLayout_3 = QVBoxLayout(self.circle_bg)
        self.verticalLayout_3.setSpacing(0)
        self.verticalLayout_3.setObjectName(u"verticalLayout_3")
        self.verticalLayout_3.setContentsMargins(0, 0, 0, 0)
        self.texts = QFrame(self.circle_bg)
        self.texts.setObjectName(u"texts")
        self.texts.setMinimumSize(QSize(0, 200))
        self.texts.setMaximumSize(QSize(16777215, 190))
        self.texts.setStyleSheet(u"background: none;")
        self.texts.setFrameShape(QFrame.StyledPanel)
        self.texts.setFrameShadow(QFrame.Raised)
        self.verticalLayout_4 = QVBoxLayout(self.texts)
        self.verticalLayout_4.setObjectName(u"verticalLayout_4")
        self.verticalLayout_4.setContentsMargins(-1, 25, -1, -1)
        self.gridLayout_2 = QGridLayout()
        self.gridLayout_2.setObjectName(u"gridLayout_2")
        self.loading = QLabel(self.texts)
        self.loading.setObjectName(u"loading")
        font = QFont()
        font.setPointSize(12)
        self.loading.setFont(font)
        self.loading.setStyleSheet(u"QLabel {\n"
"	color: #FF7A1D;\n"
"}")
        self.loading.setAlignment(Qt.AlignCenter)

        self.gridLayout_2.addWidget(self.loading, 3, 0, 1, 1)

        self.appName = QLabel(self.texts)
        self.appName.setObjectName(u"appName")
        self.appName.setMinimumSize(QSize(0, 30))
        font1 = QFont()
        font1.setPointSize(18)
        self.appName.setFont(font1)
        self.appName.setStyleSheet(u"QLabel {\n"
"	color: #FF7A1D;\n"
"}")
        self.appName.setAlignment(Qt.AlignCenter)

        self.gridLayout_2.addWidget(self.appName, 0, 0, 1, 1)

        self.frame = QFrame(self.texts)
        self.frame.setObjectName(u"frame")
        self.frame.setFrameShape(QFrame.StyledPanel)
        self.frame.setFrameShadow(QFrame.Raised)
        self.verticalLayout_5 = QVBoxLayout(self.frame)
        self.verticalLayout_5.setObjectName(u"verticalLayout_5")
        self.version = QLabel(self.frame)
        self.version.setObjectName(u"version")
        self.version.setMinimumSize(QSize(100, 24))
        self.version.setMaximumSize(QSize(100, 24))
        font2 = QFont()
        font2.setPointSize(9)
        self.version.setFont(font2)
        self.version.setStyleSheet(u"QLabel {\n"
"	border-radius: 12px;\n"
"	color: #0B403E;\n"
"	background-color: #B5B5B5;\n"
"}")
        self.version.setAlignment(Qt.AlignCenter)

        self.verticalLayout_5.addWidget(self.version, 0, Qt.AlignHCenter)


        self.gridLayout_2.addWidget(self.frame, 2, 0, 1, 1)

        self.empty = QFrame(self.texts)
        self.empty.setObjectName(u"empty")
        self.empty.setMinimumSize(QSize(0, 90))
        self.empty.setMaximumSize(QSize(16777215, 16777215))
        self.empty.setFrameShape(QFrame.StyledPanel)
        self.empty.setFrameShadow(QFrame.Raised)

        self.gridLayout_2.addWidget(self.empty, 1, 0, 1, 1)


        self.verticalLayout_4.addLayout(self.gridLayout_2)


        self.verticalLayout_3.addWidget(self.texts)


        self.verticalLayout_2.addWidget(self.circle_bg)


        self.verticalLayout.addWidget(self.container)

        SplashScreen.setCentralWidget(self.centralwidget)

        self.retranslateUi(SplashScreen)

        QMetaObject.connectSlotsByName(SplashScreen)
    # setupUi

    def retranslateUi(self, SplashScreen):
        SplashScreen.setWindowTitle(QCoreApplication.translate("SplashScreen", u"Loading", None))
        self.loading.setText(QCoreApplication.translate("SplashScreen", u"Loading...", None))
        self.appName.setText(QCoreApplication.translate("SplashScreen", u"TareApp", None))
        self.version.setText(QCoreApplication.translate("SplashScreen", u"V1.0.0 - Beta 1", None))
    # retranslateUi


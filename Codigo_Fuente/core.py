import sys
import os
from time import sleep
from shutil import ExecError
import datetime
import traceback
from socket import *
import xlsxwriter
import xlrd
import platform
import subprocess

from PySide2.QtQml import QQmlApplicationEngine
from PySide2.QtCore import *
from PySide2.QtGui import *
from PySide2.QtWidgets import *

# Import Circular Progress
from Interface import CircularProgress, Ui_SplashScreen
from Data import Wiki, Google, Url, MyText, PdfApp, User, FormattedDocument, FileOrganizer, SaveFile

from win32api import GetFileAttributes
from win32con import FILE_ATTRIBUTE_HIDDEN,FILE_ATTRIBUTE_SYSTEM  #pywin32

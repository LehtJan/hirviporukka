# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'c:\Users\JanneL\Documents\GitHub\hirviporukka\old code\groupInfoMainWindow.ui'
#
# Created by: PyQt5 UI code generator 5.15.7
#
# WARNING: Any manual changes made to this file will be lost when pyuic5 is
# run again.  Do not edit this file unless you know what you are doing.


from PyQt5 import QtCore, QtGui, QtWidgets


class Ui_MainWindow(object):
    def setupUi(self, MainWindow):
        MainWindow.setObjectName("MainWindow")
        MainWindow.resize(1084, 979)
        self.centralwidget = QtWidgets.QWidget(MainWindow)
        self.centralwidget.setObjectName("centralwidget")
        self.meatSharedTableWidget = QtWidgets.QTableWidget(self.centralwidget)
        self.meatSharedTableWidget.setGeometry(QtCore.QRect(110, 140, 321, 151))
        self.meatSharedTableWidget.setRowCount(4)
        self.meatSharedTableWidget.setColumnCount(3)
        self.meatSharedTableWidget.setObjectName("meatSharedTableWidget")
        self.groupSummaryTableWidget = QtWidgets.QTableWidget(self.centralwidget)
        self.groupSummaryTableWidget.setGeometry(QtCore.QRect(110, 410, 321, 151))
        self.groupSummaryTableWidget.setRowCount(4)
        self.groupSummaryTableWidget.setColumnCount(3)
        self.groupSummaryTableWidget.setObjectName("groupSummaryTableWidget")
        self.Jakoryhmien = QtWidgets.QLabel(self.centralwidget)
        self.Jakoryhmien.setGeometry(QtCore.QRect(110, 390, 47, 13))
        self.Jakoryhmien.setText("")
        self.Jakoryhmien.setObjectName("Jakoryhmien")
        self.refreshPushButton = QtWidgets.QPushButton(self.centralwidget)
        self.refreshPushButton.setGeometry(QtCore.QRect(340, 110, 81, 21))
        self.refreshPushButton.setObjectName("refreshPushButton")
        self.meatSharedLabel = QtWidgets.QLabel(self.centralwidget)
        self.meatSharedLabel.setGeometry(QtCore.QRect(110, 120, 71, 16))
        self.meatSharedLabel.setObjectName("meatSharedLabel")
        self.label_2 = QtWidgets.QLabel(self.centralwidget)
        self.label_2.setGeometry(QtCore.QRect(110, 390, 121, 16))
        self.label_2.setObjectName("label_2")
        MainWindow.setCentralWidget(self.centralwidget)
        self.menubar = QtWidgets.QMenuBar(MainWindow)
        self.menubar.setGeometry(QtCore.QRect(0, 0, 1084, 21))
        self.menubar.setObjectName("menubar")
        MainWindow.setMenuBar(self.menubar)
        self.statusbar = QtWidgets.QStatusBar(MainWindow)
        self.statusbar.setObjectName("statusbar")
        MainWindow.setStatusBar(self.statusbar)

        self.retranslateUi(MainWindow)
        QtCore.QMetaObject.connectSlotsByName(MainWindow)

    def retranslateUi(self, MainWindow):
        _translate = QtCore.QCoreApplication.translate
        MainWindow.setWindowTitle(_translate("MainWindow", "MainWindow"))
        self.refreshPushButton.setText(_translate("MainWindow", "P??ivit??"))
        self.meatSharedLabel.setText(_translate("MainWindow", "Jaetut Lihat"))
        self.label_2.setText(_translate("MainWindow", "Jakoryhmien yhteenveto"))

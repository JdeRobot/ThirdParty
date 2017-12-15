#!/usr/bin/python
# -*- coding: utf-8 -*-

import sys
from PyQt5.QtWidgets import QApplication, QWidget, QGridLayout
from PyQt5 import QtGui,QtCore,QtSvg

from threadGUI import ThreadGUI
from qfi import qfi_ADI, qfi_ALT, qfi_SI, qfi_HSI, qfi_VSI, qfi_TC
import math


class Window(QWidget):
    def __init__(self, *args, **kwargs):
        QWidget.__init__(self, *args, **kwargs)

        self.layout = QGridLayout()

        self.adi = qfi_ADI.qfi_ADI(self)
        self.adi.resize(240, 240)
        self.adi.reinit()
        self.layout.addWidget(self.adi, 0, 0)

        self.alt = qfi_ALT.qfi_ALT(self)
        self.alt.resize(240, 240)
        self.alt.reinit()
        self.layout.addWidget(self.alt, 0, 1)

        self.hsi = qfi_HSI.qfi_HSI(self)
        self.hsi.resize(240, 240)
        self.hsi.reinit()
        self.layout.addWidget(self.hsi, 1, 0)

        self.si = qfi_SI.qfi_SI(self)
        self.si.resize(240, 240)
        self.si.reinit()
        self.layout.addWidget(self.si, 1, 1)

        self.vsi = qfi_VSI.qfi_VSI(self)
        self.vsi.resize(240, 240)
        self.vsi.reinit()
        self.layout.addWidget(self.vsi, 2, 0)

        self.tc = qfi_TC.qfi_TC(self)
        self.tc.resize(240, 240)
        self.tc.reinit()
        self.layout.addWidget(self.tc, 2, 1)


        self.setLayout(self.layout)

        self.show()

    def update(self, val):
        self.adi.setRoll(10*math.cos(val))
        self.adi.setPitch(10*math.cos(val))
        self.si.setSpeed(val/10)
        self.hsi.setHeading(val)
        self.vsi.setClimbRate(val)
        self.alt.setAltitude(val)
        self.tc.setTurnRate(10*math.cos(val))
        self.tc.setSlipSkid(10*math.cos(val))
        self.adi.viewUpdate.emit()
        self.alt.viewUpdate.emit()
        self.si.viewUpdate.emit()
        self.hsi.viewUpdate.emit()
        self.vsi.viewUpdate.emit()
        self.tc.viewUpdate.emit()





if __name__ == '__main__':
    app = QApplication(sys.argv)
    win = Window()

    t2 = ThreadGUI(win)
    t2.daemon = True
    t2.start()

    sys.exit(app.exec_())

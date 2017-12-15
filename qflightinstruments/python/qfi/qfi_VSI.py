#!/usr/bin/python
# -*- coding: utf-8 -*-

from __future__ import division

from PyQt5.QtGui import QTransform
from PyQt5.QtCore import pyqtSignal, QPointF, Qt
from PyQt5.QtSvg import QGraphicsSvgItem
from PyQt5.QtWidgets import QGraphicsView, QGraphicsScene, QGraphicsItem, QFrame
import math

from qfi import qfi_rc

class qfi_VSI (QGraphicsView):

    viewUpdate = pyqtSignal()


    def __init__(self,winParent):
        QGraphicsView.__init__(self)

        self.winParent=winParent

        self.viewUpdate.connect(self.update)
        
        self.m_climbRate = 0

        self.m_scaleX = 0
        self.m_scaleY = 0

        self.m_originalHeight = 240
        self.m_originalWidth = 240

        self.m_originalVsiCtr = QPointF(120,120)


        self.m_faceZ = -20
        self.m_handZ = -10
        self.m_caseZ = 10

        self.m_itemHand = None
        self.m_itemFace = None
        self.m_itemCase = None

        self.setStyleSheet("background: transparent; border: none");
        self.setHorizontalScrollBarPolicy(Qt.ScrollBarAlwaysOff)
        self.setVerticalScrollBarPolicy(Qt.ScrollBarAlwaysOff)

        self.setInteractive(False)
        self.setEnabled(False)


        self.m_scene = QGraphicsScene(self)
        
        self.setScene(self.m_scene)

        self.init()

        

    def init (self):
        self.m_scaleX = self.width() / self.m_originalWidth
        self.m_scaleY = self.height() / self.m_originalHeight


        self.m_itemHand = QGraphicsSvgItem(":/qfi/images/vsi/vsi_hand.svg")
        self.m_itemHand.setCacheMode (QGraphicsItem.NoCache)
        self.m_itemHand.setZValue( self.m_handZ )
        self.m_itemHand.setTransform( QTransform.fromScale( self.m_scaleX, self.m_scaleY ), True )
        self.m_itemHand.setTransformOriginPoint( self.m_originalVsiCtr )
        self.m_scene.addItem (self.m_itemHand)

        self.m_itemFace = QGraphicsSvgItem(":/qfi/images/vsi/vsi_face.svg")
        self.m_itemFace.setCacheMode (QGraphicsItem.NoCache)
        self.m_itemFace.setZValue( self.m_faceZ )
        self.m_itemFace.setTransform( QTransform.fromScale( self.m_scaleX, self.m_scaleY ), True )
        self.m_itemFace.setTransformOriginPoint( self.m_originalVsiCtr )
        self.m_scene.addItem (self.m_itemFace)


        self.m_itemCase = QGraphicsSvgItem(":/qfi/images/vsi/vsi_case.svg")
        self.m_itemCase.setCacheMode (QGraphicsItem.NoCache)
        self.m_itemCase.setZValue( self.m_caseZ )
        self.m_itemCase.setTransform( QTransform.fromScale( self.m_scaleX, self.m_scaleY ), True )
        self.m_itemCase.setTransformOriginPoint( self.m_originalVsiCtr )
        self.m_scene.addItem (self.m_itemCase)

        self.centerOn (self.width()/2, self.height()/2)

        self.updateView()

    def reinit(self):
        if (self.m_scene):
            self.m_scene.clear()
            self.init()


    def update(self):
        self.updateView()


    def setClimbRate (self, climbRate):
        self.m_climbRate = climbRate

        if (self.m_climbRate < -2000):
            self.m_climbRate = -2000
        if (self.m_climbRate > 2000):
            self.m_climbRate = 2000


    def resizeEvent (self, event):
        QGraphicsView.resizeEvent (self,event)
        self.reinit()

    def reset (self):
        self.m_itemHand = None
        self.m_itemFace = None
        self.m_itemCase   = None

        self.m_climbRate =  0.0


    def updateView(self):

        self.m_itemHand.setRotation( self.m_climbRate * 0.086 )

        self.m_scene.update()

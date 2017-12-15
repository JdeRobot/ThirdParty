#!/usr/bin/python
# -*- coding: utf-8 -*-

from __future__ import division

from PyQt5.QtGui import QTransform
from PyQt5.QtCore import pyqtSignal, QPointF, Qt
from PyQt5.QtSvg import QGraphicsSvgItem
from PyQt5.QtWidgets import QGraphicsView, QGraphicsScene, QGraphicsItem, QFrame
import math

from qfi import qfi_rc

class qfi_TC (QGraphicsView):

    viewUpdate = pyqtSignal()

    def __init__(self, winParent):
        QGraphicsView.__init__(self)

        self.winParent=winParent

        self.viewUpdate.connect(self.updateView)

        self.m_itemBack = None
        self.m_itemBall = None
        self.m_itemFace_1 = None
        self.m_itemFace_2 = None
        self.m_itemMark = None
        self.m_itemCase = None

        self.m_turnRate = 0
        self.m_slipSkid = 0

        self.m_scaleX = 0
        self.m_scaleY = 0

        self.m_originalHeight = 240
        self.m_originalWidth = 240

        self.m_originalMarkCtr = QPointF( 120, 120)
        self.m_originalBallCtr = QPointF( 120, -36)

        self.m_backZ = -70
        self.m_ballZ = -60
        self.m_face1Z = -50
        self.m_face2Z = -40
        self.m_markZ = -30
        self.m_caseZ = 10

        self.setStyleSheet("background: transparent; border: none")
        self.setHorizontalScrollBarPolicy(Qt.ScrollBarAlwaysOff)
        self.setVerticalScrollBarPolicy(Qt.ScrollBarAlwaysOff)

        self.setInteractive(False)
        self.setEnabled(False)

        self.reset()

        self.m_scene = QGraphicsScene(self)
        self.setScene(self.m_scene)

        self.m_scene.clear()
        self.init()

    def init(self):
        self.m_scaleX = self.width()  / self.m_originalWidth
        self.m_scaleY = self.height() / self.m_originalHeight

        self.reset()

        self.m_itemBack = QGraphicsSvgItem( ":/qfi/images/tc/tc_back.svg" )
        self.m_itemBack.setCacheMode( QGraphicsItem.NoCache )
        self.m_itemBack.setZValue( self.m_backZ )
        self.m_itemBack.setTransform( QTransform.fromScale( self.m_scaleX, self.m_scaleY ), True )
        self.m_scene.addItem( self.m_itemBack )

        self.m_itemBall =  QGraphicsSvgItem( ":/qfi/images/tc/tc_ball.svg" )
        self.m_itemBall.setCacheMode( QGraphicsItem.NoCache )
        self.m_itemBall.setZValue( self.m_ballZ )
        self.m_itemBall.setTransform( QTransform.fromScale( self.m_scaleX, self.m_scaleY ), True )
        self.m_itemBall.setTransformOriginPoint( self.m_originalBallCtr )
        self.m_scene.addItem( self.m_itemBall )

        self.m_itemFace_1 =  QGraphicsSvgItem( ":/qfi/images/tc/tc_face_1.svg" )
        self.m_itemFace_1.setCacheMode( QGraphicsItem.NoCache )
        self.m_itemFace_1.setZValue( self.m_face1Z )
        self.m_itemFace_1.setTransform( QTransform.fromScale( self.m_scaleX, self.m_scaleY ), True )
        self.m_scene.addItem( self.m_itemFace_1 )

        self.m_itemFace_2 =  QGraphicsSvgItem( ":/qfi/images/tc/tc_face_2.svg" )
        self.m_itemFace_2.setCacheMode( QGraphicsItem.NoCache )
        self.m_itemFace_2.setZValue( self.m_face2Z )
        self.m_itemFace_2.setTransform( QTransform.fromScale( self.m_scaleX, self.m_scaleY ), True )
        self.m_scene.addItem( self.m_itemFace_2 )

        self.m_itemMark =  QGraphicsSvgItem( ":/qfi/images/tc/tc_mark.svg" )
        self.m_itemMark.setCacheMode( QGraphicsItem.NoCache )
        self.m_itemMark.setZValue( self.m_markZ )
        self.m_itemMark.setTransform( QTransform.fromScale( self.m_scaleX, self.m_scaleY ), True )
        self.m_itemMark.setTransformOriginPoint( self.m_originalMarkCtr )
        self.m_scene.addItem( self.m_itemMark )

        self.m_itemCase =  QGraphicsSvgItem( ":/qfi/images/tc/tc_case.svg" )
        self.m_itemCase.setCacheMode( QGraphicsItem.NoCache )
        self.m_itemCase.setZValue( self.m_caseZ )
        self.m_itemCase.setTransform( QTransform.fromScale( self.m_scaleX, self.m_scaleY ), True )
        self.m_scene.addItem( self.m_itemCase )

        self.centerOn( self.width()/2 , self.height()/2 )

        self.updateView()

    def reinit(self):
        if (self.m_scene):
            self.m_scene.clear()
            self.init()

    def update(self):
        self.updateView()

    def setTurnRate(self, turnRate):
        self.m_turnRate = turnRate
        if (self.m_turnRate < -6):
            self.m_turnRate = -6
        if (self.m_turnRate > 6):
            self.m_turnRate = 6

    def setSlipSkid(self, slipSkid):
        self.m_slipSkid = slipSkid
        if (self.m_slipSkid < -15):
            self.m_slipSkid = -15
        if (self.m_slipSkid > 15):
            self.m_slipSkid = 15

    def resizeEvent (self, event):
        QGraphicsView.resizeEvent (self,event)
        self.reinit()

    def reset (self):
        self.m_itemCase   = None

        self.m_turnRate = 0
        self.m_slipSkid = 0

    def updateView(self):
        self.m_scaleX = self.width()  / self.m_originalWidth
        self.m_scaleY = self.height() / self.m_originalHeight

        self.m_itemBall.setRotation(-self.m_slipSkid)

        angle = (self.m_turnRate/3) * 20

        self.m_itemMark.setRotation(angle)
        self.m_scene.update()

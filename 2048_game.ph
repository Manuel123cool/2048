#!/usr/bin/python3

import random
import arcade
import pdb

SCREEN_WIDTH = 600
SCREEN_HEIGHT = 600
SCREEN_TITLE = "2048"

class Numbers:
    def __init__(self):
        self.numbers = [0]
        for i in range(0, 15):
            self.numbers.append(0)
    def randomNumber(self):
        count = 0
        while True:
            count += 1
            if count == 30:
                print("no new number space")
                break
            randomPoint = random.randrange(0, 16)
            randomNum = random.randrange(2, 5, 2)
            if self.numbers[randomPoint] == 0:
                self.numbers[randomPoint] = randomNum
                break
            
    def rightWipe(self, reNum = True):
        oneWipe = False
        for i, elem in enumerate(self.numbers):
            if elem == 0:
                continue
            if i == 12 or i == 13 or i == 14 or i == 15:
                continue
            nextNum = self.numbers[i + 4]
            if nextNum == 0:
                self.numbers[i + 4] = elem    
                self.numbers[i] = 0 
                oneWipe = True
            if nextNum == elem:
                self.numbers[i + 4] = elem + nextNum
                self.numbers[i] = 0
                oneWipe = True
        if oneWipe and reNum:
            self.randomNumber()
    def downWipe(self, reNum = True):
        oneWipe = False
        for i, elem in enumerate(self.numbers):
            if elem == 0:
                continue
            if i == 3 or i == 7 or i == 11 or i == 15:
                continue
            nextNum = self.numbers[i + 1]
            if nextNum == 0:
                self.numbers[i + 1] = elem    
                self.numbers[i] = 0 
                oneWipe = True
            if nextNum == elem:
                self.numbers[i + 1] = elem + nextNum
                self.numbers[i] = 0
                oneWipe = True
        if oneWipe and reNum:
            self.randomNumber()

    def upWipe(self, reNum = True):
        oneWipe = False
        for i in range(15, 0, -1):
            elem = self.numbers[i]
            if elem == 0:
                continue
            if i == 0 or i == 4 or i == 8 or i == 12:
                continue
            nextNum = self.numbers[i - 1]
            if nextNum == 0:
                self.numbers[i - 1] = elem    
                self.numbers[i] = 0 
                oneWipe = True
            if nextNum == elem:
                self.numbers[i - 1] = elem + nextNum
                self.numbers[i] = 0
                oneWipe = True
        if oneWipe and reNum:
            self.randomNumber()
 
    def leftWipe(self, reNum = True):
        oneWipe = False
        for i in range(15, 0, -1):
            elem = self.numbers[i]
            if elem == 0:
                continue
            if i == 0 or i == 1 or i == 2 or i == 3:
                continue
            nextNum = self.numbers[i - 4]
            if nextNum == 0:
                self.numbers[i - 4] = elem    
                self.numbers[i] = 0 
                oneWipe = True
            if nextNum == elem:
                self.numbers[i - 4] = elem + nextNum
                self.numbers[i] = 0
                oneWipe = True
        if oneWipe and reNum:
            self.randomNumber()
 
numbers = Numbers()

numbers.randomNumber()
numbers.randomNumber()

def on_draw(delte_time):
    arcade.start_render()

    arcade.draw_rectangle_filled(300, 300, 400, 400, (196, 98, 16))

    for x in range(105, 600, 100):
        arcade.draw_line(x, 100, x, 500, arcade.color.BLACK, 10)

    for x in range(105, 600, 100):
        arcade.draw_line(100, x, 510, x, arcade.color.BLACK, 10)

    def drawTxt(xPos, yPos, num):
        x = 8
        y = 430
        arcade.draw_text(str(num), x+100*xPos, y-100*yPos, 
                            arcade.color.BLACK, 30, font_name='GARA')

    count = 0
    for i in range(1,5):
        for j in range(0,4):
            drawTxt(i, j, numbers.numbers[count])
            count += 1



class MyGame(arcade.Window):
    def __init__(self, width, height, title):
        super().__init__(width, height, title)
        arcade.set_background_color(arcade.color.ASH_GREY)
    def on_key_press(self, key, modifiers):
        if key == arcade.key.RIGHT:
            numbers.rightWipe()
            numbers.rightWipe(False)
            numbers.rightWipe(False)
            numbers.rightWipe(False)
        elif key == arcade.key.DOWN:
            numbers.downWipe()
            numbers.downWipe(False)
            numbers.downWipe(False)
            numbers.downWipe(False)
        elif key == arcade.key.UP:
            numbers.upWipe()
            numbers.upWipe(False)
            numbers.upWipe(False)
            numbers.upWipe(False)
        elif key == arcade.key.LEFT:
            numbers.leftWipe()
            numbers.leftWipe(False)
            numbers.leftWipe(False)
            numbers.leftWipe(False)
     
arcade.schedule(on_draw, 1 / 80)
MyGame(SCREEN_WIDTH, SCREEN_HEIGHT, SCREEN_TITLE)
arcade.run()

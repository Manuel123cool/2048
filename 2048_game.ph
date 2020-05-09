#!/usr/bin/python3

import random
import arcade
import pdb

SCREEN_WIDTH = 600
SCREEN_HEIGHT = 600
SCREEN_TITLE = "2048"

class Numbers:
    def __init__(self):
        self.num = [0]
        for i in range(0, 15):
            self.num.append(0)
    def randomNumber(self):
        count = 0
        while True:
            count += 1
            if count == 30:
                print("no new number space")
                break
            randomPoint = random.randrange(0, 16)
            randomNum = random.randrange(2, 5, 2)
            if self.num[randomPoint] == 0:
                self.num[randomPoint] = randomNum
                break
    
    def checkFourNum(self, one, two, three, four):
        reRandom = False
        if  self.num[one] == self.num[four]:
            if self.num[two] == 0 and self.num[three] == 0:
                self.num[one] = 0
                self.num[four] *= 2
                reRandom = True

        if self.num[one] == self.num[three] and self.num[two] == 0:
            self.num[one] = 0
            self.num[three] *= 2        
            reRandom = True

        if self.num[two] == self.num[four] and self.num[three] == 0:
            self.num[two] = 0
            self.num[four] *= 2        
            reRandom = True

        num = [four, three, two, one]
        for i in range(1, 4):
            if self.num[num[i]] == self.num[num[i - 1]]:
                self.num[num[i - 1]] = self.num[num[i - 1]] * 2
                self.num[num[i]] = 0
                reRandom = True
         
        num = [one, two, three, four] 
        for j in range(1, 5):
            for i in range(0, 3):
                if self.num[num[i + 1]] == 0 and self.num[num[i]] != 0:
                    self.num[num[i + 1]] = self.num[num[i]]  
                    self.num[num[i]] = 0 
                    reRandom = True
        return reRandom
            
    def rightWipe(self):
        randNum = False 
        randNum = self.checkFourNum(0, 4, 8, 12) 
        randNum = self.checkFourNum(1, 5, 9, 13) 
        randNum = self.checkFourNum(2, 6, 10, 14) 
        randNUm = self.checkFourNum(3, 7, 11, 15)  
        if randNum:
            self.randomNumber()
    def leftWipe(self):
        randNum = False
        randNum = self.checkFourNum(12, 8, 4, 0) 
        randNum = self.checkFourNum(13, 9, 5, 1) 
        randNum = self.checkFourNum(14, 10, 6, 2) 
        randNum = self.checkFourNum(15, 11, 7, 3) 
        if randNum:
            self.randomNumber()
    def upWipe(self):
        randNum = False
        randNum = self.checkFourNum(15, 14, 13, 12) 
        randNum = self.checkFourNum(11, 10, 9, 8) 
        randNum = self.checkFourNum(7, 6, 7, 8) 
        randNum = self.checkFourNum(3, 2, 1, 0) 
        if randNum:
            self.randomNumber()
    def downWipe(self):
        randNum = False
        randNum = self.checkFourNum(12, 13, 14, 15) 
        randNum = self.checkFourNum(8, 9, 10, 11) 
        randNum = self.checkFourNum(4, 5, 6, 7) 
        randNum = self.checkFourNum(0, 1, 2, 3)
        if randNum:
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
            if numbers.num[count] != 0:
                drawTxt(i, j, numbers.num[count])
            count += 1



class MyGame(arcade.Window):
    def __init__(self, width, height, title):
        super().__init__(width, height, title)
        arcade.set_background_color(arcade.color.ASH_GREY)
    def on_key_press(self, key, modifiers):
        if key == arcade.key.RIGHT:
            numbers.rightWipe()
        elif key == arcade.key.DOWN:
            numbers.downWipe()
        elif key == arcade.key.UP:
            numbers.upWipe()
        elif key == arcade.key.LEFT:
            numbers.leftWipe()
     
arcade.schedule(on_draw, 1 / 80)
MyGame(SCREEN_WIDTH, SCREEN_HEIGHT, SCREEN_TITLE)
arcade.run()

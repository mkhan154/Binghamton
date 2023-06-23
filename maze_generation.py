from enum import Enum
import random
import numpy as np
import sys

sys.setrecursionlimit(10000)


class Directions(Enum):
	UP = 1
	DOWN = 2
	LEFT = 3
	RIGHT = 4

class Backtracking:

    def __init__(self, height, width, display_maze = True):

        if width % 2 == 0:
            width += 1
        if height % 2 == 0:
            height += 1

        self.width = width
        self.height = height
        self.display_maze = display_maze


    def create_maze(self):

        maze = np.ones((self.height, self.width), dtype=np.float)
        for i in range(self.height):
            for j in range(self.width):
                
                if i%2 == 1 or j %2 == 1:
                    maze[i, j] = 0

                if i == 0 or j == 0 or i == self.height-1 or j == self.width-1:
                    maze[i, j] = 0.5

        sx = random.choice(range(2, self.width - 2, 2))
        sy = random.choice(range(2, self.height - 2, 2))

        self.generate(sx, sy, maze)


        for i in range(self.height):
            for j in range(self.width):
                if maze[i, j] == 0.5:
                    maze[i, j] = 1
        
        

        # Start point and the end point
        maze[1, 2] = 1
        maze[self.height - 2, self.width - 3] = 1

        return maze


    def generate(self, cx, cy, grid):
	    
        grid[cy, cx] = 0.5
        if (grid[cy - 2, cx] == 0.5 and grid[cy + 2, cx] == 0.5 and
		    grid[cy, cx - 2] == 0.5 and grid[cy, cx + 2] == 0.5):
            pass
        else:
            li = [1, 2, 3, 4]
            while len(li) > 0:
                dir = random.choice(li)
                li.remove(dir)
                
                if dir == Directions.UP.value:
                    nx = cx
                    mx = cx
                    ny = cy - 2
                    my = cy - 1
                
                elif dir == Directions.DOWN.value:
                    nx = cx
                    mx = cx
                    ny = cy + 2
                    my = cy + 1
                
                elif dir == Directions.LEFT.value:
                    nx = cx - 2
                    mx = cx - 1
                    ny = cy
                    my = cy
                
                elif dir == Directions.RIGHT.value:
                    nx = cx + 2
                    mx = cx + 1
                    ny = cy
                    my = cy
                else:
                    nx = cx
                    mx = cx
                    ny = cy
                    my = cy

                if grid[ny, nx] != 0.5:
                    grid[my, mx] = 0.5
                    self.generate(nx, ny, grid)

        


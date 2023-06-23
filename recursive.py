
import random
import numpy as np


class RecursiveDivision:

    def __init__(self):
        
        self.TILE_EMPTY = 1
        self.TILE_CRATE = 0


    def create_empty_grid(self, width, height, default_value=1):
        grid = []
        for row in range(height):
            grid.append([])
            for column in range(width):
                grid[row].append(default_value)
        return grid


    def create_outside_walls(self, maze):
        # Create left and right walls
        for row in range(len(maze)):
            maze[row][0] = self.TILE_CRATE
            maze[row][len(maze[row])-1] = self.TILE_CRATE

        # Create top and bottom walls
        for column in range(1, len(maze[0]) - 1):
            maze[0][column] = self.TILE_CRATE
            maze[len(maze) - 1][column] = self.TILE_CRATE


    def make_maze_recursive_call(self, maze, top, bottom, left, right):
        # Figure out where to divide horizontally
        start_range = bottom + 2
        end_range = top - 1
        y = random.randrange(start_range, end_range, 2)
    
        # Do the division
        for column in range(left + 1, right):
            maze[y][column] = self.TILE_CRATE

        # Figure out where to divide vertically
        start_range = left + 2
        end_range = right - 1
        x = random.randrange(start_range, end_range, 2)

        # Do the division
        for row in range(bottom + 1, top):
            maze[row][x] = self.TILE_CRATE

        # Now we'll make a gap on 3 of the 4 walls.
        # Figure out which wall does NOT get a gap.
        wall = random.randrange(4)
        if wall != 0:
            gap = random.randrange(left + 1, x, 2)
            maze[y][gap] = self.TILE_EMPTY

        if wall != 1:
            gap = random.randrange(x + 1, right, 2)
            maze[y][gap] = self.TILE_EMPTY

        if wall != 2:
            gap = random.randrange(bottom + 1, y, 2)
            maze[gap][x] = self.TILE_EMPTY

        if wall != 3:
            gap = random.randrange(y + 1, top, 2)
            maze[gap][x] = self.TILE_EMPTY

        # If there's enough space, do a recursive call.
        if top > y + 3 and x > left + 3:
            self.make_maze_recursive_call(maze, top, y, left, x)

        if top > y + 3 and x + 3 < right:
           self. make_maze_recursive_call(maze, top, y, x, right)

        if bottom + 3 < y and x + 3 < right:
            self.make_maze_recursive_call(maze, y, bottom, x, right)

        if bottom + 3 < y and x > left + 3:
            self.make_maze_recursive_call(maze, y, bottom, left, x)


    def make_maze_recursion(self, maze_width, maze_height):
        maze = self.create_empty_grid(maze_width, maze_height)
        # Fill in the outside walls
        self.create_outside_walls(maze)

        # Start the recursive process
        self.make_maze_recursive_call(maze, maze_height - 1, 0, 0, maze_width - 1)
        return maze





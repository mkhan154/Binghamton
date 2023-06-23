from maze_generation import Backtracking
from sidewinder import SideWinder
from aStar import AStar
from recursive import RecursiveDivision
from matplotlib import pyplot as plt
import numpy as np



sideFlag = False

def generateBacktracking(w, h):
    maze_generator = Backtracking(w, h)
    maze = maze_generator.create_maze()
    start = (1,2)
    if w%2 == 0:
        end = (h-1, w-2)
    else:
        end = (h-2, w-3)
    
    return start, end, maze
    




def generateRecursiveDiv(w, h):
    recurser = RecursiveDivision()
    maze = np.array(recurser.make_maze_recursion(h,w))
    maze = maze.astype('float64')
    maze[1,0] = 1
    maze[h-2, w - 1] = 1
    start = (1,1)
    end = (h-2, w-2)

    
    return start, end, maze




def generateSidewinder(w, h):
    generator = SideWinder()
    maze = np.array(generator.generate(w))
    maze = maze.astype('float64')
    maze[1,0] = 1
    maze[len(maze)-2, len(maze[0]) - 1] = 1
    start = (1,1)
    end = (len(maze)-2, len(maze[0])-2)

    sideFlag = True

    return start, end, maze, sideFlag




def solAstar(maze, start, end):
    aStar = AStar(maze)
    path = aStar.aStar(start, end)
    sol = list(path.keys())
    sol.insert(0, start)
    if start == (1,1):
        sol.insert(0, (1,0))
        sol.append((len(maze)-2, len(maze[0])-1))        
    for i in sol:
            maze[i[0]][i[1]] = 0.5

    if sideFlag:
        weight = len(sol)//3
    else:
        weight = len(sol)

    return maze, sol, weight



print("-------------------------------------------------------------")
print("\tWelcome to maze generation and solving game!")
print("-------------------------------------------------------------")

print("\nWhich algorithm would you like to use to generate the maze? :\n")

print("1. Recursive Backtracking\n2. Sidewinder\n3. Recursive Division\n And Press any other key to exit \n")
choice  = int(input("Please Choose: "))




if choice == 1:
    dim = int(input("\n\nPlease Select the size of Maze : "))
    if dim > 4:
        start, end, maze = generateBacktracking(dim, dim)
    else:
        dim = int(input("\n\nPlease Reselect the size of Maze : "))
        start, end, maze = generateBacktracking(dim, dim)


elif choice == 2:
    dim = int(input("\n\nPlease Select the size of Maze : "))
    start, end, maze, sideFlag = generateSidewinder(dim, dim)

elif choice == 3:
    dim = int(input("\n\nPlease Select the size of Maze : "))
    if dim > 4:
        start, end, maze = generateRecursiveDiv(dim, dim)
    else:
        dim = int(input("\n\nPlease Reselect the size of Maze : "))
        start, end, maze = generateRecursiveDiv(dim, dim)

else:
    exit("Thanks for Playing!")


plt.title("Maze")
plt.axis('off')
plt.imshow(maze, interpolation='nearest')
plt.show()



solChoice = input("\n\nWould you like to solve the maze through Astar Algorithm? (1. Yes): ")

if solChoice == "1":
    maze, path, weight = solAstar(maze,start, end)

else:
    exit("Thanks for Playing!")



plt.title("Solution with AStar")
plt.imshow(maze, interpolation='nearest')
plt.axis('off')
plt.show()

weightChoice = input("\n\nWould you like to print weight of solution? (1. Yes): ")

if weightChoice == "1":
    print("Each step is worth one unit, And Total weight of Solution =  {}".format(weight))
print("The optimal path is as follows [x,y] :\n",path)
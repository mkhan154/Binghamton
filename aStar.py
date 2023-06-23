from queue import PriorityQueue

class AStar:

    def __init__(self, m):
        self.m = m


    def preprocess(self, maze):
        
        aStar_map = {}
        grid = []
        for i in range(len(maze)):
            for j in range(len(maze[0])):
                valList = []
                if i < len(maze)-1 and j < len(maze[0])-1 and i > 0 and j > 0:                    
                    for k in "EWNS":
                        if k == 'E':
                            if maze[i][j+1] == 1:
                                valList.append(1)
                            else:
                                valList.append(0)
                        elif k == 'W':
                            if maze[i][j-1] == 1:
                                valList.append(1)
                            else:
                                valList.append(0)

                        elif k == 'S':
                            if maze[i+1][j] == 1:
                                valList.append(1)
                            else:
                                valList.append(0)
                        else:
                            if maze[i-1][j] == 1:
                                valList.append(1)
                            else:
                                valList.append(0)
                    aStar_map[(i, j)] = valList        
                grid.append((i,j))

        return grid, aStar_map



    def h(self, cell1,cell2):
        x1,y1=cell1
        x2,y2=cell2

        return abs(x1-x2) + abs(y1-y2)

    def aStar(self, start, end):
        tempmaze = self.m.copy()
        tempmaze[0] = 0
        tempmaze[len(self.m)-1] = 0
        tempmaze[:,0] = 0
        tempmaze[:,len(tempmaze[0])-1] = 0
        grid, aStar_map = self.preprocess(tempmaze)
        end=end
        g_value={cell:float('inf') for cell in grid}
        g_value[end]=0
        f_value={cell:float('inf') for cell in grid}
        f_value[end]=self.h(end,start)

        open=PriorityQueue()
        open.put((self.h(end,start),self.h(end,start),end))
        aPath={}
        while not open.empty():
            currentCell=open.get()[2]
            if currentCell==start:
                break

            for d in range(4):
                if  aStar_map[currentCell][d]==True:
                    if d==0:
                        rootCell=(currentCell[0],currentCell[1]+1)
                    if d==1:
                        rootCell=(currentCell[0],currentCell[1]-1)
                    if d==2:
                        rootCell=(currentCell[0]-1,currentCell[1])
                    if d==3:
                        rootCell=(currentCell[0]+1,currentCell[1])

                    temp_g_value=g_value[currentCell]+1
                    temp_f_value=temp_g_value+self.h(rootCell,start)

                    if temp_f_value < f_value[rootCell]:
                        g_value[rootCell]= temp_g_value
                        f_value[rootCell]= temp_f_value
                        open.put((temp_f_value,self.h(rootCell,start),rootCell))
                        aPath[rootCell]=currentCell
        fwdPath={}
        cell=start
        while cell!=end:
            fwdPath[aPath[cell]]=cell
            cell=aPath[cell]
        return fwdPath
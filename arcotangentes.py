import math

def main():
    deg = 180.0 / math.pi 
    for i in range(171):
        ar=math.atan(i)*deg
        print(i,ar)

main()

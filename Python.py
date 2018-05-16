import math
def main():
    areat=0
    peri=0
    """punto1=input("Punto1: ")
    punto2=input("Punto2: ")
    punto3=input("Punto3: ")
    x1,y1=punto1.split(" ")
    x2,y2=punto2.split(" ")
    x3,y3=punto3.split(" ") """
    """Casos de prueba
    8,9,4,6,7,5
    3,4,4,3,5,2
    6,3,6,9,6,8
    2,5,7,5,9,5"""
    x1,y1,x2,y2,x3,y3=2,6,9,12,15,20  
    b1=comprobar(x1,x2,x3)
    b2=comprobar(y1,y2,y3)
    ladoA,ladoB,ladoC=lados(x1,x2,x3,y1,y2,y3)
    b3=comprobar_lados(ladoA,ladoB,ladoC)
    if(b1 and b2 and b3):
        areat=area(x1,x2,x3,y1,y2,y3)
        peri=perimetro(ladoA,ladoB,ladoC)
    else:
        print("No es triangulo")


def lados(x1,x2,x3,y1,y2,y3):
    ladoA=math.sqrt(((x2-x1)**2)+((y2-y1)**2))
    ladoB=math.sqrt(((x3-x2)**2)+((y3-y2)**2))
    ladoC=math.sqrt(((x1-x3)**2)+((y1-y3)**2))
    return ladoA,ladoB,ladoC

def comprobar_lados(ladoA,ladoB,ladoC):
    if (ladoA>ladoB and ladoA>ladoC and ladoA==ladoB+ladoC):
        return False
    elif (ladoB>ladoA and ladoB>ladoC and ladoB==ladoA+ladoC):
        return False
    elif (ladoC>ladoB and ladoC>ladoA and ladoC==ladoA+ladoB):
        return False
    else:
        return True
        


def  comprobar(x,y,z):
    if (x==y or y==z or x==z):
        return False
    else:
        return True


def area(x1,x2,x3,y1,y2,y3):    
    area_triangulo=abs(x1*(y2-y3)+x2*(y3-y1)+x3*(y1-y2))
    print ("Area",area_triangulo/2)

def perimetro(ladoA,ladoB,ladoC):
    perim=ladoA+ladoB+ladoC
    perim=round(perim,2)
    print("Perimetro: ",perim)

main()

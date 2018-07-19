# universe.py: video game library

__metaclass__ = type # Make sure we get new style class

class point:
    def __init__(self):
        self.exist = None

class land:
    pass

class ocean:
    pass

class biosphere:
    pass

class planet:
    def __init__(self):
        self.biosphere  = biosphere()
        self.biospheres = []
        self.size       = 0
        self.name       = 'earth'
        def getBiosphereName(self):
            return self.biosphere.getName()
        def setBiosphereName(self,name):
            self.biosphere.setName(name)
        def getBiospheres(self):
            return self.planets
        def getBiosphereName(self):
            return self.name
        def getSize(self):
            self.size = len(self.planets)
        def getBiosphere(self,ind):
            self.biosphere = self.biosphere[ind]
            return self.biosphere
        def addBiosphere(self,star):
            self.biospheres.append(biosphere)
            self.size = self.size + 1

class star_g:
    number = 0
    def __init__(self):
        self.planet  = planet()
        self.planets = []
        self.size    = 0
        self.name    = 'sol'
    def getPlanetName(self):
        return self.planet.getName()
    def setPlanetName(self,name):
        self.planet.setName(name)
    def getPlanets(self):
        return self.planets
    def setStarName(self,name):
        self.name = name
    def getStarName(self):
        return self.name
    def getSize(self):
        self.size = len(self.planets)
    def getPlanet(self,ind):
        self.planet = self.planets[ind]
        return self.planet
    def addPlanet(self,star):
        self.planets.append(planet)
        self.size = self.size + 1

class star:
    def __init__(self):
        self.planet  = planet()
        self.planets = []
        self.size    = 0
        self.name    = 'sol'
    def getPlanetName(self):
        return self.planet.getName()
    def setPlanetName(self,name):
        self.planet.setName(name)
    def getPlanets(self):
        return self.planets
    def setStarName(self,name):
        self.name = name
    def getStarName(self):
        return self.name
    def getSize(self):
        self.size = len(self.planets)
    def getPlanet(self,ind):
        self.planet = self.planets[ind]
        return self.planet
    def addPlanet(self,star):
        self.planets.append(planet)
        self.size = self.size + 1

class starSystem:
    def __init__(self):
        self.star  = star()
        self.stars = []
        self.size  = 0
        self.name  = 'foo'
    def getStarName(self):
        return self.star.getName()
    def setStarName(self,name):
        self.star.setName(name)
    def getStarSystem(self):
        return self.stars
    def getStarSystemName(self):
        return self.name
    def getSize(self):
        self.size = len(self.stars)
    def getStar(self,ind):
        self.star = self.stars[ind]
        return self.star
    def addStar(self,star):
        self.stars.append(star)
        self.size = self.size + 1

class starSystems:
    def __init__(self):
        self.starSystem = starSystem()
        self.starSystems = []
    def getStar(self,row,col):
        return self.starSytems[row,col]
    def getStarSystems(self):
        return self.starSystems
    def getSize(self):
        self.rows = len(self.starSystems)
        self.cols = len(self.starSystems)
    def getStarSystem(self,row,col):
        return self.starSystems[row,col]
    def setStarSystem(self,row,col,starSys):
        self.starSystem[row,col] = starSys
      
# These two classes are WIP  
class galaxy:
    def __init__(self):
        self.starSystems = starSystems()
        self.rows = 10
        self.cols = 10
        self.create()
        self.starSystemsArray = []
        self.starSystemsArray.append(self.starSystems)
        self.starSystemsArray.append(self.starSystems)
    def create(self):
        rows = []
        for i in range(rows):
            for j in range(cols):
                row.append(self.starSystems)
            self.starSystemsArray.append(row)
    def getStarSystems(self):
        return self.starSystemsArray
    def getSize(self):
        self.rows = len(self.starSystemsArray)
        self.cols = len(self.starSystemsArray[0])
    def getStarSystem(self,row,col):
        return self.starSystemsArray[row,col]
    def setStarSystem(self,row,col,starSys):
        self.starSystemArray[row,col] = starSys
    def addStarSystem(self,row,col,starSys):
        pass
    def removeStarSystem(self,row,col,):
        pass
    
class universe:
    def __init__(self):
        self.galaxy = galaxy()
        self.galaxies = []
        self.distance = 1
        self.points = []
        self.points.append([])
        self.points.append([])
    def setUniv(self,distance,points):
        self.points = points
        if not points:
            print "WARNING: Universe is empty"
        else:
            self.points[0].append(points[0])
            self.points[1].append(points[1])
            self.points[2].append(points[2])
    def getUniv(self):
        return self.points
    def addGalaxy(self,star):
        self.galaxies.append(galaxies)
        self.size = self.size + 1
        
        

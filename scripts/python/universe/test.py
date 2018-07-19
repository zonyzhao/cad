#!/usr/local/bin/python3

###############################################
# This is a "sandbox" script used to explore the
# parent/child - "has a relationships" between
# objects.
# The ultimate goal would to have a mechanism
# to identify if a target object is a child
# instance of a parent object. If is is we 
# want a mechanism to determine who the parent
# of the child is (lost child in the grocery
# store metaphor). As a stretch goal, it would
# be good to know if an object is a parent
# and what kind of children does it have.
#################################################

#################################################
# Explaination: we are creating a universe where
# a universe has galaxies, galaxies have starSystems,
# starSystems have stars, stars have planets and 
# planets have bioshperes
#################################################
# 
# This somewhat complex example can be used to 
# "tunnel" down from a universe to a biom. It can 
# also be messed with to say "loose" planets and 
# then attempt to return them to their proper locations
# using implemented parent child relationships.
##################################################
# The method implemented below may not be the best
# but it has worked within complex python cad
# applications. There is however lots of room 
# for improvements ...
##################################################
import sys
import string
import time
import math
import struct
import os
import universe
###############################################
# Star Testing (global/class/static Variables)
# this just checks the class variable
# funtionality. Might be able to use 
# this to create helpful ids/tags
# class variables: bound to class
# instance variables; bound to object instances
###############################################
# Object #1
star0g = universe.star_g()

dir(universe.star_g)
dir(star0g)

# Accessing the class variable
universe.star_g.number = 1
# Acessing the object variable
star0g.name

universe.star_g.number = 1
star0g.setStarName('sol0a')

star0g.getStarName()

universe.star_g.number

# Object #2
star1g=universe.star_g()
universe.star_g.number = 2
star1g.setStarName('sol0b')

star1g.getStarName()
universe.star_g.number

star0g.getStarName()
star1g.getStarName()

# Static Class Variable has kept track of 
# how many start_g objects we have instanced
universe.star_g.number

########################
# Star Testing
# (No class variables)
########################

# Star 0
star0 = universe.star()
star0.getStarName()
star0.setStarName('sol0')
star0.getStarName()

universe.star.number
#Traceback (most recent call last):
#  File "<stdin>", line 1, in <module>
#AttributeError: type object 'star' has no attribute 'number'

# Star 1
star1 = universe.star()
star1.getStarName()
star1.setStarName('sol1')

star0.getStarName()
star1.getStarName()


########################
# Star System Testing
########################
ss = universe.starSystem()
ss.getStarSystemName()
# let's add some "children"
# stars to our "parent" starSystem
ss.addStar(star0)
ss.addStar(star1)

# let's grab the children references
# from the parent
s0=ss.getStar(0)
s0.name
s1=ss.getStar(1)
s1.name

dir(s0)
# Poor star s0 is now "lost". We have no
# way to find out where she came from 
# in object space. The program has no 
# way of finding the child objects parents
# We can do it with text ids/tags, but is 
# there a way to do it in the python object
# system??

# Galaxy Object Testing - WIP
# galaxy is an 3-D array of star systems objects
galaxy = universe.galaxy()

ss0 = universe.starSystem()
ss1 = universe.starSystem()
galaxy.setStarSystem(0,0,ss0)
galaxy.setStarSystem(2,1,ss1)


ss0name = ss0.name
ss1name = ss1.name

ss = galaxy.getStarSystem('1,1')

ss0=galaxy[0]
ss1=galaxy[1]

ss0.getName()
ss1.getName()

# Universe Object Testing - WIP
universe = universe.universe()

universe.getUniv()

points = []
points.append([])
points.append([])




































































































































































































































.

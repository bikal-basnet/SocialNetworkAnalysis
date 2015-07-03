#	vim:shiftwidth=2:tabstop=2:expandtab:fo+=r:cc=57:tw=57
#=======================================================
# Title: Introduction to Social Network Analysis with R,
# part 2: Basic SNA with R
#
# Author: Michal Bojanowski <m.bojanowski@uw.edu.pl>
#
# Description:
#
# Script used during the second part of the workshop
# "Introduction to SNA with R" during the Sunbelt XXXIII
# (Hamburg, 2013-05-21)
#
# Licence:
#
# Creative Commons Attribution-NonCommercial-ShareAlike 
# CC BY-NC-SA
# http://creativecommons.org/licenses/by-nc-sa/3.0/
#
#=======================================================


# loading package igraph
library(igraph)





#=======================================================
# Network objects
#=======================================================



### Creating small networks by hand


# Using 'graph' function supply a vector of node ids.
# Edges will be created between subsequent pairs of
# nodes. Here: 1-2, 2-3, 2-4 etc. Argument 'directed'
# determines if the resulting network will be directed.

g <- graph( c(1,2, 2,3, 3,4, 4,5, 3,1, 2,1) ,
           directed=TRUE)
g           # summary information
str(g)      # symbolic edges
plot(g)     # network picture

# undirected example
g <- graph( c(1,2, 2,3, 3,4, 4,5, 3,1), directed=FALSE)
g
str(g)
plot(g)


# Other functions to create specific graphs:
#
# graph.lattice = grids/lattices/toruses (can be high
# dimensional)
#
# graph.ring = rings
#
# erdos.renyi.game = generate pure random network
#
# barabasi.game = generate a network using
# Barabasi-Albert preferential attachment algorithm


# Interactive network pictures
tkplot(g)





### Creating networks from data


## Creating networks from adjacency matrices

# Load adjacency matrix of Input-Output data
setwd("C:\\Users\\Lenovo B4400\\Google Drive\\0 Projects\\Terrorising the Terrorists\\snar\\")
getwd()
load("ioa.rda")
ls()
ioa
str(ioa)  # matrix 21x21 of inter-sector commodity flows

# network from adjacency matrix
io <- graph.adjacency(ioa, mode="directed", weight=TRUE)

# values of flows are stored as tie attribute called
# "weight", more on attributes later

# this is almost complete network, note the loops
# (self-ties)
plot(io)  



## Networks from data frames


# Classroom network

# Edgelist
classroom.e <- read.csv("ibe-e.csv", as.is=TRUE)
classroom.e
# Nodes and their attributes
classroom.v <- read.csv("ibe-v.csv", as.is=TRUE)
classroom.v

# Create network object from two data frames
classroom <- graph.data.frame(classroom.e, directed=TRUE,
                              vertices=classroom.v)

# Picture
plot(classroom)






#=======================================================
# Basic properites and relational information
#=======================================================


### Simple network-level descriptions

# Classroom network
vcount(classroom) # number of nodes
ecount(classroom) # number of edges
graph.density(classroom)  # density (very sparse)

# IO network
vcount(io)
ecount(io)
graph.density(io, loops=TRUE)




### Degrees and their distribution

# vector of degrees
degree(classroom)  # total degree
degree(classroom, mode="in")   # in-degree
degree(classroom, mode="out")  # out-degree


summary(degree(classroom))

# degree distribution
degtab <- table( degree(classroom) )
degtab
plot( degtab ) # plot degree distribution





### Extracting relational information


# extracting adjacency matrix

# full adjacency matrix
get.adjacency(g, sparse=FALSE)

# only upper triangle ('g' is undirected)
get.adjacency(g, type="upper", sparse=FALSE)

# extracting edgelist
get.edgelist(g)
get.edgelist(classroom)


### simplify networks
# Remove:
# 1. loops
# 2. multiple edges

plot(io)
ios <- simplify(io) # remove loops
io
ios
plot(ios)



#=======================================================
# Vertex / edge / graph attributes
#=======================================================

# names and types of defined attributes are printed
classroom
io

### Accessing vertex attributes
# Gender of classroom pupils
gender <- get.vertex.attribute(classroom, "female")
gender
table(gender)

# ISEI of the parents
plot( get.vertex.attribute(classroom, "isei_m"),
     get.vertex.attribute(classroom, "isei_f"),
     xlab="ISEI of mother",
     ylab="ISEI of father",
     asp=1)







### Accessing edge attributes

# inter-sectoral flows from IO network
ecount(io)
e <- get.edge.attribute(io, "weight")
str(e)
summary(e)
plot(density(e))






### Setting vertex attributes

# All attribute-setting functions return a network with
# the attribute set.

# Add an attribute with the weights rescaled (divided by
# 100) and saved under new name "w100"
w <- get.edge.attribute(io, "weight")
io100 <- set.edge.attribute(io, "w100", value= w / 100 )
io100


# analogously 'set.vertex.attribute' for node attributes




### Network (graph) attributes

# Network attributes are attributes of the entire network

# For example, we can store the coordinates of the nodes
# used for plotting

# compute F-R layout for the classroom network
lay <- layout.fruchterman.reingold(classroom)
# 'lay' is a two-column matrix, rows correspond to nodes,
# columns to X and Y coordinates
dim(lay)
head(lay)
# add as a graph attribute of classroom network
classroom2 <- set.graph.attribute(classroom, "layout",
                                 lay)

# plot with precomputed layout
plot(classroom2, vertex.size=5, edge.arrow.size=.5,
     vertex.label=NA)


# Any other network-level data can be added







#=======================================================
# Packages 'igraph' and 'network' clashes
#=======================================================

# There are numerous name conflicts (functions with the
# same name exist in both packages)

library(network)

# R will list names of the functions that are conflicing.
# The functions loaded last have precedence: here
# versions from package 'network' mask the versions from
# package 'igraph'.

# The following object(s) are masked from ‘package:igraph’:
# 
#     add.edges, add.vertices, %c%, delete.edges, delete.vertices,
#     get.edge.attribute, get.edges, get.vertex.attribute, is.bipartite,
#     is.directed, list.edge.attributes, list.vertex.attributes, %s%,
#     set.edge.attribute, set.vertex.attribute

# loaded packages (namespaces)
loadedNamespaces()

# R looks for objects (and functions) by searching places
# in specific order
search()


# For example, looking for 'get.edges' function it will
# first look in Workspace (aka Global Enironment), then
# in package "network", then in "igraph", and so on.

# Found in package "network" even though it also exist in
# package "igraph"
get.edges

# If we define our own version of 'get.edges':
get.edges <- function() cat("My own 'get.edges'\n")
get.edges
get.edges() # use my own copy
rm(get.edges) # remove the version in Workspace


# Two strategies to deal with the problem
#
# 1. Detach packages that are not used
#
# 2. In ambiguous situations add a reference to the
# package where the function is coming from


# Ad 1. Detaching packages
search()
detach("package:network")
search()

# version from package 'igraph'
get.vertex.attribute

# attach package "network" again
attachNamespace("network")

# version from package 'network'
get.vertex.attribute



# Ad. 2 Explicitely referring to a package with '::'
# (double colons)


search()
loadedNamespaces()

get.vertex.attribute

network::get.vertex.attribute
igraph::get.vertex.attribute

# calling on 'classroom' gives error
get.vertex.attribute(classroom, "female")
igraph::get.vertex.attribute(classroom, "female")




#=======================================================
# Bonus topic:
# Handling attributes in package "network"
#=======================================================


### Package 'network'

library(network)
library(intergraph)

# creating object of class 'network' from IO data
ionet <- as.network(ioa, matrix.type="adjacency")
# add edge weights (not added by default)
set.edge.value(ionet, "weight", ioa)


# accessing and setting node/tie/network attributes
get.vertex.attribute(ionet, "vertex.names")
get.edge.value(ionet, "weight")

# to set attributes use:
# set.vertex.attribute
# set.edge.attribute
# set.network.attribute

# to delete attributes use:
# delete.vertex.attribute
# delete.edge.attribute
# delete.network.attribute

# example plotting using network package
plot(ionet)



# Package "network" provides operators that can be used
# to access and assign attributes
ionet %v% "vertex.names"  # vertex attribute
ionet %e% "weight"  # edge attribute
ionet %n% "directed"  # network attribute


ionet %n% "description" <- "IO data"
ionet %n% "description"


# Package "igraph" provides similar functionality with
# V() and E() functions.  They not only enable
# accessing/setting attributes but also performing
# various computations.




#=======================================================
# Package "intergraph"
#=======================================================


# Converting between "igraph" and "network" objects using
# functions 'asIgraph' and 'asNetwork' from package
# "intergraph"

# 'io' is of class "igraph", convert to "network"
ionet2 <- asNetwork(io)
ionet2
# convert back to "igraph"
ionet3 <- asIgraph(ionet2)

io
ionet3 # note extra attributes copied from 'ionet2'

plot(ionet3)
plot(ionet2)






# Detach package "network" at this point
detach("package:network")



#=======================================================
# Vertex and edge sequences
#=======================================================

### Vertex sequences with V()

# Vertex sequence of classroom network
V(classroom)

# Behaves largely like a vector of node ids
length(V(classroom))
V(classroom)[1:2]

# Can be used to get and set vertex attributes
V(classroom)$female
# Add attribute "male"
V(classroom)$male <- ! V(classroom)$female
classroom




### Edge sequences with E()

# Works analogously to V()

# wieghts of edges in 'io' network
E(io)$weight




### Subscripting vertex and edge sequences

# Works like with vectors, but with more features:
#
# a) Attributes are found by their names
#
# b) Additional functions to be used INSIDE square
# brackets ONLY

# Selecting vertexes/edges based on values of their
# attributes, e.g.: select the "Information" vertex
V(io)
i <- V(io)[ name == "Information" ]
i

# Select edges adjacent to a specified vertex with 'adj'
E(io)[  adj(i) ]
# Their weights
E(io)[  adj(i) ]$weight

# or only those outgoing from that node
E(io)[  from(i) ]$weight # flows from information sector

# or incoming to that node
E(io)[  to(i) ]$weight # flows to information sector



# Value-added for an industry sector is a difference
# between the amount of $$$ its products were sold for,
# and the amount of $$$ it has spent to purchase
# production inputs. In network terms it is the
# difference between the sum of the weights on the
# outgoing ties, and the sum of the weights on the
# incoming ties.

# value-added for Information sector
sum(E(io)[ to(i) ]$weight) - sum(E(io)[ from(i) ]$weight)




#=======================================================
# Subgraphs and components
#=======================================================


### Components (clusters)


k <- clusters(classroom)
k
# 'k' is a list with:
# membership  =  vector assigning nodes to components
# component size = number of nodes in each component
# number of components  

# "strong" = relationships have to go both ways
k2 <- clusters(classroom, "strong")
k2


### Paths

# Matrix of shortest paths between nodes
shortest.paths(classroom)

average.path.length(classroom)


### Subgraphs

# Create subgraph containing all nodes in the largest
# strongly connected component.
# Using 'induced.subgraph'.

which.max( k2$csize )
i <- which(k2$membership == which.max(k2$csize))
# largest component of the college network
classroom.lc <- induced.subgraph(classroom, V(classroom)[i])

plot(classroom.lc, vertex.size=5, vertex.label=NA,
     edge.arrow.size=.5)




# Create subgraph of IO network by dropping edges with
# small weights.

# Let's preserve 30% of edges with the largest weight.
# Weight has to be larger than 70% quantile
qu <- quantile(E(io)$weight, probs=0.7)
iosmall <- delete.edges(ios,   E(ios)[ weight < qu]    )
plot(iosmall)


# delete vertex no 17 ("Art, entertainment...")
iosmall2 <- delete.vertices(iosmall, V(iosmall)[17] )
plot(iosmall2)







#=======================================================
# Network visualization
#=======================================================

# see ?igraph.plotting for detailed explanation of all
# the options





### Layouts

# some available layouts
# Default is Fruchterman-Reingold


# circle layout
plot(classroom, layout=layout.circle)
# Kamada-Kawai
plot(classroom, layout=layout.kamada.kawai,
     vertex.label=NA, vertex.size=5, edge.arrow.size=0.5)
# Multidimensional Scaling
plot(classroom, layout=layout.mds)

# other layouts, see ?igraph::layout




### Network plotting examples

# Vertex color depending on gender, without labels
vcol <- c("darkred", "darkblue")[V(classroom)$female + 1]
vcol
plot(classroom, vertex.size=5, vertex.label=NA,
     vertex.color=vcol, edge.arrow.size=0.5)

# Curved edges
# 'edge.curved' can be between 0 and 1
plot(classroom, vertex.label.color="white",
     vertex.color=vcol, edge.curved=0.6,
     edge.arrow.size=0.5, vertex.size=10)

# vertex frames color
plot(classroom, vertex.label.color="black",
     vertex.frame.color="gray", vertex.color="white",
     edge.curved=0.2, edge.arrow.size=.5)



# Vertex and edge attributes with names including
# "color", "label", "size", etc. are used by the plotting
# function. Instead of specifying an argument to 'plot'
# we can set an appropriate attribute.
#
# Example: Highlight ties involving at least one girl

# default edge color
E(classroom)$color <- "gray"

# verify
plot(classroom, edge.arrow.size=.5, vertex.color=vcol,
     vertex.label.color="white")

# set attribute 'color' for edges sent by girls
female.ids <- V(classroom)[female]
female.ids
E(classroom)[ from(female.ids) ]$color <- "blue"

plot(classroom, edge.arrow.size=.5, vertex.color=vcol,
     vertex.label.color="white", edge.curved=0.2)




















#=======================================================
# Descriptive SNA
#=======================================================


### Network diameter

# diameter: longest shortest path
# by default directed
diameter(classroom)
diameter(classroom, directed=FALSE)

# get vertex ids of nodes on the longest shortest path
l <- get.diameter(classroom)
l

# color the edges adjacent to these vertices (color the
# shortest path itself)
E(classroom)$color <- "gray"
E(classroom, path=l )$color <- "red"
# color the vertices on the path
V(classroom)$color <- "lightblue"
V(classroom)[l]$color <- "red"

plot(classroom, vertex.size=5, vertex.label=NA,
     edge.width=2, edge.arrow.size=0.5,
     edge.curved=0.1)






### Centrality

# vector of betweenness centrality scores
b <- betweenness(classroom)
b

# eigenvector centralities
ec <- evcent(classroom)
str(ec)
ec <- ec$vector
ec
# Dotchart is a barplot alternative
dotchart(ec)


# closeness
closeness(classroom)





### Bonus topic: degree mixing

degs <- degree(classroom)
# edge list with numeric ids (start from 0 so +1)
el <- get.edgelist(classroom, names=FALSE)
head(el)
deglist <- apply(el, 2,    function(x) degs[x]    )
head(deglist)

plot(jitter(deglist), 
  main="Degree mixing",
  xlab="Sender", ylab="Receiver")



# outdegree vs indegree
deglist2 <- cbind( degree(classroom, mode="out")[el[,1]],
                  degree(classroom, mode="in")[el[,2]] )
plot(jitter(deglist2),
     xlab="Sender outdegree",
     ylab="Receiver indegree")





### Gender segregation

# Create a mixing matrix
el <- get.edgelist(classroom, names=FALSE)
female <- get.vertex.attribute(classroom, "female")
genderel <- apply(el, 2, function(x) female[x])
head(genderel)
# mixing matrix
mm <- table( ego=genderel[,1], alter=genderel[,2])
mm



# Let's create a function!
mixingm <- function(g, attrname)
{
  el <- get.edgelist(g, names=FALSE)
  a <- get.vertex.attribute(g, attrname)
  genderel <- apply(el, 2, function(x) a[x])
  head(genderel)
  # mixing matrix
  mm <- table( ego=genderel[,1], alter=genderel[,2])
  mm
}

# using it
mixingm(classroom, "female")



# Let's implement E-I coefficient (Krackhard & Stern)
# E-I = (between_group -- within_group) / total_ties
ei <- function(g, attrname)
{
  m <- mixingm(g, attrname)
  ( m[1,2] + m[2,1] - m[1,1] - m[2,2] )  / sum(m)
}

ei(classroom, "female")







### Bonus topic: community detection

# grouping nodes into communities by majority voting in the
# neighborhoods
com <- label.propagation.community(classroom)
com
str(com)

plot( classroom, vertex.color=com$membership,
     vertex.size=5, vertex.label=NA, edge.arrow.size=0.5)

# other community detection functions:
# spinglass.community
# fastgreedy.community






### minimum spanning tree

# a tree connecting all the nodes

mst <- minimum.spanning.tree(iosmall, algorithm="unweighted") # unweighted
# a subgraph
mst

# weighted: shortest path = minimal weight
# we need maximal weight so inverse the weigts (1/weight)
mstw <- minimum.spanning.tree(io, weight=1/E(io)$weight)

sum(E(iosmall)$weight)
sum(E(mst)$weight)
sum(E(mstw)$weight)

plot(mstw, vertex.label=V(mstw)$name)

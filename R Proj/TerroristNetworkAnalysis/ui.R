#library(shiny)
# library(markdown)
#install.packages('devtools')
#devtools::install_github('rstudio/shinyapps')
# shinyapps::setAccountInfo(name='analysenetwork', token='851D3A14858D9D58F3207FCBE707B3D5', secret='v9AET0TzVcfq3SNVVXJwIz4KgT9f97fYVIS9Dyek')
# library('shinyapps')
# shinyapps::deployApp('path/to/your/app')
# shinyapps::deployApp();
# setwd("C:/Users/Lenovo B4400/Google Drive/0 Projects/Terrorising the Terrorists/R Proj/TerroristNetworkAnalysis/")
#getwd()


# Define UI for application that draws a histogram
shinyUI(fluidPage(
  titlePanel("Network Analysis Based on Communication Pattern"),
  
  navlistPanel( "Load Network File and Explore",    
    tabPanel("1. Load Network File ",
             # Sidebar with a slider input for the number of bins
             sidebarLayout(position = "left",                
                           sidebarPanel(      
                             fileInput('file1', 'Choose CSV File',
                                       accept=c('text/csv', 
                                                'text/comma-separated-values,text/plain', 
                                                '.csv')),
                             tags$hr(),
                             checkboxInput('header', 'Header', TRUE),
                             radioButtons('sep', 'Separator',
                                          c(Comma=',',
                                            Semicolon=';',
                                            Tab='\t'),
                                          ','),
                             radioButtons('quote', 'Quote',
                                          c(None='',
                                            'Double Quote'='"',
                                            'Single Quote'="'"),
                                          '"'
                             )
                           ),          
                           mainPanel(
                             #h3(textOutput("text1")),
                             #plotOutput("plot"),
                             tableOutput('contents') 
                           )
             )
    ),
    tabPanel("2.0 Operational Organisatinal Structure",
             # Show a plot of the generated distribution
             mainPanel(      
               h4("Sub Operational units within the Terrorist Networks"),
               #              p("Comparing it with the actual dataset of the hijackers there were 4 hijacks 
               #   and 4 crashes and lets say 4  communities hence. We then compare the hijackers set with the
               #   community formed by our algorithms and we find that  our community cluster formed is quite 
               #   accurately predicted the hijackers community. 
               #   Our analysis points out that Nawaf Alhazmi, Hani Hanjour, Salem Alhazmi, Khalid Almihdar 
               #   and Majed Moqed are the prominent members in their community in terms of their eigen vector
               #   centrality. Community represented in red color. And in fact they were the ones who crashed 
               #   Fligh AA #77 that crashed into pentagon.
               #   Similarly Ahmed Alhaznaw, Saeed Alghamdi, Ahmed Alnaw and friend represented in green , in 
               #   reality were responsible for UA #93 that crashed into Pennsylvania, are clustered in a 
               #   community.
               #   Similarly if we have a  network of terrorist, we can tell even without having other attribute
               #   information, the different clusters of network and who are the critical players in the 
               #   community and who are the link chain from one community to another community.
               #   "),
               p("Community represented in red color crashed Flight AA #77 into pentagon.
  Similarly Ahmed Alhaznaw, Saeed Alghamdi, Ahmed Alnaw and friend represented in green crashed
      UA #93 into Pennsylvania"),
               plotOutput("OperationalUnits", width= "100%")      
               # plotOutput("distPlot")      
             )           
    ),
    tabPanel("2.1 Organisational Strategic Unit ",
             
             # Show a plot of the generated distribution
            
               h4("Central Key Players  of the terrorist network"),
               p("These individuals are central to the functioning of the network. 
                 These people also connect people to a network that otherwise would be isolated from the core"),
               p("Impact : identifying these key players of the network are useful in identifying the strategic network structure. 
                 They are responsible for defining   the strategy for their operation"),
               
               plotOutput("KeyPlayers")      
               # plotOutput("distPlot")      
               
             ),
    tabPanel("2.2 Organisational Operational Unit ",
             # Show a plot of the generated distribution             
               h4(":Cell Leaders / Ring Leaders, Ring leaders of the local unit"),
               p("These individuals are responsible for the operational activites of the network.
                 These  individuals play a key role for normal day to day activity of the cell, however they are least likely to
                 take part in strategy setting for the organisation. "),
               plotOutput("OperationalUnitPlayers", width = "200%")      
               # plotOutput("distPlot")                     
             ),
    tabPanel(" 2.3 Information / Inventory Flow Path ",
             # Show a plot of the generated distribution
             mainPanel(      
               h4("information radiators"),
               p("In a closed  network, the objective is to maximise the information flow with minimised actors involved. 
                 Simply because the more actors are involved the  increased is the chance of 
                 exposure which is what closed networks try to avoid. 
                 Hence information has to flow through the shortest path and hence through them.
                 Usually this would indicate that the persons is an important gatekeeper of information betweeen disparate groups."),
               plotOutput("InformationFlowPath")      
               # plotOutput("distPlot")      
               )
             )  ,
    tabPanel("2.4 Information Broadcasters / Trace Candidate ",
             # Show a plot of the generated distribution
             mainPanel(      
               h4("information radiators"),
               p("This represent the quickest way to
                 spread information throughout theinformation in the shortest possible time.
                 Critical information that has to be spread to all the members, often flow through them.
                 They allso are the most candidate individuals to be traced closely to maximally explore
                 the network. since they have the closent path to  most of the nodes in the network. 
                 "),
               p("It takes the least amount of time for the information to spread from 
                 Mohammed Attat to others. Followed by Nawaf Alhazmi, Hani Hanjour, 
                 Abdul Aziz Alomari, Marwan Al-shehhi i.e if you have to spread the 
                 information fast  through the netowrk e.g instance  of raid  or other 
                 vital information then the network will likely choose those points.
                 The fact that Mohammed Atta has High EV and high BC indicates that by
                 tracing him, we can reach more core group of memebers. 
                 e.g more people contact generals i.e his / her juniors (low EV).
                 and a general contacts other generals(high EV, high BC)"),
               plotOutput("InformationBroadcasters")      
               # plotOutput("distPlot")      
               )           
               ),
      
    tabPanel("2.5 Coordinators ",
             # Show a plot of the generated distribution
             mainPanel(      
               h4("Ring leaders of the local unit"),
               p("These individuals are responsible for the operational activites of the network.
               These  individuals play a key role for normal day to day activity of the cell, however they are least likely to
               take part in strategy setting for the organisation. "),
               plotOutput("OperationalUnitPlayers2")      
               # plotOutput("distPlot")      
             )           
    ),
    tabPanel("2.6 More ",
             # Show a plot of the generated distribution
             mainPanel(      
               h4("More analytical sections will be added later")
             )
    )
  )
)
)

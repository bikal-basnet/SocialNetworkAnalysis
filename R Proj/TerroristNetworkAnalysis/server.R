library(shiny)
library('arulesViz')
library(igraph)



# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  # Expression that generates a histogram. The expression is
  # wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should re-execute automatically
  #     when inputs change
  #  2) Its output type is a plot
  
  # always give top 5 or top 10 . People cannot remember all and visualise all
  
#   setwd("C:\\Users\\Lenovo B4400\\Google Drive\\0 Projects\\Terrorising the Terrorists\\Data\\")
#   getwd()
#   data <- read.csv("911 dataset As CSV-edit.csv",head=FALSE, sep = ",")
#   DAll <- as.matrix(data,43,43,byrow=TRUE)  
#   DtWithName <- DAll
#   DtWithName
#   colnames(DtWithName) = c("Nawaf Alhazmi","Ahmed Alnami","Saeed Alghamdi","Ahmed Alghamdi","Hamza Alghamdi","Abdul Aziz Alomari","Mohamed Atta","Ramzi Bin al-Shibh","Salem Alhazmi","Hani Hanjour","Yazid Sufaat","Walid Ba Attas","Khalid Almihdar","Majed Moqed","Nabil al - Marabh","Ahmed Al Haznaw","Raed Hijazi","Mohand Alsheri","Ziad Jarrah","Waleed Alshehri","Marwan Al-shehhi","Wail Alshehri","Satam Suqami","Fayez Ahmed","Said Bahaji","Zakariya Essabar","Mounir El Motassadeq","Mohamed Haydar Zammar","Mahmoun Darkazanli","Essid Sami","Abdelghani Mzoudi","Ahmed Khalil","Imad Eddin","Agus Budi man","Mustafa Ahmed al-Hisawi","Khalid Shaikh Mohammed","Zacarias Moussaoui","Faisal Al Salmi","Rayed Mohammed Abdullah","Fahad al Quso","Ahmed Al-Haha","Bandar Alhazmi","Mohamed Abdi")
#   G1<-graph.adjacency(DtWithName, mode=c("undirected")) ;
#   
 # inFile;
  G1;
  data;
  header;
  
  
  output$contents <- renderTable({
    
    # input$file1 will be NULL initially. After the user selects
    # and uploads a file, it will be a data frame with 'name',
    # 'size', 'type', and 'datapath' columns. The 'datapath'
    # column will contain the local filenames where the data can
    # be found.
    
    inFile <- input$file1    
    if (is.null(inFile)){return(NULL)} 
    else {    
      data<-read.csv(inFile$datapath, header=input$header, sep=input$sep, quote=input$quote);    
      DAll <- as.matrix(data,nrow(data),nrow(data),byrow=TRUE)          
      G1<-graph.adjacency(DtWithName, mode=c("undirected")) ;      
      header <- colnames(data);
      headerPresent <-input$header;
      TrnsDataset200<-read.csv(inFile$datapath, header=input$header, sep=input$sep, quote=input$quote)
    }
    
  })
  output$KeyPlayers <- renderPlot({
    inFile <- input$file1   
    if (is.null(inFile)){  return(NULL) }        
    data<-read.csv("0 911 dataset As CSV-edit.csv", header=FALSE, sep=',');       
    
#    data<-read.csv(inFile$datapath, header=input$header, sep=input$sep, quote=input$quote);       
    DAll <- as.matrix(data,nrow(data),nrow(data),byrow=TRUE)          
    G1<-graph.adjacency(DtWithName, mode=c("undirected")) ;             
    plot(G1, layout = layout.fruchterman.reingold, vertex.size = 20*evcent(G1)$vector, main = 'Central key players in a network');
    
#      if (input$header) {          
#         plot(G1, layout = layout.fruchterman.reingold, vertex.size = 20*evcent(G1)$vector, vertex.label = as.vector(header), main = 'Central key players in a network')
#     }else{      
#       plot(G1, layout = layout.fruchterman.reingold, vertex.size = 20*evcent(G1)$vector, main = 'Central key players in a network')    
#     }       
#     plot(G1, layout=layout.kamada.kawai , vertex.size = 20*evcent(G1)$vector, vertex.label = as.vector(rownames(cent1)), main = 'Network Visualization in R')    
   # plot( wc, G1, layout = layout.kamada.kawai ,vertex.size = 20*evcent(G1)$vector)
  #  plot( wc, G1, layout = layout.kamada.kawai ,vertex.size = degree(G1))    
  }, height = 1200, width = 1300)
  
  output$OperationalUnitPlayers <- renderPlot({
    # plot(G1, layout = layout.fruchterman.reingold)
    # plot(G1, layout = layout.fruchterman.reingold, vertex.size = 20*evcent(G1)$vector, vertex.label = as.vector(rownames(cent1)), main = 'Network Visualization in R')    
    # getwd() 
    data <- read.csv("0 911 dataset As CSV-edit.csv",head=FALSE, sep = ",") ;
    DAll <- as.matrix(data,43,43,byrow=TRUE)  #7548
    DtWithName <- DAll
    DtWithName
    colnames(DtWithName) = c("Nawaf Alhazmi","Ahmed Alnami","Saeed Alghamdi","Ahmed Alghamdi","Hamza Alghamdi","Abdul Aziz Alomari","Mohamed Atta","Ramzi Bin al-Shibh","Salem Alhazmi","Hani Hanjour","Yazid Sufaat","Walid Ba Attas","Khalid Almihdar","Majed Moqed","Nabil al - Marabh","Ahmed Al Haznaw","Raed Hijazi","Mohand Alsheri","Ziad Jarrah","Waleed Alshehri","Marwan Al-shehhi","Wail Alshehri","Satam Suqami","Fayez Ahmed","Said Bahaji","Zakariya Essabar","Mounir El Motassadeq","Mohamed Haydar Zammar","Mahmoun Darkazanli","Essid Sami","Abdelghani Mzoudi","Ahmed Khalil","Imad Eddin","Agus Budi man","Mustafa Ahmed al-Hisawi","Khalid Shaikh Mohammed","Zacarias Moussaoui","Faisal Al Salmi","Rayed Mohammed Abdullah","Fahad al Quso","Ahmed Al-Haha","Bandar Alhazmi","Mohamed Abdi")
    G1<-graph.adjacency(DtWithName, mode=c("undirected")) ;       
    plot(G1, layout=layout.kamada.kawai , vertex.size = degree(G1))    
  }, height = 1200, width = 1300
  )
  output$InformationFlowPath <- renderPlot({
    inFile <- input$file1   
    if (is.null(inFile)){  return(NULL) }        
    data<-read.csv(inFile$datapath, header=input$header, sep=input$sep, quote=input$quote);       
    DAll <- as.matrix(data,nrow(data),nrow(data),byrow=TRUE)          
    G1<-graph.adjacency(DtWithName, mode=c("undirected")) ;             
    if (input$header) {          
      plot(G1, layout = layout.kamada.kawai, vertex.size = as.vector(betweenness(G1))/10, vertex.label = as.vector(header), main = 'Graph showing Information Flow Path')
    }else{      
      plot(G1, layout = layout.kamada.kawai, vertex.size = as.vector(betweenness(G1))/10, main = 'Graph showing Information Flow Path')    
    }     
  }, height = 1200, width = 1300)

  output$InformationBroadcasters <- renderPlot({
    inFile <- input$file1   
    if (is.null(inFile)){  return(NULL) }        
    data<-read.csv(inFile$datapath, header=input$header, sep=input$sep, quote=input$quote);       
    DAll <- as.matrix(data,nrow(data),nrow(data),byrow=TRUE)          
    G1<-graph.adjacency(DtWithName, mode=c("undirected")) ;             
    c<-as.vector(closeness(G1, V(G1), mode = "all",NULL, FALSE)) 
    if (input$header) {          
      plot(G1, layout = layout.kamada.kawai, vertex.size = c*1200, vertex.label = as.vector(header), main = 'Graph showing Information Sources')
    }else{      
      plot(G1, layout = layout.kamada.kawai, vertex.size = c*1200, main = 'Graph showing Information Sources')    
    }   
    
  }, height = 1200, width = 1300)

  output$OperationalUnits <- renderPlot({    
    inFile <- input$file1   
    if (is.null(inFile)){  return(NULL) }        
    data<-read.csv(inFile$datapath, header=input$header, sep=input$sep, quote=input$quote);       
    DAll <- as.matrix(data,nrow(data),nrow(data),byrow=TRUE)          
    G1<-graph.adjacency(DtWithName, mode=c("undirected")) ;             
    wc <- walktrap.community(G1)
    if (input$header) {          
      plot(wc,G1, layout = layout.kamada.kawai, vertex.size = 20*evcent(G1)$vector, vertex.label = as.vector(header), main = 'Graph showing Operational level group structure')
    }else{      
      plot(wc,G1, layout = layout.kamada.kawai, vertex.size = 20*evcent(G1)$vector, main = 'Graph showing Operational level group structure')    
    } 
    
    
    modularity(wc)
    membership(wc)
    
    # plot( wc, G1, layout = layout.fruchterman.reingold )
    # plot( wc, G1, layout = layout.kamada.kawai, vertex.size = 20*evcent(G1)$vector )
  }, height = 1200, width = 1300)
  
  
  # TrnsDataset1<-read.transactions("SEOM market basket.txt", format= c("single"), sep="\t", cols = c(1,2),rm.duplicates = TRUE  );    
  #TrnsDataset200<-read.csv("SEOM market basket - Price Greater than 100 - Name Year -2014 and 2015.csv", sep=",");  
  #TrnsDataset200 <- TrnsDataset200[!duplicated(TrnsDataset200),]
  #SeomData200 <- as(split(TrnsDataset200[,"Items"], TrnsDataset200[,"TID"]), "transactions")
  # inspect(SeomData200[1:5])
  #SeomRules200 <- apriori(SeomData200, parameter=list(support=0.0003, confidence=0.5))
  #Product <- "565-453"  
  # You can access the value of the widget with input$action, e.g.
  output$value <- renderPrint({ input$action })  
  
  dataInput <- reactive({
    inFile <- input$file1
    
    if (is.null(inFile))
      return(NULL)
    
    #read.csv(inFile$datapath, header=input$header, sep=input$sep,      quote=input$quote)
    
    TrnsDataset200 <- read.csv(inFile$datapath, header=input$header, sep=input$sep, quote=input$quote);      
    TrnsDataset200 <- TrnsDataset200[!duplicated(TrnsDataset200),]
    SeomData200 <- as(split(TrnsDataset200[,"Items"], TrnsDataset200[,"TID"]), "transactions")
    # inspect(SeomData200[1:5])
    SeomRules200 <- apriori(SeomData200, parameter=list(support=0.0003, confidence=0.5))    
     
  })
  
  output$text1 <- renderPrint({
    # Take a dependency on input$goButton
    input$SubmitSKU    
    SeomRules200 <- dataInput();
    if (!is.null(SeomRules200))
      rulesIncomeSmall <- subset(SeomRules200, subset = lhs %in% isolate(input$CrossSellSku) )      
      inspect(rulesIncomeSmall)  
    #as.list(inspect(head(sort(rules1, by ="lift"),3)))
    #paste(inspect(head(sort(rules1, by ="lift"),3)))
    # 'Hello'
    #  inspect(head(sort(rules1, by ="lift"),3))
    #  paste("You have selected", input$var)
  })
  
  output$RulePlot <- renderPlot({
    input$SubmitSKU    
    SeomRules200 <- dataInput();
    if (!is.null(SeomRules200))
      rulesIncomeSmall <- subset(SeomRules200, subset = lhs %in% isolate(input$CrossSellSku) & support > input$PurchasePercentage /100  )      
      plot(rulesIncomeSmall, method="graph")    
  })
  
  
  output$distPlot <- renderPlot({
    TrnsDataset1<-read.transactions("SEOM market basket.txt", format= c("single"), sep="\t", cols = c(1,2),rm.duplicates = TRUE  );
    #TopNItems <- seq(1, 20, length.out = input$TopNItems + 1)
    #bins <- seq(min(x), max(x), length.out = input$bins + 1)
    #x    
    itemFrequencyPlot(TrnsDataset1, topN = input$TopNItems )
    #x    <- faithful[, 2]  # Old Faithful Geyser data    
    # draw the histogram with the specified number of bins
    #hist(x, breaks = bins, col = 'darkgray', border = 'white')
  })
  

  
  renderPlot({
  setwd("C:/Users/Lenovo B4400/Google Drive/0 Projects/Market Basket Analysis/")
  TrnsDataset1<-read.transactions("SEOM market basket.txt", format= c("single"), sep="\t", cols = c(1,2),rm.duplicates = TRUE  );
  
  rules1 <- apriori(TrnsDataset1, parameter=list(support=0.001, confidence=0.5))
  inspect(head(sort(rules1, by ="lift"),3))
  })
  

  
})
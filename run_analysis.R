run_analysis <- function()
{
       ###  READ IN ALL THE DATA FILES  #####
  
       x_test <- read.table("X_test.txt")
       y_test <- read.table("y_test.txt")
       s_test <- read.table("subject_test.txt")
       x_train <- read.table("X_train.txt")
       y_train <- read.table("y_train.txt")
       s_train <- read.table("subject_train.txt")
       activ <- read.table("activity_labels.txt")
       x_labels <- read.table("features.txt")
       activ_name <- data.frame()
       xtr_label <- c()
     
       
       y_set <- rbind(y_test,y_train)    # MERGE THE ACTIVITIES TOGETHER
       s_set <- rbind(s_test,s_train)    # MERGE THE SUBJECTS TOGETHER
       
       x_set <- rbind(x_test,x_train)    # CREATE THE DATASET FOR ANALYSIS
       
       
      
      ######################  EXTRACT THE MEAN AND STD FOR EACH MEASUREMENT ###################
      
      xtr_set <- data.frame(1:nrow(x_set))
       
      for (i in 1:nrow(x_labels))
      {      if (identical(grepl("mean",x_labels[i,2]),as.logical("TRUE")))
               { xtr_set <- cbind(xtr_set,data.frame(x_set[,i])) 
                 xtr_label <- c(xtr_label,as.character(x_labels[i,2]))    }
             if (identical(grepl("std",x_labels[i,2]),as.logical("TRUE")))
                 {   xtr_set<- cbind(xtr_set,data.frame(x_set[,i])) 
                     xtr_label <- c(xtr_label,as.character(x_labels[i,2]))    }      }
       
      xtr_set[,1] <- NULL
     
      ################################# BUILD THE REST OF THE DATASET  #############################
      
      
      activ_set <- cbind(y_set,xtr_set)
      
      colnames(activ_set) <- c("Activity")
      activ_set
      
      ################################# ADD ON THE ACTIVITIES LABEL ##########################
      
      for(i in 1:nrow(activ_set))
             for(n in 1:nrow(activ))
                    if(identical(activ[n,1],activ_set[i,1]))
                           activ_name <- rbind(activ_name,data.frame(activ[n,2]),deparse.level = 0)  
      
      activ_T <- cbind(activ_name,activ_set) 
      
      x <- cbind(s_set,activ_T)
      x[,3] <- NULL
     
     ################################# CALCULATE THE MEAN OF ALL VARIABLES  ################## 
     
     ################  DO THIS ONCE OUTSIDE THE LOOP TO GET THE TABLE STARTED
     library(reshape2)
     calc_mean <- tapply(x[,3],list(x[,1],x[,2]),mean)
     col_mean <- melt(calc_mean)
     mean_x <- col_mean
    
     
     ################  LOOP TO CALCULATE THE MEAN OF EACH VARIABLE AND STORE
     ################   THOSE VARIABLES INTO A TIDY DATA SET
     for (n in 4:ncol(x))       
     {   calc_mean <- tapply(x[,n],list(x[,1],x[,2]),mean)
         col_mean <- melt(calc_mean)
         mean_x <- cbind(mean_x,data.frame(col_mean[,3]))  }
     
     
     ###############  SORT THE DATA AND WRITE IT TO A TEXT FILE #################
    
     sorted_mean <- mean_x[order(mean_x[,1]),]
     colnames(sorted_mean) <- c("Subject","Activity",xtr_label)
    
    write.table(sorted_mean,file="tidy_data.txt",row.names=FALSE,sep=" ")
    
    sorted_mean

  
}       
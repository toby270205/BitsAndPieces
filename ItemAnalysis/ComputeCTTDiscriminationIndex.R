#Compute CTT discrimination index.
#Assume "resp" contains the item responses, and "score" contains each student's test score.
#Note that students' test scores do not contain the item score for which the disc index is computed.
score <- apply(resp,1,sum)
disc <- apply(resp,2,
        function(x){cor(x,score-x,use="complete.obs")})

#Alternatively, use the "reliability" function in the CTT package. pBis is returned.
## ---- results='hide'-----------------------------------------------------

M <- c(rep(1,10),
        c(rep(1,4),rep(0,6)),
        c(rep(1,3),rep(0,7)),
        c(rep(1,2),rep(0,8)),
        rep(c(rep(1,1),rep(0,9)),6)
         )
M <- matrix(M,nrow=10)
rownames(M) <- paste('P',1:10,sep='')
colnames(M) <- paste('A',1:10,sep='')


## ------------------------------------------------------------------------

M


## ------------------------------------------------------------------------

M[sample(1:10,10),sample(1:10,10)]


## ------------------------------------------------------------------------

M[sample(1:10,10),sample(1:10,10)]


## ------------------------------------------------------------------------

M[sample(1:10,10),sample(1:10,10)]


## ------------------------------------------------------------------------
obs <- 45
null <- rnorm(1000,65,9)
hist(null,main='')
abline(v=obs)


## ------------------------------------------------------------------------
z.score <- (obs - mean(null)) / sd(null)
p.value <- length(null[null <= obs])/length(null)

z.score
p.value


## ---- results='hide'-----------------------------------------------------

library(bipartite)
data(Safariland)
Safariland


## ---- echo=FALSE---------------------------------------------------------

Safariland


## ------------------------------------------------------------------------

plotweb(Safariland)


## ------------------------------------------------------------------------

plotweb(Safariland,text.rot=90)


## ------------------------------------------------------------------------

nested(Safariland)


## ------------------------------------------------------------------------

nested(Safariland,method='ALL')


## ------------------------------------------------------------------------

safari.nest <- nestedness(Safariland)
names(safari.nest)


## ------------------------------------------------------------------------

unlist(safari.nest[c('temperature')])
unlist(safari.nest[c('p.null1','p.null2','p.null3')])
unlist(safari.nest[c('mean.temp.null1','mean.temp.null2','mean.temp.null3')])
unlist(safari.nest[c('var.temp.null1','var.temp.null2','var.temp.null3')])


## ---- echo=FALSE,results='hide'------------------------------------------

if (!(('safari.mods') %in% ls())){safari.mods <- computeModules(Safariland)}


## ---- eval=FALSE,results='hide'------------------------------------------
## 
## safari.mods <- computeModules(Safariland)
## 

## ------------------------------------------------------------------------
plotModuleWeb(safari.mods)


## ---- echo=FALSE, results='hide'-----------------------------------------
null.nets <- lapply(1:5,commsimulator,x=Safariland,method='r1')
if (!('null.mods' %in% ls())){null.mods <- lapply(null.nets,computeModules)}
null.stats <- lapply(null.mods,function(x) slot(x,'likelihood'))
null.stats <- unlist(null.stats)


## ---- eval=FALSE---------------------------------------------------------
## null.nets <- lapply(1:5,commsimulator,x=Safariland,method='r1')
## null.mods <- lapply(null.nets,computeModules)
## null.stats <- lapply(null.mods,function(x) slot(x,'likelihood'))
## null.stats <- unlist(null.stats)
## 

## ------------------------------------------------------------------------
obs.mods <- slot(safari.mods,'likelihood')
null.mu <- mean(null.stats)
null.sd <- sd(null.stats)
null.z <- (obs.mods - null.mu) / null.sd
null.p <- length(null.stats[null.stats <= obs.mods])/length(null.stats)
null.z
null.p



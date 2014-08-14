library(RDCOMClient)
e <- COMCreate("Excel.Application")

e[["Visible"]] <- TRUE
e[["StandardFontSize"]]

e[["StartupPath"]]
e[["Path"]] #
e[["PathSeparator"]] # Check characters.    

e[["StatusBar"]] # VARIANT returned.

e[["SheetsInNewWorkbook"]]


# Functions
e$CentimetersToPoints(1.)
e$CheckSpelling("Duncan")
e$CheckSpelling("Duncna")

e$Calculate()
e$CalculateFull()	

####
require("RDCOMClient") || stop("You need to install the RDCOMClient package")

.COMInit()
e <- COMCreate("Excel.Application")

books <- e[["workbooks"]] 

fn <- system.file("examples", "duncan.xls", package = "RDCOMClient")
fn <- gsub("/", "\\\\", fn)
print(fn)
b = books$open(fn)

sheets = b[["sheets"]]

mySheet = sheets$Item(as.integer(1))

e[["Visible"]] <- TRUE

r = mySheet[["Cells"]]

v <- r$Item(as.integer(1), as.integer(1))
v[["Value"]]

v <- r$Item(as.integer(1), as.integer(3))
v[["Value"]]


################

 xls <- COMCreate("Excel.Application")
  books <- xls[["Workbooks"]]
  books$Open(gsub("/",  "\\", system.file("examples", "duncan.xls", package = "RDCOMClient"))
  wks = books$item(1)[["worksheets"]]$item(1)
   
   r1 <- wks$Range("A1:C4")       # okay
   r1$Value()
  
   ## create Cell COMIDispatch object:
   c1 <- wks$Cells(1,1)           # okay
   c1$Value()
   
   c2 <- wks$Cells(3,4)           # okay
   c2$Value()
   
   r2 <- wks$Range("A1", "C4")    # okay

   r3 <- wks$Range(c1, c2)

print(15, row.names = FALSE)

# 
# Sys.time()
# 
# formatC(0.987654321, digits=3)


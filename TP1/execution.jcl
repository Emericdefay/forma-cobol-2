//RUNJCL  JOB 'IBMUSER',
//            'MAC',
//            CLASS=A,
//            MSGCLASS=X,
//            NOTIFY=&SYSUID
//*=========================================
//*           PROGRAM NAME
//        SET PGMCBL=PGM015
//*           FILES PATH
//        SET FILESP=MASTER.FILES
//        SET LOADLIB=MASTER.PROG.LOAD
//*           FILES INPUTS
//        SET FILEI1=FILE015
//        SET FILEO1=FILE015A
//        SET FILEO2=FILE015B
//*=========================================
//STEP1  EXEC PGM=&PGMCBL
//STEPLIB  DD DISP=SHR,DSN=&LOADLIB
//SYSPRINT DD SYSOUT=*
//FILEIN   DD DSN=&FILESP(&FILEI1),DISP=SHR
//FILEOUT1 DD DSN=&FILESP(&FILEO1),DISP=SHR
//FILEOUT2 DD DSN=&FILESP(&FILEO2),DISP=SHR
//SYSIN    DD DUMMY
//
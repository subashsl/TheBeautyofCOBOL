      ******************************************************************
      * Author:SUBASH S L
      * Date: 20.9.2023
      * Purpose: Program that copies the records of one file to another.
      * Contents of the second file remained the same even after repeated runs
      * of the program, i.e no appending of data in the copied-to file. Also
      * even if no TOFILE.TXT (copied-to file) exists, a new one is created
      *
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. COPYPROG.

       ENVIRONMENT DIVISION.

       CONFIGURATION SECTION.
       SOURCE-COMPUTER. IBM-PC.
       OBJECT-COMPUTER. IBM-PC.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT IFILE ASSIGN DISK
           ORGANIZATION IS LINE SEQUENTIAL.
           SELECT OFILE ASSIGN DISK
           ORGANIZATION IS LINE SEQUENTIAL.

      * if command is ...ASSIGN PRINTER, to send the output to a PRINTER
      * then there is no need of mentioning ORGANIZATION

       DATA DIVISION.

       FILE SECTION.
       FD IFILE
           LABEL RECORDS STANDARD
      *    LABEL RECORDS is obsolete in the current GNU Compiler
           VALUE OF FILE-ID IS "D:\PROGRAMMING\COBOL\FROMFILE.TXT".
       01 INREC PICTURE X(25).

      * VALUE OF is obsolete too.
      * FROMFILE.TXT'S last record or line must have a carriage return going to the next
      * line, i.e after the last character of the last line there must be a carriage return.


       FD OFILE
          LABEL RECORDS STANDARD
          VALUE OF FILE-ID IS "D:\PROGRAMMING\COBOL\TOFILE.TXT".
       01 OUTREC PICTURE X(25).

      *   LABEL RECORDS OMITTED for printer file.

       WORKING-STORAGE SECTION.
       01 E-O-F PICTURE X VALUE 'N'.

       PROCEDURE DIVISION.
       MAIN-PROGRAM.
           OPEN INPUT IFILE OUTPUT OFILE.
           READ IFILE AT END MOVE 'Y' TO E-O-F.
      *reads the first record and positions on the subsequent record if it exists
           PERFORM FILECOPY UNTIL E-O-F = 'Y'.
           DISPLAY "File copied."
           CLOSE IFILE OFILE.
           STOP RUN.

       FILECOPY.
           MOVE INREC TO OUTREC.
           WRITE OUTREC.
           READ IFILE AT END MOVE 'Y' TO E-O-F.

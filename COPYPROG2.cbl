      ******************************************************************
      * Author:SUBASH S L
      * Date: 10.7.1994
      * Purpose: Program that copies the records of one file to another,
      * with fields separated from one another
      *
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. COPYPROG2.

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

       DATA DIVISION.

       FILE SECTION.
       FD IFILE
          LABEL RECORDS STANDARD
          VALUE OF FILE-ID IS "D:\PROGRAMMING\COBOL\FILE1.TXT".
       01 INREC.
          05 CUSTOMER-NO PIC X(5).
          05 CHALLAN-NO PIC X(4).
          05 CHALLAN-DATE PIC 9(6).
          05 ITEM-NO PIC X(5).
          05 ITEM-DESCRIPTION PIC X(25).
          05 QUANTITY PIC 9(5).
          05 ITEM-RATE PIC 9(3)V99.
          05 UNUSED PIC X(25).

       FD OFILE
          LABEL RECORDS STANDARD
          VALUE OF FILE-ID IS "D:\PROGRAMMING\COBOL\FILE2.TXT".
       01 OUTREC.
          05 O-CUSTOMER-NO PIC X(5).
          05 FILLER PIC X(3) VALUE SPACES.
      * spaces of three characters inserted between fields
          05 O-CHALLAN-NO PIC X(4).
          05 FILLER PIC X(3) VALUE SPACES.
          05 O-CHALLAN-DATE PIC 99/99/99.
          05 FILLER PIC X(3) VALUE SPACES.
          05 O-ITEM-NO PIC X(5).
          05 FILLER PIC X(3) VALUE SPACES.
          05 O-ITEM-DESCRIPTION PIC X(25).
          05 FILLER PIC X(3) VALUE SPACES.
          05 O-QUANTITY PIC ZZ,999.
          05 FILLER PIC X(3) VALUE SPACES.
          05 O-ITEM-RATE PIC $$$9.99.
      * $ symbol followed by the places for the 5 digits taken in, 3 for the NUMBERS
      * two for the decimals
          05 FILLER PIC X(3) VALUE SPACES.
          05 O-UNUSED PIC X(25).

       WORKING-STORAGE SECTION.
       01 E-O-F PICTURE X VALUE 'N'.

       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
           OPEN INPUT IFILE OUTPUT OFILE.
           READ IFILE AT END MOVE 'Y' TO E-O-F.
           PERFORM FILECOPY UNTIL E-O-F = 'Y'.
           DISPLAY "File copied."
           CLOSE IFILE OFILE.
           STOP RUN.

       FILECOPY.
           MOVE SPACES TO OUTREC.
           MOVE CUSTOMER-NO TO O-CUSTOMER-NO.
           MOVE CHALLAN-NO TO O-CHALLAN-NO.
           MOVE CHALLAN-DATE TO O-CHALLAN-DATE.
           MOVE ITEM-NO TO O-ITEM-NO.
           MOVE ITEM-DESCRIPTION TO O-ITEM-DESCRIPTION.
           MOVE QUANTITY TO O-QUANTITY.
           MOVE ITEM-RATE TO O-ITEM-RATE.
           MOVE UNUSED TO O-UNUSED.
           WRITE OUTREC.
           READ IFILE AT END MOVE 'Y' TO E-O-F.

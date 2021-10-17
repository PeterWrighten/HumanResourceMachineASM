
-- HUMAN RESOURCE MACHINE GUIDEBOOK @Copyright PeterWright --

/*****************************************************************************************

  I'd like to define tile 0 as "/2", tile 1 as "/3", tile 2 as "/5", tile 4 as "/0",
  tile 5 as "C2"(which means counter of "/2"), tile 6 as "C3", tile 7 as "C5",
  tile 8 as "C7", tile 9 as "COUNT_D"(which means counter of Data),
  tile 24 as "COUNT_T".

  I'll code the name of tile based on the rule above.

  e.g. when I code 'COPYFROM /3', that means COPYFROM tile 1.

******************************************************************************************/


    COPYFROM COUNT_T
    COPYTO  /0
    BUMPUP COUNT_T
    BUMPUP COUNT_T
    COPYTO /2
    BUMPUP COUNT_T
    COPYTO /3
    BUMPUP COUNT_T
    BUMPUP COUNT_T
    COPYTO /5
    BUMPUP COUNT_T
    BUMPUP COUNT_T
    COPYTO /7

A:

    COPYFROM /0
    COPYTO C2
    COPYTO C3
    COPYTO C5
    COPYTO C7
    COPYTO COUNT_D
    COPYFROM /5
    COPYTO COUNT_T
    INBOX
    COPYTO 10

B:

    COPYFROM 10

    JUMPIFZERO C
    JUMPIFNEGATIVE E

    SUB [COUNT_D]
    COPYTO 10
    BUMPUP [COUNT_T]

    JUMP A

C:

    COPYFROM [COUNT_D]
    OUTBOX
    COPYFROM [COUNT_T]
    BUMPDOWN [COUNT_T]

    JUMPIFZERO C

    BUMPUP [COUNT_T]
    COPYTO 10
    COPYFROM /0
    COPYTO [COUNT_T]

D:

    COPYFROM [COUNT_D]

    JUMPIFZERO C

    JUMPIFNEGATIVE E

    SUB [COUNT_D]
    COPYTO 10
    BUMPUP [COUNT_T]

    JUMP D

E:

    COPYFROM 10
    ADD [COUNT_D]
    COPYTO 10
    BUMPDOWN [COUNT_T]

    JUMPIFZERO F

    JUMP E

F:

    BUMPUP COUNT_D
    COPYFROM [COUNT_D]

    JUMPIFZERO G

    BUMPUP COUNT_T

    JUMP B

G:

    COPYFROM 10
    OUTBOX

    JUMP A

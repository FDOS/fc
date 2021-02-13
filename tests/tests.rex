/* These are unit tests for FreeDOS FC in Rexx (Regina). */
/* These execute FC and check the exit code result are what is expected. */

/* Usage: */
/*    C:\..> rexx text.rex [path_to\fc.exe] */

/* The exit code (errorlevel) from this Rexx script is the number of failed tests, unless there is an error with the testing (exit code 250+). */

/*    C:\..\fc\tests> rexx texts.rex ..\fc */

/* It is suggested to put rexx.exe in your PATH. */

/* Note: Here are some terms that mean exactly the same thing and the context where it means that is in parenthesis:  Exit status/exit code/return code, ERRORLEVEL (DOS), and RC (for return code - Rexx). */

/* This is intended to be ran in a DOS environment */

/* TODO: GENERATE TEST FILES IN REXX???? */

tests_failed = 0
tests_passed = 0

/* exe file path for FC */
FC = ARG(1)

if FC = '' then
    do
    say "The argument was empty. Do you want to use the default: '..\src\fc'?"
    pull yn
    if yn = 'Y' then
        do
            FC = '..\src\fc'
        end
    else
        do
            say 'Exiting, no fc.exe program'
            exit 255
        end
    end


/* Test 1: No parameters */
/* 'FC' */
/* returns RC == 2 (EL_PARAM_ERROR) */
call assertErrorlevelCmd 2 FC

/* Test 2: Help  */
/* 'FC /?' */
/* returns RC == 2 (EL_PARAM_ERROR) */
call assertErrorlevelCmd 2 FC '/?'

/* Test 3: Tests comparison of two text files with tabs and spaces */
/* FC SPACES.TXT TAB.TXT */
call assertSuccessCmd FC 'SPACES.TXT TAB.TXT'

/* Test 4: Tests comparison of two text files with tabs and spaces */
/* FC /W SPACES.TXT TAB.TXT */
call assertSuccessCmd FC '/W SPACES.TXT TAB.TXT'

/* Test 5: Tests comparison of two text files with tabs and spaces w/o expanding tabs to spaces */
/* FC /T SPACES.TXT TAB.TXT */
call assertFailureCmd FC '/T SPACES.TXT TAB.TXT'

/* Test 6: Tests comparison binary of two different text files */
/* FC /B SPACES.TXT TAB.TXT */
call assertFailureCmd FC '/B SPACES.TXT TAB.TXT'

/* Test 7: Test ignore case of characters */
/* FC /C UPPER.TXT LOWER.TXT */
call assertSuccessCmd FC '/C UPPER.TXT LOWER.TXT'

/* Test 8: Compare different cases of characters */
/* FC UPPER.TXT LOWER.TXT */
call assertFailureCmd FC 'UPPER.TXT LOWER.TXT'

/* Test 9: File name that doesn' exist */
/* FC UPPER.TXT NOTAFILE.TXT */
/* returns RC == 3 (EL_NO_FILE_ERROR) */
call assertErrorlevelCmd 3 FC 'UPPER.TXT NOTAFILE.TXT'

/* Test 10: Intentionally bad parameter  */
/* FC /Z */
/* returns RC == 2 (EL_PARAM_ERROR) */
call assertErrorlevelCmd 2 FC '/Z'

/* Test 11: Wildcard Test astrisk */
/* FC SAME.TXT SAME*.TXT */
call assertSuccessCmd FC 'SAME.TXT SAME*.TXT'

/* Test 12: Wildcard Test question mark */
/* FC SAME.TXT SAME?.TXT */
call assertSuccessCmd FC 'SAME.TXT SAME?.TXT'


say
say '==========[' 'Tests Passed:' tests_passed   'Failed:' tests_failed ']=========='
exit tests_failed

/* =========================   Below this line are helper functions  ================================ */
assertSuccessEqual:
PARSE ARG parm1, parm2
if parm1 == parm2 then
  do  
    tests_passed = tests_passed + 1 
  end
else
  do
    tests_failed = tests_failed + 1
    call charout ,'...FAILED'
  end
return

assertSuccessCmd: 
PARSE ARG cmd
say
call charout ,'test: "'cmd'"'
cmd
if RC \= 0 then
  do  
    tests_failed = tests_failed + 1
    call charout ,'...FAILED'
  end
else
  do
    tests_passed = tests_passed + 1 
  end
say
return 0

assertFailureCmd: 
PARSE ARG cmd
say
call charout ,'test: "'cmd'"'
cmd
if RC = 0 then
  do  
    tests_failed = tests_failed + 1
    call charout ,'...FAILED'
    return 1
  end
else
  do
    tests_passed = tests_passed + 1 
  end
say
return 0

assertErrorlevelCmd:
PARSE ARG RetVal cmd
say
call charout ,'test: "'cmd'" (and RC must equal 'RetVal')'
cmd
if RC \= RetVal then
  do  
    tests_failed = tests_failed + 1
    call charout ,'...FAILED'
  end
else
  do
    tests_passed = tests_passed + 1 
  end
say
return 0


/* Gerate a random filename */
random_filename:
return random()'.TMP'

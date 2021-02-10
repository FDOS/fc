/* This creates files for the test.rex. 
   This is intended to be crossplatform.
   Programmed on Regina Rexx.
 */

TAB = X2C('9')
SPACES = '        '

say "Creating files for the test.rex..."

spc1 = "This is a white space example which TAB uses tabs"
spc2 = "and SPC uses spaces."
out = LineOut(SPACES.TXT, SPACES spc1, 1)
out = LineOut(SPACES.TXT, SPACES spc2, 2)
say "SPACES.TXT"

out = LineOut(TAB.TXT, TAB spc1, 1)
out = LineOut(TAB.TXT, TAB spc2, 2)
say "TABS.TXT"

line1 = "The files same1.txt and same2.txt are exactly the same."
line2 = "This is used to test FC's wildcards * (astrisk) and ? (question mark)."
out = LineOut(SAME.TXT, line1, 1)
out = LineOut(SAME.TXT, line2, 2)
say "SAME.TXT"

out = LineOut(SAME2.TXT, line1, 1)
out = LineOut(SAME2.TXT, line2, 2)
say "SAME2.TXT"

out = LineOut(SAME3.TXT, line1, 1)
out = LineOut(SAME3.TXT, line2, 2)
say "SAME3.TXT"

brown_fox = "the quick brown fox jumps over the lazy dog"
out = LineOut(LOWER.TXT, brown_fox, 1)
say "LOWER.TXT"

/* Make uppercase version */
brown_fox_up = Translate(brown_fox)
out = LineOut(UPPER.TXT, brown_fox_up, 1)
say "UPPER.TXT"

Exit 0

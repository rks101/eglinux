+ eglinux
  + docs
    + README.md - this file. 
    + LSAV_2024-25_S2.pdf (09..09..8.33) 
    + LSAV_2025-26_S1.pdf (14..11..7.57) 
    + LSAV_2025-26_S2.pdf (30..19..7.46) 
    + The above pdf files contain some questions with sample answers. Yes, these pdf files may contain text with errors, and feel free to point them out. Now, you may appreciate the **repetition**, in the same semester and across, appears an essential part of the **learning and evaluation** process. Did students go back to **discuss and review** them? in the same semester and across? By the way, **Cat is still waiting for curiosity :)**
  + errata
    + It is possible, there are some answers with errors. They may have been corrected upon cribs and not updated here in the scanned file. 
    + Maximum permissions associated with a file and directory using r,w,x notation are rwx (7) 
    + To locate multiple binaries of the same command, use `which -a command` or `locate command`
    + While matching a regex pattern, focus is on the format rather the exact values. e.g. match every possible IPv4 address in format w.x.y.z where each of the octet contains one, two or three digit. Here, logic for each number not exceeding value 255, is non-trivial.
    + Match every 9-character string (with letters, numbers, and symbols) that doesn't end in a "!" sign, should be 9-character long, that means it should not contain trailing non-printable while spaces (a space, tab, or enter key). e.g. \S{8}[^!\s] 

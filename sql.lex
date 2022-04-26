/* Header files */
%{
  #include <stdio.h>
%}

/* Regular expressions for DDL(Data Definition Language) */

createRegExp ([Cc][Rr][Ee][Aa][Tt][Ee])
alterRegExp  ([Aa][Ll][Tt][Ee][Rr])
dropRegExp   ([Dd][Rr][Oo][Pp])

/* Regular expressions for DML(Data Manipulation Language) */

selectRegExp ([Ss][Ee][Ll][Ee][Cc][Tt])
deleteRegExp ([Dd][Ee][Ll][Ee][Tt][Ee])
insertRegExp ([Ii][Nn][Ss][Ee][Rr][Tt])
updateRegExp ([Uu][Pp][Dd][Aa][Tt][Ee])
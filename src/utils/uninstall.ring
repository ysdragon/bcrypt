load "stdlibcore.ring"

cPathSep = "/"

if isWindows()
	cPathSep = "\\"
ok

# Remove the bcrypt.ring file from the load directory
remove(exefolder() + "load" + cPathSep + "bcrypt.ring")

# Remove the bcrypt.ring file from the Ring2EXE libs directory
remove(exefolder() + ".." + cPathSep + "tools" + cPathSep + "ring2exe" + cPathSep + "libs" + cPathSep + "bcrypt.ring")

# Change current directory to the samples directory
chdir(exefolder() + ".." + cPathSep + "samples")

# Remove the UsingBcrypt directory if it exists
if direxists("UsingBcrypt")
	OSDeleteFolder("UsingBcrypt")
ok
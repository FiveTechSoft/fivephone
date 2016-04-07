#import <UIKit/UIKit.h>
#include <dirent.h>
#include <fnmatch.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>

DIR * opendir$INODE64$UNIX2003( char * dirName )
{
    NSLog( @"opendir" );
	return opendir( dirName );
}

struct dirent * readdir$INODE64( DIR * dir )
{
    NSLog( @"readdir" );
    return readdir( dir );
}

BOOL closedir$UNIX2003( DIR * dir )
{
    NSLog( @"closedir" );
    return closedir( dir );
}   

int fnmatch$UNIX2003( const char * pattern, const char * string, int flags )
{
	NSLog( @"fnmatch" );
    return fnmatch( pattern, string, flags );
}

int write$UNIX2003( const void * buffer, size_t size, size_t count, FILE * stream )
{
    NSLog( @"write" );
	// return fwrite( buffer, size, count, stream );
    return count;
}   

FILE * fopen$UNIX2003( const char * fname, const char * mode )
{
    NSLog( @"fopen" );
	return fopen( fname, mode );
}

FILE * open$UNIX2003( const char * fname, int mode )
{
    NSLog( @"open" );
	return ( FILE * ) open( fname, mode );
}

int read$UNIX2003( FILE * fd, char * buffer, unsigned int n )
{
	NSLog( @"read" );
	return read( ( int ) fd, buffer, n );
}	

int close$UNIX2003( FILE * fd )
{
	NSLog( @"close" );
	return close( ( int ) fd );
}	

int stat$INODE64( const char * pcc, struct stat * pss ) 
{
	NSLog( @"stat" );
	return stat( pcc, pss );
}	

int fcntl$UNIX2003( int fildes, int cmd, int one )
{
	NSLog( @"fcntl" );
    return fcntl( fildes, cmd, one );
}

int fstat$INODE64( int filedes, struct stat * buf )
{
	NSLog( @"fstat" );
	return fstat( filedes, buf );
}	

ssize_t pread$UNIX2003( int fildes, void *buf, size_t nbyte, off_t offset )
{
	NSLog( @"pread" );
	return pread( fildes, buf, nbyte, offset );
}	

ssize_t pwrite$UNIX2003( int filedes, const void *buffer, size_t size, off_t offset )
{
	NSLog( @"pwrite" );
    return pwrite( filedes, buffer, size, offset );
}

void select$UNIX2003( void )
{
    NSLog( @"select" );
}
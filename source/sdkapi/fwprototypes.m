/*
 * $Id
 */

/*
 * FivePhone source code:
 * fwrototypes.m
 *
 * Copyright 2010 Daniel Garcia-Gil <danielgarciagil@gmail.com>
 * www - http://www.fivetechsoft.com
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2, or (at your option)
 * any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this software; see the file COPYING.  If not, write to
 * the Free Software Foundation, Inc., 59 Temple Place, Suite 330,
 * Boston, MA 02111-1307 USA (or visit the web site http://www.gnu.org/).
 *
 * As a special exception, this project gives permission for
 * additional uses of the text contained in the release of Harbour.
 *
 * The exception is that, if you link these libraries with other
 * files to produce an executable, this does not by itself cause the
 * resulting executable to be covered by the GNU General Public License.
 * Your use of that executable is in no way restricted on account of
 * linking this library code into it.
 *
 * This exception does not however invalidate any other reasons why
 * the executable file might be covered by the GNU General Public License.
 *
 * This exception applies only to the code released by this
 * Project under the name FivePhone.  If you copy code from other
 * projects or Free Software Foundation releases into this project,
 * as the General Public License permits, the exception does
 * not apply to the code that you add in this way.  To avoid misleading
 * anyone as to the status of such modified files, you must delete
 * this exception notice from them.
 *
 * If you write modifications of your own for FivePhone, it is your choice
 * whether to permit this exception to apply to your modifications.
 * If you do not wish that, delete this exception notice.
 *
 */

#include <fwprototypes.h>

NSString * NumToStr( NSInteger myInt ) 
{
   NSString *intString = [ NSString stringWithFormat : @"%d", myInt ];
	
   return intString;
}


NSString * hb_NSSTRING_par( int iParam )
{
	return [ [ [ NSString alloc ] initWithCString: ISCHAR( iParam ) ? hb_parc( iParam ) : "" ] autorelease ];   
}


HB_GARBAGE_FUNC( OBJECT_release )
{
   void ** ph = ( void ** ) Cargo;
	SEL selReleaseSender = @selector( releaseSender: );
	SEL selReleaseObject = @selector( releaseObject: );
   
   //Check if pointer is not NULL to avoid multiple freeing 
   if( ph && * ph )
   {
      // Destroy the object 
	   [ ( id ) * ph performSelector : selReleaseSender ];
	   [ ( id ) * ph release ]; 
	   [ ( id ) * ph performSelector : selReleaseObject withObject : ( id ) * ph ];
      
      // set pointer to NULL to avoid multiple freeing 
      * ph = NULL;

   }
}

const HB_GC_FUNCS s_gcOBJECTFuncs =
{
   OBJECT_release,
   hb_gcDummyMark
};

id hb_OBJECT_par( int iParam )
{
   void ** ph = ( void ** ) hb_parptrGC( &s_gcOBJECTFuncs, iParam );
   return ph ? ( id ) * ph : NULL;
}

void hb_OBJECT_ret( id p )
{
   if( p )
   {
      void ** ph = ( void ** ) hb_gcAllocate( sizeof( void *  ), &s_gcOBJECTFuncs );
      
      * ph = p;
      
      hb_retptrGC( ph );
   }
   else
      hb_retptr( NULL );
}

void __bzero( void * destination, size_t length )
{
	memset( destination, 0, length );
}	

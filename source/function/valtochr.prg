/*
 * $Id
 */

/*
 * FivePhone source code:
 * function cValToChar()
 *
 * Copyright 2010 Antonio Linares <alinares@fivetechsoft.com>
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

function cValToChar( uVal )
 
   local cType := ValType( uVal )
 
   do case
      case cType == "C" .or. cType == "M"
           return uVal
 
      case cType == "D"
           #ifdef __XHARBOUR__
              if HasTimePart( uVal )
                 return If( Year( uVal ) == 0, TToC( uVal, 2 ), TToC( uVal ) )
              endif
           #endif
           return DToC( uVal )
 
      #ifdef __HARBOUR__
         #ifndef __XHARBOUR__
            case cType == "T"
               return If( Year( uVal ) == 0, HB_TToC( uVal, '', Set( _SET_TIMEFORMAT ) ), HB_TToC( uVal ) )
         #endif
      #endif
 
      case cType == "L"
           return If( uVal, ".T.", ".F." )
 
      case cType == "N"
           return AllTrim( Str( uVal ) )
 
      case cType == "B"
           return "{|| ... }"
 
      case cType == "A"
           return "{ ... }"
 
      case cType == "O"
           return If( __ObjHasData( uVal, "cClassName" ), uVal:cClassName, uVal:ClassName() )
 
      case cType == "H"
           return "{=>}"
 
      case cType == "P"
           #ifdef __XHARBOUR__
              return "0x" + NumToHex( uVal )
           #else
              return "0x" + hb_NumToHex( uVal )
           #endif
 
      otherwise
 
           return ""
   endcase
 
return nil

#pragma BEGINDUMP

#include <hbvm.h>

void ValToChar( PHB_ITEM item )
{
   switch( hb_itemType( item ) )
   {
      case HB_IT_NIL:
           hb_retc( "nil" );
           break;

      case HB_IT_STRING:
           hb_retc( ( char * ) hb_itemGetC( item ) );
           break;

      case HB_IT_INTEGER:
      	   {
      	      char lng[ 15 ];
              sprintf( lng, "%d", hb_itemGetNI( item ) );
              hb_retc( lng );
           }   
           break;

      case HB_IT_LONG:
      	   {
              char dbl[ HB_MAX_DOUBLE_LENGTH ];
              sprintf( dbl, "%f", ( double ) hb_itemGetND( item ) );
              * strchr( dbl, '.' ) = 0;
              hb_retc( dbl );
           }   
           break;

      case HB_IT_DOUBLE:
           {
              char dbl[ HB_MAX_DOUBLE_LENGTH ];
              sprintf( dbl, "%f", ( double ) hb_itemGetND( item ) );
              hb_retc( dbl );
           }
           break;

      case HB_IT_DATE:
           {
              hb_vmPushSymbol( hb_dynsymSymbol( hb_dynsymFindName( "DTOC" ) ) );	
              hb_vmPushNil();
              hb_vmPush( item );
              hb_vmDo( 1 );  
           }
           break;

      case HB_IT_LOGICAL:
           hb_retc( hb_itemGetL( item ) ? ".T." : ".F." );
           break;

      case HB_IT_ARRAY:
           if( hb_objGetClass( item ) == 0 )
              hb_retc( "Array" );
           else
              hb_retc( "Object" );
           break;

      default:
           hb_retc( "ValtoChar not suported type yet" );
  }
}

#pragma ENDDUMP
 
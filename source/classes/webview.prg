#include "fivephone.ch"

//----------------------------------------------------------------------------//

CLASS TWebview FROM TView
 
   METHOD New( oWnd,nTop, nLeft, nWidth, nHeight, cUrlName )
   
   METHOD Resources( oWnd, idResource ) 

   METHOD GoBack() INLINE WebViewGoBack( ::hWnd )
   
   METHOD GoForward() INLINE WebViewGoForward( ::hWnd )
   
   METHOD SetURL( cUrlName ) INLINE WebViewloadRequest( ::hWnd, cUrlName )
   
   METHOD SetFile( cfile ) INLINE WebViewLoadBundleFile( ::hWnd, cfile )

   // METHOD Stopload()   INLINE WebViewstopLoading( ::hWnd  )
   
   METHOD Reload()     INLINE WebViewReload( ::hWnd  )
   
      
ENDCLASS   

//----------------------------------------------------------------------------//

METHOD New( ownd,nTop, nLeft, nWidth, nHeight, cUrlName ) CLASS TWebview

   DEFAULT nTop:= 20 ,nLeft:= 0 ,nWidth := 320, nHeight := 460
      
   ::hWnd = CreateWebView(oWnd:hWnd , nTop, nLeft, nWidth, nHeight )
     
   ::SetURL( cUrlName )
   
  return Self   

//----------------------------------------------------------------------------//
METHOD Resources( oWnd, idResource, cUrlName ) CLASS TWebview
  
   ::hWnd = GetControlResource( oWnd:hWnd,idResource )  
   
   ::SetURL( cUrlName )
 
return Self  


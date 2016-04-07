


#ifndef __FIVEPHONE_CH
#define __FIVEPHONE_CH

#include "hbclass.ch"

#define bSETGET(x) { | u | If( PCount()==0, x, x:= u ) }

#xcommand DEFAULT <uVar1> := <uVal1> ;
               [, <uVarN> := <uValN> ] => ;
                  If( <uVar1> == nil, <uVar1> := <uVal1>, ) ;;
                [ If( <uVarN> == nil, <uVarN> := <uValN>, ); ]
	
//----------------------------------------------------------------------------
// PROGRESS 
	
#xcommand @ <nRow>, <nCol> PROGRESS <oPrg> ;
             [ <of: OF, WINDOW, DIALOG> <oWnd> ] ; 
             [ <pos: POS, POSITION> <nPos> ] ;          
             [ SIZE <nWidth>, <nHeight> ] ;
            => ;
          <oPrg> := TProgress():New( <oWnd> ,<nRow>, <nCol>, <nWidth>, <nHeight>, [<nPos>] )

#xcommand REDEFINE PROGRESS [<oPrg>] ;
             [ ID <nId> ];
             [ <pos: POS, POSITION> <nPos> ] ; 
             [ <of: OF, WINDOW, DIALOG> <oWnd> ] ;
       => ;
          [ <oPrg> := ] TProgress():Redefine( <oWnd>,<nId>,[<nPos>] )

//----------------------------------------------------------------------------
// SEGMENTED

#xcommand @ <nRow>, <nCol> SEGMENTED <oSegmented>  ;
             [ <ITEMS> <cItems,...> ] ;
             [ <of: OF, WINDOW, DIALOG> <oWnd> ] ;
             [ <change: ON CLICK, ON CHANGE> <uChange> ] ;
             [ SIZE <nWidth>, <nHeight> ] ;            
       => ;
          [ <oSegmented> := ] TSegment():New( <oWnd>, <nRow>, <nCol>, <nWidth>, <nHeight> ,;
           {<cItems>},<{uChange}> )
          
#xcommand @ REDEFINE SEGMENTED <oSegmented>  ;
             [ ID <nId> ];
             [ <ITEMS> <cItems,...> ] ;
             [ <of: OF, WINDOW, DIALOG> <oWnd> ] ;
             [ <change: ON CLICK, ON CHANGE> <uChange> ] ;                  
       => ;
          [ <oSegmented> := ] TSegment():Resources( <oWnd>,<nId>, {<cItems>},<{uChange}>  )      

//----------------------------------------------------------------------------
// TOOLBAR

#xcommand DEFINE TOOLBAR [ <oBar> ] ;
             [ STYLE <nStyle> ] ;
             [ <wnd: OF, WINDOW, DIALOG> <oWnd> ] ;          
      => ;
         [ <oBar> := ] TToolBar():New( <oWnd>, <nStyle> )

#xcommand REDEFINE TOOLBAR [ <oToolBar> ] ;
             [ ID <nId> ];
             [ <wnd: OF, WINDOW, DIALOG> <oWnd> ] ;          
      => ;
         [ <oToolBar> := ] TToolBar():Resources( <oWnd>, <nId> )
         
#xcommand DEFINE TBBUTTON ;
             [ OF <oToolBar> ] ;
             [ ACTION <uAction> ] ;
             [ PROMPT <xPrompt> ] ;          
       => ;
          <oToolBar>:AddButton( [<xPrompt>], [<{uAction}>]  )        
      

//----------------------------------------------------------------------------
// SAY  

#xcommand @ <nRow>, <nCol> SAY [ <oSay> <label: PROMPT,VAR > ] <cText> ;
             [ <dlg: OF,WINDOW,DIALOG > <oWnd> ] ;
             [ SIZE <nWidth>, <nHeight> ] ;
		     [ COLOR <nRed>, <nGreen>, <nBlue>, <nalfa> ] ;
			          => ;
          [ <oSay> := ] TLabel():New( <oWnd>, <{cText}>, <nRow>, <nCol>, <nWidth>, <nHeight>, <nRed>, <nGreen>, <nBlue>, <nalfa> )

#xcommand REDEFINE SAY [<oSay>] ;
             [ <label: PROMPT, VAR> <cText> ] ;
             [ ID <nId> ] ;
             [ <dlg: OF,WINDOW,DIALOG > <oWnd> ] ;
			 [ COLOR <nRed>, <nGreen>, <nBlue>, <nalfa> ] ;   
	      => ;
          [ <oSay> := ] TLabel():Resources( <oWnd> , <nId>, <{cText}>, <nRed>, <nGreen>, <nBlue>, <nalfa> )
		  
//----------------------------------------------------------------------------
// WINDOW  

#xcommand DEFINE WINDOW [<oWnd>] ;
           [ COLOR <nRed>, <nGreen>, <nBlue>, <nalfa> ] ;
          => ;
          [<oWnd> := ] TWindow():New(<nRed>, <nGreen>, <nBlue>, <nalfa> )
 

#xcommand ACTIVATE WINDOW <oWnd> ;
          => ;
          <oWnd>:Activate()    
    
//----------------------------------------------------------------------------
// IMAGE
    
  #xcommand @ <nRow>, <nCol> IMAGE [ <oImg> ] ;
             [ <resource: NAME, RESNAME, RESOURCE> <cResName> ] ;
             [ SIZE <nWidth>, <nHeight> ] ;
             [ <of: OF, WINDOW, DIALOG> <oWnd> ] ;   
             [ <lUrl: URL > ] ;	          
       => ;
          [ <oImg> := ] TImageView():New( <oWnd>, <cResName>, <nRow>, <nCol>, <nWidth>, <nHeight>, <.lUrl.>)
  
 #xcommand REDEFINE IMAGE [ <oImg> ] ;
             [ ID <nId> ] ;
             [ <of: OF, WINDOW, DIALOG> <oWnd> ] ;
             [ <resource: NAME, RESNAME, RESOURCE> <cResName> ] ;
       => ;
        [ <oImg> := ] TImageView():New( <oWnd>, <nId>, <cResName> )

 //----------------------------------------------------------------------------
// GET
     
  #xcommand @ <nRow>, <nCol> GET [ <oGet> VAR ] <xVar> ;  
               [ SIZE <nWidth>, <nHeight> ] ;
               [ <dlg: OF,WINDOW,DIALOG > <oWnd> ] ;
               [ ON CHANGE <uChange> ] ;
			    [ WHEN <uWhen> ] ;
			   [ VALID <uValid> ] ; 
			   [ <pict: PICT, PICTURE> <cPict> ] ;
               [ CUEBANNER <cCueText> ] ;
               [ <lPassword: PASSWORD > ] ;	
       => ;
         [ <oGet> := ] TGet():New( <oWnd>, bSETGET(<xVar>), <nRow>, <nCol>, <nWidth>,;
                                   <nHeight>, [\{||<uChange>\}], <cCueText>, <.lPassword.>,<cPict>,[\{||<uWhen>\}], [\{||<uValid>\}] ) 
  
   #xcommand REDEFINE GET [ <oGet> VAR ] <xVar> ;
               [ ID <nId> ] ; 
               [ <dlg: OF,WINDOW,DIALOG > <oWnd> ] ;
               [ ON CHANGE <uChange> ] ;
			   [ WHEN <uWhen> ] ;
			   [ VALID <uValid> ] ;
			   [ <pict: PICT, PICTURE> <cPict> ] ;
               [ CUEBANNER <cCueText> ] ;
               [ <lPassword: PASSWORD > ] ;	
       => ;
         [ <oGet> := ] TGet():Resources( <oWnd>, bSETGET(<xVar>), <nId>,;
                                   [\{||<uChange>\}], <cCueText>, <.lPassword.>,<cPict>, [\{||<uWhen>\}], [\{||<uValid>\}] ) 
                                    
             
 //----------------------------------------------------------------------------
// SLIDER
     
  #xcommand @ <nRow>, <nCol> SLIDER [ <oSlide> VAR ] <nVar> ;  
               [ RANGE <nMin>, <nMax> ] ;
               [ SIZE <nWidth>, <nHeight> ] ;
               [ <dlg: OF,WINDOW,DIALOG > <oWnd> ] ;
               [ ON CHANGE <uChange> ] ;
       => ;
         [ <oSlide> := ] TSlider():New( <oWnd>, <nRow>, <nCol>,;
               <nWidth>, <nHeight>, bSETGET(<nVar>), <nMin>, <nMax>, [\{|nVar|<uChange>\}] ) 
 
 
  #xcommand REDEFINE SLIDER [ <oSlide> VAR ] <nVar> ;
               [ ID <nId> ] ;
               [ RANGE <nMin>, <nMax> ] ;
               [ <dlg: OF,WINDOW,DIALOG > <oWnd> ] ;
               [ ON CHANGE <uChange> ] ;
       => ;
         [ <oSlide> := ] TSlider():Resources( <oWnd>, <nId>, bSETGET(<nVar>), <nMin>, <nMax>, [\{|nVar|<uChange>\}] ) 
 
 //----------------------------------------------------------------------------
// TIMER  
  
 #xcommand DEFINE TIMER [ <oTimer> ] ;
             [ INTERVAL <nInterval> ] ;
             [ ACTION <uAction,...> ] ;
             [ <of: OF, WINDOW, DIALOG> <oWnd> ] ;
       => ;
          [ <oTimer> := ] TTimer():New( <nInterval>, <oWnd>, [\{||<uAction>\}] )

 
 //----------------------------------------------------------------------------
// DIALOG-VIEW

#xcommand REDEFINE <od: DIALOG,VIEW > <oDlg> ;
             [ <resource: NAME, RESNAME, RESOURCE> <cResName> ] ;
             [ <of: WINDOW, DIALOG, OF> <oWnd> ] ;
          => ;
          <oDlg> = TView():Resources(oWnd,<cResName> )	
		
				  
#xcommand DEFINE <od:DIALOG,VIEW> <oDlg> ;
             [ FROM <nTop>, <nLeft> ] ;
             [ SIZE <nWidth>, <nHeight> ] ;
             [ <color: COLOR, COLORS> <nRed> ,<nGreen>,<nBlue>,<nAlfa> ] ;
             [ <of: WINDOW, DIALOG, OF> <oWnd> ] ;
	      => ;
          <oDlg> := TView():New( <oWnd>, <nTop>, <nLeft>, <nWidth>, <nHeight> , <nRed>, <nGreen>, <nBlue>, <nAlfa> ) 
		  

 //----------------------------------------------------------------------------
// TABS

#xcommand   DEFINE TABS [<oTabs>] ;
             [ <of: OF, WINDOW, DIALOG> <oWnd> ] ;
             [ <prm: PROMPT, PROMPTS, ITEMS> <cPrompt,...> ] ;
			 [ VIEWS <cView,...> ] ;
			 [ <act: ACTION, EXECUTE, ON CHANGE> <uAction> ] ;
             [ OPTION <nOption> ] ;
        => ;
           [<oTabs> := ] TTabBar():New( <oWnd>,;
             [\{<cPrompt>\}],[\{<cView>\}],[{|nOption,nOldOption|<uAction>}], ;
             <nOption> )

#xcommand REDEFINE TABS [<oTabs>] ;
             [ ID <nId> ] ;
             [ <of: OF, WINDOW, DIALOG> <oWnd> ] ;
			 [ VIEWS <cView,...> ] ;
			 [ <act: ACTION, EXECUTE> <uAction> ] ;
             [ OPTION <nOption> ] ;
        => ;
          [<oTabs> := ] TTabBar():Resources(  <oWnd>,<nId>,;
		   [\{<cView>\}],[{|nOption|<uAction>}], <nOption> )
		   
//----------------------------------------------------------------------------	   
// WEBVIEW

#xcommand   @ <nRow>, <nCol>  WEB [<oWeb>] ;
             [ <of: OF, WINDOW, DIALOG> <oWnd> ] ;
			 [ SIZE <nWidth>, <nHeight> ] ;   
			 [ URL <cUrl> ] ;
        => ;
           [<oWeb> := ] TWebView():New( <oWnd>, <nRow>, <nCol>, <nWidth>, <nHeight>, <cUrl> )

#xcommand REDEFINE WEB [<oWeb>] ;
             [ ID <nId> ] ;
             [ <of: OF, WINDOW, DIALOG> <oWnd> ] ;
			 [ URL <cUrl> ] ;
        => ;
          [<oWeb> := ] TWebView():Resources( <oWnd>,<nId>, <cUrl> )	   
		   
		   
 //----------------------------------------------------------------------------
// NAVBAR

#xcommand   DEFINE NAVBAR [<oNav>] ;
             [ <of: OF, WINDOW, DIALOG> <oWnd> ] ;
             [ TITLE <cTitle> ] ;
             [ BTNLEFT <cLeft>  [ ACTION <uActionL> ][<lback: BACK > ] ] ;
             [ BTNRIGHT <cRight>[ ACTION <uActionR> ][<lsearch: SEARCH > ] ] ;
             [ SIZE <nHeight> ] ;
			=> ;
   [<oNav> := ] TNavBar():New( <oWnd>, <cTitle>, <cLeft>, <cRight>, <nHeight>,;
   														 [<{uActionL}>],[<{uActionR}>],<.lback.>,<.lsearch.>);
   
 //----------------------------------------------------------------------------
// BROWSE

#xcommand  @  <nRow>, <nCol> LISTBOX [<oBrw>] ;
             [ FIELDS <Item>  ];
			 [ HEADS <aHeads> ] ; 
			 [ <of: OF, WINDOW, DIALOG> <oWnd> ] ;
           	 [ SIZE <nWidth>, <nHeight> ] ;
		   	 [ CELLHEIGHT <nCellHeight> ] ;
			 [ CELLSTYLE <nCellStyle>   ] ;
			 [ CELLACCESORY <nAccesory> ] ;
			 [ CELLCUSTOM <bcellCustom> ] ;
			 [ <lGroup: GROUP > ] ;			 
		  => ;
   [<oBrw> := ] TTableView():New( <oWnd>, <nRow>, <nCol>, <nWidth>, <nHeight>,<Item>,;
                      <aHeads>, <.lGroup.>,<nCellHeight>,[<{bcellCustom}>],<nCellStyle>,<nAccesory>)
   
#xcommand  @  <nRow>, <nCol> LISTBOX [<oBrw>] ;
             [ ITEMS <aItems> ] ;
			 [ HEADS <aHeads> ] ;
             [ <of: OF, WINDOW, DIALOG> <oWnd> ] ;
           	 [ SIZE <nWidth>, <nHeight> ] ;
		     [ CELLHEIGHT <nCellHeight> ] ;
			 [ CELLSTYLE  <nCellStyle>  ] ;
			 [ CELLACCESORY <nAccesory> ] ;
			 [ CELLCUSTOM <bcellCustom> ] ;
			 [ <lGroup: GROUP > ] ;			 
		  => ;
   [<oBrw> := ] TTableView():New( <oWnd>, <nRow>, <nCol>, <nWidth>, <nHeight>,;
								<aItems>,<aHeads>, <.lGroup.>, <nCellHeight>,[<{bcellCustom}>],<nCellStyle>,<nAccesory>)   
     

#xcommand REDEFINE LISTBOX [ <oBrw> ] ;             
             [ ID <nId> ] ;
             [ ITEMS <aItems> ] ;
             [ <of: OF, WINDOW, DIALOG> <oWnd> ] ;			
 	  => ;
   [<oBrw> := ] TTableView():Resources( <oWnd>,<nId>,<aItems> )             

 #xcommand REDEFINE LISTBOX [ <oBrw> ] ;             
             [ ID <nId> ] ;
             [ FIELD <Item> ] ;
			 [ <of: OF, WINDOW, DIALOG> <oWnd> ] ;
 	  => ;
   [<oBrw> := ] TTableView():Resources( <oWnd>,<nId>,<{Item}> )               
 
 
 #xcommand DEFINE CELLVIEW [<oCell>] ;
             [ STYLE <nStyle> ] ;
             [ ACESSORY <nStyleAcessory> ];
             [ DETAIL <cDetailText> ];
     	  => ;
   [<oCell> := ] TTableViewCell():New( <nStyle>, <nStyleAcessory>, <cDetailText> )                 
 
 
            
#endif


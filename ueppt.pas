﻿unit ueppt;

interface
 uses Contnrs, IdAntiFreezeBase, IdAntiFreeze, IdBaseComponent, IdComponent, IdTCPConnection,IdURI,
  IdTCPClient, IdHTTP, IdSSLOpenSSL, SysUtils, Classes, NativeXML, SuperObject, dialogs;
 // name2code ?
 // code2name ?
 // code2prefname

 type
  TeppoElem = class
   fname : string;
   flang : string;
   fpref : boolean;
   fcode: string;
   fauth: string;
   fstatuscode : Boolean;
   fstatusname : Boolean;
   fnameID:integer;
  public
   property Code:String read fcode write fcode;
   property Name:String read fname write fname;
   property Pref:Boolean read fpref write fpref;
   property Lang:String read flang write flang;
   property Auth:string read fauth write fauth;
   property StatusCode:Boolean read fstatuscode write fstatuscode;
   property StatusName:Boolean read fstatusname write fstatusname;
   property NameID:integer read fnameID write fnameID;
  end;

  TeppoElems = class(TObjectList)
  private
    fauthent:string;
    fidhttp:TIdHTTP;
    fIdSSLIOHandler:TIdSSLIOHandlerSocketOpenSSL;
    furl:string;
    procedure fillFromURL(url:string);
  public
    property authent:string read fauthent write fauthent;
    property url:string read furl write furl;
    procedure code2name(code:string);
    procedure name2code(name:string);
    function getelem(idx:integer):TeppoElem;
    function getEPPODataForCode(eppocode, requeststring:string):boolean;
    constructor Create(AOwnsObjects:boolean);
    destructor Destroy;override;
  end;

const
    EDSURL = 'https://data.eppo.int/api/rest/1.0';
    EDSAuthentication = 'authtoken=bcc7f081187a002ab252027b513ed132';

implementation
 uses strutils;
//*********************************************************************************************************************

{ TeppoElems }


procedure TeppoElems.code2name(code: string);
begin
   fillFromURL('http://eppt.eppo.org/ws/code2name.php?code='+uppercase(code));
  //getEPPODataForCode(code,'/names');
end;

//*********************************************************************************************************************

procedure TeppoElems.name2code(name: string);
begin
 fillFromURL('http://eppt.eppo.org/ws/name2code.php?fullname='+name);
end;

//*********************************************************************************************************************

constructor TeppoElems.Create(AOwnsObjects:boolean);
begin
  inherited Create(AOwnsObjects);
  fidhttp:=TIdHTTP.Create(nil);
  fIdSSLIOHandler:=TIdSSLIOHandlerSocketOpenSSL.Create(nil);
end;

//*********************************************************************************************************************

destructor TeppoElems.Destroy;
begin
 FreeAndNil(fidhttp);
 FreeAndNil(fIdSSLIOHandler);
// FreeAndNil(fidhttpfreeze);
 inherited Destroy;
end;

procedure TeppoElems.fillFromURL(url:string);
var e:TeppoElem;
    Stream:TMemoryStream;
    AXml: TNativeXml;
    ANode : TXmlNode;
    lst:TList;
    i:integer;
begin
try
 url:=AnsiReplaceText(url,' ','+');
 Clear;
 Stream:=TMemoryStream.Create;
 lst:=TList.Create;
 AXml:=TNativeXml.Create;
 fidhttp.Get(url,Stream);
 Stream.Position:=0;
 AXml.LoadFromStream(Stream);
 AXml.Root.FindNodes('item',lst);
 if lst<>nil then
  for I := 0 to lst.Count - 1 do
  begin
   ANode:=TXmlNode(lst[i]);
   e:=TeppoElem.Create;
   e.Code:=ANode.NodeByName('Code').ValueAsString;
   e.Name:=ANode.NodeByName('fullname').ValueAsString;
   if not (ANode.NodeByName('author')=nil) then e.Auth:=ANode.NodeByName('author').ValueAsString;
   e.Pref:=ANode.NodeByName('pref').ValueAsString='true';
   e.Lang:=ANode.NodeByName('lang').ValueAsString;
   e.StatusCode:=ANode.NodeByName('statuscode').ValueAsString='A';
   e.StatusName:=ANode.NodeByName('statusname').ValueAsString='A';
   Self.Add(e);
  end
  else
    ShowMessage(lst.ToString);
finally
 if Assigned(lst) then
 lst.Free;
 if Assigned(Stream) then
 Stream.Free;
 if Assigned(AXml) then
 AXml.Free;
end;
end;

//*********************************************************************************************************************
function TeppoElems.getEPPODataForCode(eppocode, requeststring:string):boolean;
var Stream:TStringStream; slist:Tstringlist;
    e:TeppoElem;
    i, respcode:integer;
    paramstr: string;
    AUnicodeString:String;
    //https://data.eppo.int/api/rest/1.0/taxon/BEMITA?authtoken=xxxxxxxxxxxxxxxxxxx
    EPPOData, objJP:ISuperObject;
begin
  furl:=AnsiReplaceText(EDSURL,' ','+');
  fauthent:=EDSAuthentication;
  Clear;
  Stream:=TStringStream.Create;
  fIdhttp.HandleRedirects:= true;
  //fIdhttp.ReadTimeout:= 50000;
  fIdhttp.request.Connection:= 'keep-alive';
  fIdhttp.IOHandler:= fIdSSLIOHandler;
  fIdHTTP.HTTPOptions:=[];
  paramstr:= TIdURI.URLEncode(furl+'/taxon/'+uppercase(eppocode)+requeststring+'?'+fauthent);
  //objJP:=SO('{"hiragana":"にほんご","kanji":"日本語"}');
  try
    fidhttp.Get(paramstr,Stream);
    respcode:=fIdHTTP.ResponseCode;
    if respcode=200 then
    begin
      AUnicodeString:=TIdURI.URLDecode(Stream.DataString);
      EPPOData := SO(AUnicodeString);
      for i := 0 to EPPOData.AsArray.Length - 1 do
      begin
        e:=TeppoElem.Create;
        e.code:=eppocode;
        e.NameID:=EPPOData.AsArray[i].I['nameid'];
        e.Name:=EPPOData.AsArray[i].S['fullname'];
        e.Pref:=EPPOData.AsArray[i].B['preferred'];
        e.Lang:=EPPOData.AsArray[i].S['isolang'];
        e.Auth:=EPPOData.AsArray[i].S['author'];
        Self.Add(e);
      end;
      Result:= true;
    end;
    except on E: Exception do
    begin
      Result := false;
    end;
  end;
  EPPOData:=nil;
  slist.Free;
  Stream.Free;
end;
//*******************************************************************************************************************

function TeppoElems.getelem(idx: integer): TeppoElem;
begin
 result:=TeppoElem(Items[idx]);
end;
//*********************************************************************************************************************

end.

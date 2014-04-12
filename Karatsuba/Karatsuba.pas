unit Karatsuba;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Math, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Memo1: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    function Karatsuba( u, v, n: Extended):Extended;
    function Multiplica ( u, v, n: Extended):Extended;
    function Multiplica2(u, v: Extended ): Extended;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

{ TForm1 }

function TForm1.Karatsuba(u, v, n: Extended): Extended;
var
  k, a, b, c, d: Extended;
  ac, bd, y, x, p, p2: Extended;
begin
  x := 0;
  y := 0;
  if n <= 3 then
    Result := u * v
  else
  begin
    k :=  n / 2 ;
    p := Power(10, k);
    a := Trunc( u / p ) ;
    b := ( ( u / p ) -  Trunc( u / p ) )*p;
//    if b <= 0 then
//       b := p;
    c := Trunc( v / p ) ;
    d := ( ( v / p ) -  Trunc( v / p ) )*p;
//        if d <= 0 then
//       d := p;

    ac := Karatsuba(a, c, k);
    bd := Karatsuba(b, d, k);
    y :=  Karatsuba(a + b, c + d, K + 1);
    p2 := Power(10, 2*k);
    x := ac * p2 + (y - ac - bd) * p + bd;
    Result := x;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  count : Extended;
begin
  count := GetTickCount;
  Memo1.Lines.Add('========Karatsuba===========');
  Memo1.Lines.Add('Resultado: ' +  FormatFloat('###########', Karatsuba(StrToFloat(Edit1.Text),
                                   StrToFloat(Edit2.Text), StrToFloat(Edit3.Text))));
  sleep(100);
  count := GetTickCount - count;
  Memo1.Lines.Add('Tempo: ' + FormatFloat('0.###################s', ( count / 1000 )));
  Memo1.Lines.Add('');
  Memo1.Lines.Add('');


  count := GetTickCount;
  Memo1.Lines.Add('========Multiplica===========');
  Memo1.Lines.Add('Resultado: ' +  FormatFloat('###########',Multiplica2( StrToFloat(Edit1.Text),
                                   StrToFloat(Edit2.Text))));
  sleep(100);
  count := GetTickCount - count;
  Memo1.Lines.Add('Tempo: ' + FormatFloat('0.###################s', ( count / 1000 )));

  Memo1.Lines.Add('');
  Memo1.Lines.Add('');


  {  ShowMessage('Resultado:' +
   FormatFloat('###########', Karatsuba(StrToFloat(Edit1.Text),
                             StrToFloat(Edit2.Text), StrToFloat(Edit3.Text)))); }
{  ShowMessage('Resultado:' +
   FormatFloat('###########', Multiplica(StrToFloat(Edit1.Text),
                             StrToFloat(Edit2.Text), StrToFloat(Edit3.Text))));
}
end;

function TForm1.Multiplica(u, v, n: Extended): Extended;
var
   k, a, b, c, d: Extended;
   ac, bd, bc, ad, x, p, p2: Extended;
begin
  if n <= 1 then
    Result := u * v
  else
  begin
    k :=  n / 2 ;
    p := Power(10, k);
    a := Trunc( u / p ) ;
    b := ( ( u / p ) -  Trunc( u / p ) )*p;
    c := Trunc( v / p ) ;
    d := ( ( v / p ) -  Trunc( v / p ) )*p;
    ac := Multiplica( a, c, k );
    bd := Multiplica( b, d, k );
    ad := Multiplica( a, d, k );
    bc := Multiplica(b, c, k);
    p2 := Power(10, 2*k);
    x := ac * p2 + ( ad + bc ) * p + bd;
    Result := x;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  count : Longint;

begin
  count := GetTickCount;
  Memo1.Lines.Add('========Multiplica===========');
  Memo1.Lines.Add('Resultado: ' +  FormatFloat('###########', Multiplica(StrToFloat(Edit1.Text),
                                   StrToFloat(Edit2.Text), StrToFloat(Edit3.Text))));
  count := GetTickCount - count;

  Memo1.Lines.Add('Tempo: ' + FormatFloat('0.###################s', (count / 1000 )));

  Memo1.Lines.Add('');
  Memo1.Lines.Add('');

end;

function TForm1.Multiplica2(u, v: Extended ): Extended;
var
  soma:Extended ;
  i :Extended;
begin
  Soma := 0;
  i := 0;
  while i < v do
  begin
    soma := soma + u;
    i := i + 1;
  end;
  Result := Soma;
end;

end.

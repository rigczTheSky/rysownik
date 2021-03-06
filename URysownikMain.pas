unit URysownikMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtDlgs, Vcl.ExtCtrls,
  Vcl.StdCtrls, Samples.Spin, Vcl.Imaging.jpeg, Vcl.ComCtrls, vcl.Buttons;

type
  TForm1 = class(TForm)
    OpenPictureDialog1: TOpenPictureDialog;
    ColorDialog1: TColorDialog;
    ScrollBox1: TScrollBox;
    Image1: TImage;
    Panel2: TPanel;
    SpeedButton1: TSpeedButton;
    BitBtn1: TBitBtn;
    Panel1: TPanel;
    RadioGroup1: TRadioGroup;
    Edit1: TEdit;
    BitBtn2: TBitBtn;
    UpDown1: TUpDown;
    Edit2: TEdit;
    RadioGroup2: TRadioGroup;
    Memo1: TMemo;
    Image2: TImage;
    procedure SpeedButton1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  rys: boolean;
  xp,yp:integer;
  xt,yt:integer;
implementation

{$R *.DFM}

procedure TForm1.SpeedButton1Click(Sender: TObject);
var
 proc : TMouseEvent;
begin
 proc := Image1.OnMouseDown;
 Image1.OnMouseDown := nil;
 if OpenPictureDialog1.Execute then
 begin
  Image2.Picture.LoadFromFile(OpenPictureDialog1.FileName);
  Image1.Picture.Bitmap.Assign(Image2.Picture.Graphic);
 end;
 Image1.OnMouseDown := proc;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
 Image1.Canvas.MoveTo(50,80);
 Image1.Canvas.LineTo(150,80);
end;

procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 rys:=true;
 with Image1.Canvas do
 begin
        Pen.Mode:=pmCopy;
      if RadioGroup1.ItemIndex=0 then
       Pen.Style:=pssolid
      else
       if RadioGroup1.ItemIndex=1 then
        Pen.Style:=psdot
       else
        Pen.Style:=psdash;
  Pen.Mode:=pmNotXor;
  Pen.Width:=UpDown1.Position;
  Pen.Color:=Panel1.Color;

  MoveTo(x,y);
  xp:=x;
  yp:=y;
  xt:=x;
  yt:=y;
 end;
end;

procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 with Image1.Canvas do
 if rys then
 begin
 Memo1.Clear;
 Memo1.Lines.Add('Wsp??rz?dna x:'+ intToStr(x)+', wsp??rz?dna y: '+intToStr(y));

   if RadioGroup2.ItemIndex=0 then
    begin
     MoveTo(xp,yp);
     LineTo(xt,yt);
    end
     else
      if RadioGroup2.ItemIndex=1 then
        Ellipse(xp,yp,xt,yt)
       else
       if RadioGroup2.ItemIndex=2 then
         Rectangle(xp,yp,xt,yt)
      else if RadioGroup2.ItemIndex = 3 then
      begin
        MoveTo(xp, yp);
        LineTo(xt, yt);
        MoveTo(xt, yt);
        LineTo(2 * xp - xt, yt);
        MoveTo(xp, yp);
        LineTo(2 * xp - xt, yt)
      end;


    if RadioGroup2.ItemIndex=0 then
    begin
     MoveTo(xp,yp);
     LineTo(x,y);
    end
     else
      if RadioGroup2.ItemIndex=1 then
        Ellipse(xp,yp,x,y)
       else
       if RadioGroup2.ItemIndex=2 then
        Rectangle(xp,yp,x,y)
          else if RadioGroup2.ItemIndex = 3 then
      begin
        MoveTo(xp, yp);
        LineTo(X, Y);
        MoveTo(X, Y);
        LineTo(2 * xp - X, Y);
        MoveTo(xp, yp);
        LineTo(2 * xp - X, Y)
      end;
    xt:=x;
    yt:=y;

 end;

end;

procedure TForm1.Image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if rys then
  begin
    with Image1.Canvas do
    begin
      // czesc - na razie wyglada na bezuzyteczna

      if RadioGroup2.ItemIndex = 0 then
      begin
        MoveTo(xp, yp);
        LineTo(xt, yt);
      end
      else if RadioGroup2.ItemIndex = 1 then
        Ellipse(xp, yp, xt, yt)
      else if RadioGroup2.ItemIndex = 2 then
        Rectangle(xp, yp, X, Y)
      else if RadioGroup2.ItemIndex = 3 then
      begin
        MoveTo(xp, yp);
        LineTo(xt, yt);
        MoveTo(xt, yt);
        LineTo(2 * xp - xt, yt);
        MoveTo(xp, yp);
        LineTo(2 * xp - xt, yt)
      end;

      Pen.Mode := pmCopy;
      if RadioGroup1.ItemIndex = 0 then
        Pen.Style := pssolid
      else if RadioGroup1.ItemIndex = 1 then
        Pen.Style := psdot
      else
        Pen.Style := psdash;

      // czesc od rysowania
      if RadioGroup2.ItemIndex = 0 then
      begin
        MoveTo(xp, yp);
        LineTo(X, Y);
      end
      else if RadioGroup2.ItemIndex = 1 then
        Ellipse(xp, yp, X, Y)
      else if RadioGroup2.ItemIndex = 2 then
        Rectangle(xp, yp, X, Y)
      else if RadioGroup2.ItemIndex = 3 then
      begin
        MoveTo(xp, yp);
        LineTo(X, Y);
        MoveTo(X, Y);
        LineTo(2 * xp - X, Y);
        MoveTo(xp, yp);
        LineTo(2 * xp - X, Y)
      end;
    end;
    rys := false;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
 rys:=false;
 Image1.Canvas.Brush.Color:=clWhite;
 Image1.Canvas.Brush.Style := bsSolid;
 Image1.Picture.Bitmap.Free;
// Image1.Width := 600;
// Image1.Height := 400;
 Image1.Picture.Bitmap := TBitmap.Create(600,400);
 Memo1.Lines.Add(Image1.Width.ToString + ' ' + Image1.Height.ToString);
 Image1.Canvas.FillRect(Rect(0,0,Image1.Width, Image1.Height));
end;

procedure TForm1.Panel1Click(Sender: TObject);
begin
 if ColorDialog1.Execute then
 begin
  Panel1.Color := ColorDialog1.Color
 end;
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
 {
 Image1.Picture.Bitmap.Canvas.Font.Name:='Times New Roman';
 Image1.Picture.Bitmap.Canvas.Font.Size:=24;
 Image1.Picture.Bitmap.Canvas.Brush.Style := bsclear;
 Image1.Picture.Bitmap.Canvas.TextOut(10,10,Edit1.Text);
  }
 Image1.Canvas.Font.Name:='Times New Roman';
 Image1.Canvas.Font.Size:=24;
 Image1.Canvas.Brush.Style := bsclear;
 Image1.Canvas.TextOut(10,10,Edit1.Text);
end;

end.
